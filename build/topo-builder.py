#!/usr/bin/env python3

from platform import mac_ver
from ruamel.yaml import YAML
from time import sleep
from os.path import exists
from os import makedirs, getcwd
import argparse


BASE_PATH = getcwd()
CONFIGS = BASE_PATH + "/configs"
CEOS_NODES = BASE_PATH + "/nodes"
CEOS_SCRIPTS = BASE_PATH + "/scripts"
sleep_delay = 30
NOTIFY_BASE = 1250
VETH_PAIRS = []
CEOS = {}
HOSTS = {}
# Setting inotify value to 40 times EOS base value
NOTIFY_ADJUST = """
sudo sh -c 'echo "fs.inotify.max_user_instances = {notify_instances}" > /etc/sysctl.d/99-zceos.conf'
sudo sysctl -w fs.inotify.max_user_instances={notify_instances}
""".format(
    notify_instances = (NOTIFY_BASE * 40)
)

class CEOS_NODE():
    def __init__(self, node_name, node_ip, node_sys_mac, node_neighbors, _tag, image):
        self.name = node_name
        self.ip = node_ip
        self.tag = _tag.lower()
        self.image = image
        self.ceos_name = self.tag + self.name
        self.intfs = {}
        self.portMappings(node_neighbors)
        self.system_mac = node_sys_mac

    def portMappings(self, node_neighbors):
        """
        Function to create port mappings.
        """
        for intf in node_neighbors:
            lport = parseNames(intf['port'])
            rport = parseNames(intf['neighborPort'])
            rneigh = parseNames(self.tag + intf['neighborDevice'])
            _vethCheck = checkVETH('{0}{1}'.format(self.ceos_name, lport['code']), '{0}{1}'.format(rneigh['name'], rport['code']))
            if _vethCheck['status']:
                pS("OK", "VETH Pair {0} will be created.".format(_vethCheck['name']))
                VETH_PAIRS.append(_vethCheck['name'])
            self.intfs[intf['port']] = {
                'veth': _vethCheck['name'],
                'port': lport['code']
            }

class HOST_NODE():
    def __init__(self, node_name, node_ip, node_mask, node_gw, node_neighbors, _tag, image):
        self.name = node_name
        self.ip = node_ip
        self.mask = node_mask
        self.gw = node_gw
        self.tag = _tag.lower()
        self.c_name = self.tag + self.name
        self.image = image
        self.ceos_name = self.tag + self.name
        self.intfs = {}
        self.portMappings(node_neighbors)
    def portMappings(self, node_neighbors):
        """
        Function to create port mappings.
        """
        for intf in node_neighbors:
            lport = parseNames(intf['port'])
            rport = parseNames(intf['neighborPort'])
            rneigh = parseNames(self.tag + intf['neighborDevice'])
            _vethCheck = checkVETH('{0}{1}'.format(self.ceos_name, lport['code']), '{0}{1}'.format(rneigh['name'], rport['code']))
            if _vethCheck['status']:
                pS("OK", "VETH Pair {0} will be created.".format(_vethCheck['name']))
                VETH_PAIRS.append(_vethCheck['name'])
            self.intfs[intf['port']] = {
                'veth': _vethCheck['name'],
                'port': lport['code']
            }

def openTopo(topo):
    try:
        tmp_topo = open(BASE_PATH + "/topologies/{}.yaml".format(topo), 'r')
        tmp_yaml = YAML().load(tmp_topo)
        tmp_topo.close()
        return(tmp_yaml)
    except:
        return(False)

def parseNames(devName):
    """
    Function to parse and consolidate name.
    """
    alpha = ''
    numer = ''
    for char in devName:
        if char.isalpha():
            alpha += char
        elif char.isdigit():
            numer += char
        elif char == "/":
            numer += "_"
    if 'ethernet'in devName.lower():
        dev_name = 'et{0}'.format(numer)
    else:
        dev_name = devName
    devInfo = {
        'name': devName,
        'code': dev_name
    }
    return(devInfo)

def checkVETH(dev1, dev2):
    """
    Function to check veth pairs
    """
    global VETH_PAIRS
    _addVETH = True
    veth_name = '{0}-{1}'.format(dev1, dev2)
    for _veth in VETH_PAIRS:
        if dev1 in _veth and dev2 in _veth:
            _addVETH = False
            return({
                'status': _addVETH,
                'name': _veth
            })
    return({
        'status': _addVETH,
        'name': veth_name
    })
        
def checkDir(path):
    """
    Function to check if a destination directory exists.
    """
    if not exists(path):
        try:
            makedirs(path)
            return(True)
        except:
            return(False)
    else:
        return(True)


def createMac(dev_id):
    """
    Function to build dev specific MAC Address.
    """
    if dev_id < 10:
        return('b{0}'.format(dev_id))
    elif dev_id >= 10 and dev_id < 20:
        return('c{0}'.format(dev_id - 10))
    elif dev_id >=20 and dev_id < 30:
        return('d{0}'.format(dev_id - 20))

def pS(mstat,mtype):
    """
    Function to send output from service file to Syslog
    """
    mmes = "\t" + mtype
    print("[{0}] {1}".format(mstat,mmes.expandtabs(7 - len(mstat))))

def main(args):
    """
    Main Function to build out cEOS files.
    """
    create_output = []
    startup_output = []
    stop_output = []
    delete_output = []
    delete_net_output = []
    container_runtime = args.runtime.lower()
    topo_yaml = openTopo(args.topo)
    create_startup = args.startup
    container_registry = topo_yaml['images']['registry']
    ceos_image = topo_yaml['images']['ceos']
    host_image = topo_yaml['images']['host']
    _tag = topo_yaml['topology']['name']
    nodes = topo_yaml['nodes']
    hosts = topo_yaml['hosts']
    _ceos_script_location = "{0}/{1}".format(CEOS_SCRIPTS, _tag)
    _tfa_version = 1
    BASE_TERMINATTR = """
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr={0}:9910 -taillogs -cvcompression=gzip -cvauth=key,{1} -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -ingestexclude=/Sysdb/cell/1/agent,/Sysdb/cell/2/agent
   no shutdown
!
    """
    BASE_TERMINATTR_VRF = """
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr={0}:9910 -cvvrf={2} -taillogs -cvcompression=gzip -cvauth=key,{1} -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -ingestexclude=/Sysdb/cell/1/agent,/Sysdb/cell/2/agent
   no shutdown
!
    """
    BASE_MGMT = """
vrf instance {2}
interface Management0
   description Management
   ip address {0}/24
!
ip routing
!
!
management api http-commands
   no shutdown
!
    """
    BASE_MGMT_VRF = """
vrf instance {2}
interface Management0
   description Management
   vrf {2}
   ip address {0}/24
!
ip routing
!
ip route vrf {2} 0.0.0.0/0 {1}
!
management api http-commands
   no shutdown
   vrf {2}
      no shutdown
!
    """
    BASE_STARTUP = """
service routing protocols model multi-agent
!
schedule tech-support interval 60 timeout 30 max-log-files 5 command show tech-support
!
hostname {0}
!
    """
    # Perform check on Container Runtime
    if container_runtime == "docker":
        pS("INFO", "Docker will be orchestrating the cEOS topology")
        cnt_cmd = "docker"
    else:
        pS("INFO", "Podman will be orchestrating the cEOS topology")
        cnt_cmd = "sudo podman"

    if create_startup:
        pS("INFO", "Bare Startup config will be created for all cEOS nodes")
    # Perform check on container registry option
    if container_registry == "local":
        registry_cmd = ""
        pS("INFO", "Local host registry will be leveraged for container iamges.")
    else:
        registry_cmd = f"{container_registry}/"
        pS("INFO", f"{container_registry} will be leverated for container images.")
    # Check for mgmt Bridge
    try:
        mgmt_network = topo_yaml['infra']['bridge']
        if not mgmt_network:
            pS("INFO", "No mgmt bridge specified. Creating isolated network.")
    except KeyError:
        pS("INFO", "No mgmt bridge specified. Creating isolated network.")
        mgmt_network = False
    # Check for vrf
    try:
        mgmt_vrf = topo_yaml['infra']['vrf']
        if not mgmt_vrf:
            pS("INFO", "No mgmt VRF specified. Creating network in default VRF.")
    except KeyError:
        pS("INFO", "No mgmt VRF specified. Creating network in default VRF.")
        mgmt_vrf = "default"
    # Check for TFA Version
    try:
        _tfa_version = topo_yaml['topology']['vforward']
        if _tfa_version > 1:
            pS("INFO", "Leveraging ArFA forwarding agent")
        else:
            pS("INFO", "Leveraging default dataplane")
    except:
        pS("INFO", "Leveraging default dataplane")

    # Load cEOS nodes specific information
    for _node in nodes:
        try:
            _node_ip = _node['ip_addr']
        except KeyError:
            _node_ip = ""
        _node_name = list(_node.keys())[0]
        CEOS[_node_name] = CEOS_NODE(_node_name, _node_ip, _node['mac'], _node['neighbors'], _tag, ceos_image)
    # Load Host nodes specific information
    if hosts:
        for _host in hosts:
            _host_name = list(_host.keys())[0]
            HOSTS[_host_name] = HOST_NODE(_host_name, _host['ip_addr'], _host['mask'], _host['gateway'], _host['neighbors'], _tag, host_image)
    # Check for output directory
    if checkDir(_ceos_script_location):
        pS("OK", "Directory is present now.")
    else:
        pS("iBerg", "Error creating directory.")
    create_output.append("#!/bin/bash\n")
    create_output.append(NOTIFY_ADJUST)
    # Check for container images are present in local registry deployment
    if container_registry == "local":
        create_output.append(f"if [ \"$({cnt_cmd} image ls | grep ceosimage | grep -c {ceos_image})\" == 0 ]\n")
        create_output.append(f"then\n    echo \"{container_runtime.capitalize()} image not found for ceosimage:{ceos_image}, please build it first.\"\n    exit\nfi\n")
        create_output.append(f"if [ \"$({cnt_cmd} image ls | grep chost | grep -c {host_image})\" == 0 ]\n")
        create_output.append(f"then\n    echo \"{container_runtime.capitalize()} image not found for chost:{host_image}, please build it first.\"\n    exit\nfi\n")
    else:
        create_output.append(f"echo \"{registry_cmd} will be leveraged for cEOS and cHost images\"\n")
    create_output.append(f"sudo ip netns add {_tag}\n")
    startup_output.append("#!/bin/bash\n")
    startup_output.append(NOTIFY_ADJUST)
    stop_output.append("#!/bin/bash\n")
    delete_output.append("#!/bin/bash\n")
    startup_output.append(f"sudo ip netns add {_tag}\n")
    delete_net_output.append(f"sudo ip netns delete {_tag}\n")
    # Get the veths created
    create_output.append("# Creating veths\n")
    for _veth in VETH_PAIRS:
        _v1, _v2 = _veth.split("-")
        create_output.append(f"sudo ip link add {_v1} type veth peer name {_v2}\n")
        startup_output.append(f"sudo ip link add {_v1} type veth peer name {_v2}\n")
        delete_output.append(f"sudo ip link delete {_v1} type veth peer name {_v2}\n")
    create_output.append("#\n#\n# Creating anchor containers\n#\n")
    # Create initial cEOS anchor containers
    create_output.append("# Checking to make sure topo config directory exists\n")
    create_output.append(f'if ! [ -d "{CONFIGS}/{_tag}" ]; then mkdir {CONFIGS}/{_tag}; fi\n')
    for _node in CEOS:
        # Add in code to perform check in configs directory and create a basis for ceos-config
        create_output.append("# Checking for configs directory for each cEOS node\n")
        create_output.append(f'if ! [ -d "{CONFIGS}/{_tag}/{_node}" ]; then mkdir {CONFIGS}/{_tag}/{_node}; fi\n')
        create_output.append("# Creating the ceos-config file.\n")
        create_output.append(f'echo "SERIALNUMBER={CEOS[_node].ceos_name}" > {CONFIGS}/{_tag}/{_node}/ceos-config\n')
        create_output.append(f'echo "SYSTEMMACADDR={CEOS[_node].system_mac}" >> {CONFIGS}/{_tag}/{_node}/ceos-config\n')
        if _tfa_version > 1:
            create_output.append('echo "TFA_VERSION={0}" >> {1}/{2}/{3}/ceos-config\n'.format(_tfa_version, CONFIGS, _tag, _node))
        # Perform check to see if a bare startup-config needs to be created
        if create_startup:
            create_output.append(f"# Creating a bare startup configuration for {_node}\n")
            _tmp_startup = []
            _tmp_startup.append(BASE_STARTUP.format(CEOS[_node].ceos_name))
            if mgmt_network:
                if mgmt_vrf != "default":
                    _tmp_startup.append(BASE_MGMT_VRF.format(CEOS[_node].ip, topo_yaml['infra']['gateway'], mgmt_vrf))
                else:    
                    _tmp_startup.append(BASE_MGMT.format(CEOS[_node].ip, topo_yaml['infra']['gateway']))
                if 'cvpaddress' and 'cvp-key' in topo_yaml['topology']:
                    if mgmt_vrf != "default":
                        _tmp_startup.append(BASE_TERMINATTR_VRF.format(topo_yaml['topology']['cvpaddress'], topo_yaml['topology']['cvp-key'], mgmt_vrf))
                    else:
                        _tmp_startup.append(BASE_TERMINATTR.format(topo_yaml['topology']['cvpaddress'], topo_yaml['topology']['cvp-key']))
            create_output.append('echo "{0}" > {1}/{2}/{3}/startup-config\n'.format(''.join(_tmp_startup), CONFIGS, _tag, _node))
        # Creating anchor containers
        create_output.append("# Getting {0} nodes plumbing\n".format(_node))
        create_output.append(f"{cnt_cmd} run -d --restart=always --log-opt max-size=10k --name={CEOS[_node].ceos_name}-net --net=none busybox /bin/init\n")
        startup_output.append(f"{cnt_cmd} start {CEOS[_node].ceos_name}-net\n")
        create_output.append(f"{CEOS[_node].ceos_name}pid=$({cnt_cmd} inspect --format '{{{{.State.Pid}}}}' {CEOS[_node].ceos_name}-net)\n")
        create_output.append(f"sudo ln -sf /proc/${{{CEOS[_node].ceos_name}pid}}/ns/net /var/run/netns/{CEOS[_node].ceos_name}\n")
        # Stop cEOS containers
        startup_output.append(f"{cnt_cmd} stop {CEOS[_node].ceos_name}\n")
        stop_output.append(f"{cnt_cmd} stop {CEOS[_node].ceos_name}\n")
        stop_output.append(f"{cnt_cmd} stop {CEOS[_node].ceos_name}-net\n")
        delete_output.append(f"{cnt_cmd} stop {CEOS[_node].ceos_name}\n")
        delete_output.append(f"{cnt_cmd} stop {CEOS[_node].ceos_name}-net\n")
        # Remove cEOS containers
        startup_output.append(f"{cnt_cmd} rm {CEOS[_node].ceos_name}\n")
        delete_output.append(f"{cnt_cmd} rm {CEOS[_node].ceos_name}\n")
        delete_output.append(f"{cnt_cmd} rm {CEOS[_node].ceos_name}-net\n")
        delete_net_output.append(f"sudo rm -rf /var/run/netns/{CEOS[_node].ceos_name}\n")
        startup_output.append(f"{CEOS[_node].ceos_name}pid=$({cnt_cmd} inspect --format '{{{{.State.Pid}}}}' {CEOS[_node].ceos_name}-net)\n")
        startup_output.append(f"sudo ln -sf /proc/${{{CEOS[_node].ceos_name}pid}}/ns/net /var/run/netns/{CEOS[_node].ceos_name}\n")
        create_output.append(f"# Connecting cEOS containers together\n")
        # Output veth commands
        for _intf in CEOS[_node].intfs:
            _tmp_intf = CEOS[_node].intfs[_intf]
            if _node in  _tmp_intf['veth'].split('-')[0]:
                create_output.append(f"sudo ip link set {_tmp_intf['veth'].split('-')[0]} netns {CEOS[_node].ceos_name} name {_tmp_intf['port']} up\n")
                startup_output.append(f"sudo ip link set {_tmp_intf['veth'].split('-')[0]} netns {CEOS[_node].ceos_name} name {_tmp_intf['port']} up\n")
            else:
                create_output.append(f"sudo ip link set {_tmp_intf['veth'].split('-')[1]} netns {CEOS[_node].ceos_name} name {_tmp_intf['port']} up\n")
                startup_output.append(f"sudo ip link set {_tmp_intf['veth'].split('-')[1]} netns {CEOS[_node].ceos_name} name {_tmp_intf['port']} up\n")
            # Perform check if mgmt network is available
        if mgmt_network:
            # Get MGMT VETHS
            create_output.append(f"sudo ip link add {CEOS[_node].ceos_name}-eth0 type veth peer name {CEOS[_node].ceos_name}-mgmt\n")
            create_output.append(f"sudo brctl addif {mgmt_network} {CEOS[_node].ceos_name}-mgmt\n")
            create_output.append(f"sudo ip link set {CEOS[_node].ceos_name}-eth0 netns {CEOS[_node].ceos_name} name eth0 up\n")
            create_output.append(f"sudo ip link set {CEOS[_node].ceos_name}-mgmt up\n")
            create_output.append("sleep 1\n")
            if container_runtime == "docker":
                create_output.append(f"{cnt_cmd} run -d --name={CEOS[_node].ceos_name} --log-opt max-size=1m --net=container:{CEOS[_node].ceos_name}-net --ip {CEOS[_node].ip} --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v {CONFIGS}/{_tag}/{_node}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t {registry_cmd}ceosimage:{CEOS[_node].image} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n")
            else:
                create_output.append(f"{cnt_cmd} run -d --name={CEOS[_node].ceos_name} --log-opt max-size=1m --net=container:{CEOS[_node].ceos_name}-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v {CONFIGS}/{_tag}/{_node}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t {registry_cmd}ceosimage:{CEOS[_node].image} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n")
            startup_output.append(f"sudo ip link add {CEOS[_node].ceos_name}-eth0 type veth peer name {CEOS[_node].ceos_name}-mgmt\n")
            startup_output.append(f"sudo brctl addif {mgmt_network} {CEOS[_node].ceos_name}-mgmt\n")
            startup_output.append(f"sudo ip link set {CEOS[_node].ceos_name}-eth0 netns {CEOS[_node].ceos_name} name eth0 up\n")
            startup_output.append(f"sudo ip link set {CEOS[_node].ceos_name}-mgmt up\n")
            startup_output.append("sleep 1\n")
            if container_runtime == "docker":
                startup_output.append(f"{cnt_cmd} run -d --name={CEOS[_node].ceos_name} --log-opt max-size=1m --net=container:{CEOS[_node].ceos_name}-net --ip {CEOS[_node].ip} --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v {CONFIGS}/{_tag}/{_node}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t {registry_cmd}ceosimage:{CEOS[_node].image} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n")
            else:
                startup_output.append(f"{cnt_cmd} run -d --name={CEOS[_node].ceos_name} --log-opt max-size=1m --net=container:{CEOS[_node].ceos_name}-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v {CONFIGS}/{_tag}/{_node}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t {registry_cmd}ceosimage:{CEOS[_node].image} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n")
        else:
            create_output.append("sleep 1\n")
            create_output.append(f"{cnt_cmd} run -d --name={CEOS[_node].ceos_name} --log-opt max-size=1m --net=container:{CEOS[_node].ceos_name}-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v {CONFIGS}/{_tag}/{_node}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t {registry_cmd}ceosimage:{CEOS[_node].image} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n")
            startup_output.append("sleep 1\n")
            startup_output.append(f"{cnt_cmd} run -d --name={CEOS[_node].ceos_name} --log-opt max-size=1m --net=container:{CEOS[_node].ceos_name}-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v {CONFIGS}/{_tag}/{_node}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t {registry_cmd}ceosimage:{CEOS[_node].image} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n")
    # Create initial host anchor containers
    for _host in HOSTS:
        create_output.append(f"# Getting {_host} nodes plumbing\n")
        create_output.append(f"{cnt_cmd} run -d --restart=always --log-opt max-size=10k --name={HOSTS[_host].c_name}-net --net=none busybox /bin/init\n")
        startup_output.append(f"{cnt_cmd} start {HOSTS[_host].c_name}-net\n")
        create_output.append(f"{HOSTS[_host].c_name}pid=$({cnt_cmd} inspect --format '{{{{.State.Pid}}}}' {HOSTS[_host].c_name}-net)\n")
        create_output.append(f"sudo ln -sf /proc/${{{HOSTS[_host].c_name}pid}}/ns/net /var/run/netns/{HOSTS[_host].c_name}\n")
        # Stop host containers
        startup_output.append(f"{cnt_cmd} stop {HOSTS[_host].c_name}\n")
        stop_output.append(f"{cnt_cmd} stop {HOSTS[_host].c_name}\n")
        stop_output.append(f"{cnt_cmd} stop {HOSTS[_host].c_name}-net\n")
        delete_output.append(f"{cnt_cmd} stop {HOSTS[_host].c_name}\n")
        delete_output.append(f"{cnt_cmd} stop {HOSTS[_host].c_name}-net\n")
        # Remove host containers
        startup_output.append(f"{cnt_cmd} rm {HOSTS[_host].c_name}\n")
        delete_output.append(f"{cnt_cmd} rm {HOSTS[_host].c_name}\n")
        delete_output.append(f"{cnt_cmd} rm {HOSTS[_host].c_name}-net\n")
        startup_output.append(f"{HOSTS[_host].c_name}pid=$({cnt_cmd} inspect --format '{{{{.State.Pid}}}}' {HOSTS[_host].c_name}-net)\n")
        startup_output.append(f"sudo ln -sf /proc/${{{HOSTS[_host].c_name}pid}}/ns/net /var/run/netns/{HOSTS[_host].c_name}\n")
        create_output.append("# Connecting host containers together\n")
        # Output veth commands
        for _intf in HOSTS[_host].intfs:
            _tmp_intf = HOSTS[_host].intfs[_intf]
            if _host in  _tmp_intf['veth'].split('-')[0]:
                create_output.append(f"sudo ip link set {_tmp_intf['veth'].split('-')[0]} netns {HOSTS[_host].c_name} name {_tmp_intf['port']} up\n")
                startup_output.append(f"sudo ip link set {_tmp_intf['veth'].split('-')[0]} netns {HOSTS[_host].c_name} name {_tmp_intf['port']} up\n")
            else:
                create_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[1], HOSTS[_host].c_name, _tmp_intf['port']))
                startup_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[1], HOSTS[_host].c_name, _tmp_intf['port']))
        create_output.append("sleep 1\n")
        create_output.append(f"{cnt_cmd} run -d --name={HOSTS[_host].c_name} --privileged --log-opt max-size=1m --net=container:{HOSTS[_host].c_name}-net -e HOSTNAME={HOSTS[_host].c_name} -e HOST_IP={HOSTS[_host].ip} -e HOST_MASK={HOSTS[_host].mask} -e HOST_GW={HOSTS[_host].gw} {registry_cmd}chost:{HOSTS[_host].image} ipnet\n")
        startup_output.append("sleep 1\n")
        startup_output.append(f"{cnt_cmd} run -d --name={HOSTS[_host].c_name} --privileged --log-opt max-size=1m --net=container:{HOSTS[_host].c_name}-net -e HOSTNAME={HOSTS[_host].c_name} -e HOST_IP={HOSTS[_host].ip} -e HOST_MASK={HOSTS[_host].mask} -e HOST_GW={HOSTS[_host].gw} {registry_cmd}chost:{HOSTS[_host].image} ipnet\n")
    # Check for iPerf3 commands
    if topo_yaml['iperf']:
        _iperf = topo_yaml['iperf']
        _port = _iperf['port']
        _brate = _iperf['brate']
        for _server in _iperf['servers']:
            create_output.append(f"{cnt_cmd} exec -d {HOSTS[_server].c_name} iperf3 -s -p {_port}\n")
            startup_output.append(f"{cnt_cmd} exec -d {HOSTS[_server].c_name} iperf3 -s -p {_port}\n")
        for _client in _iperf['clients']:
            _target = HOSTS[_client['target']].ip
            create_output.append(f"{cnt_cmd} exec -d {HOSTS[_client['client']].c_name} iperf3client {_target} {_port} {_brate}\n")
            startup_output.append(f"{cnt_cmd} exec -d {HOSTS[_client['client']].c_name} iperf3client {_target} {_port} {_brate}\n")
    # Create the initial deployment files
    with open(CEOS_SCRIPTS + '/{0}/Create.sh'.format(_tag), 'w') as cout:
        for _create in create_output:
            cout.write(_create)
    with open(CEOS_SCRIPTS + '/{0}/Startup.sh'.format(_tag), 'w') as cout:
        for _start in startup_output:
            cout.write(_start)
    with open(CEOS_SCRIPTS + '/{0}/Stop.sh'.format(_tag), 'w') as cout:
        for _stop in stop_output:
            cout.write(_stop)
    with open(CEOS_SCRIPTS + '/{0}/Delete.sh'.format(_tag), 'w') as cout:
        for _delete in delete_output:
            cout.write(_delete)
        for _delete in delete_net_output:
            cout.write(_delete)

if __name__ == '__main__':
    pS('OK', 'Starting cEOS Builder')
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--topo", type=str, help="Topology to build", default=None, required=True)
    parser.add_argument("-s", "--startup", help="Create a bare startup-config for each node", action="store_true")
    parser.add_argument("-r", "--runtime", type=str, help="Container Runtime; Docker or Podman", default="docker", required=False, choices=["docker","podman"])
    args = parser.parse_args()
    #TODO add in logic to load custom build file. Default to tag's build file
    main(args)
    pS('OK', 'Complete!')
