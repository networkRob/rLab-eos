#!/usr/bin/env python3

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
VETH_PAIRS = []
CEOS = {}
HOSTS = {}


class CEOS_NODE():
    def __init__(self, node_name, node_ip, node_neighbors, _tag, image):
        self.name = node_name
        self.ip = node_ip
        self.tag = _tag.lower()
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
    topo_yaml = openTopo(args.topo)
    ceos_image = topo_yaml['images']['ceos']
    host_image = topo_yaml['images']['host']
    _tag = topo_yaml['topology']['name']
    nodes = topo_yaml['nodes']
    hosts = topo_yaml['hosts']
    _ceos_script_location = "{0}/{1}".format(CEOS_SCRIPTS, _tag)

    # Check for mgmt Bridge
    try:
        mgmt_network = topo_yaml['infra']['bridge']
        if not mgmt_network:
            pS("INFO", "No mgmt bridge specified. Creating isolated network.")
    except KeyError:
        pS("INFO", "No mgmt bridge specified. Creating isolated network.")
        mgmt_network = False
    # Load cEOS nodes specific information
    for _node in nodes:
        try:
            _node_ip = nodes[_node]['ipaddress']
        except KeyError:
            _node_ip = ""
        CEOS[_node] = CEOS_NODE(_node, _node_ip, nodes[_node]['neighbors'], _tag, ceos_image)
    # Load Host nodes specific information
    if hosts:
        for _host in hosts:
            _tmp_host = hosts[_host]
            HOSTS[_host] = HOST_NODE(_host, _tmp_host['ipaddress'], _tmp_host['mask'], _tmp_host['gateway'], _tmp_host['neighbors'], _tag, host_image)
    # Check for output directory
    if checkDir(_ceos_script_location):
        pS("OK", "Directory is present now.")
    else:
        pS("iBerg", "Error creating directory.")
    create_output.append("#!/bin/bash\n")
    # Check for container images are present
    create_output.append("if [ \"$(docker image ls | grep ceosimage | grep -c {0})\" == 0 ]\n".format(ceos_image))
    create_output.append("then\n    echo \"Docker image not found for ceosimage:{0}, please build it first.\"\n    exit\nfi\n".format(ceos_image))
    create_output.append("if [ \"$(docker image ls | grep chost | grep -c {0})\" == 0 ]\n".format(host_image))
    create_output.append("then\n    echo \"Docker image not found for chost:{0}, please build it first.\"\n    exit\nfi\n".format(host_image))
    create_output.append("sudo ip netns add {0}\n".format(_tag))
    startup_output.append("#!/bin/bash\n")
    stop_output.append("#!/bin/bash\n")
    delete_output.append("#!/bin/bash\n")
    startup_output.append("sudo ip netns add {0}\n".format(_tag))
    delete_net_output.append("sudo ip netns delete {0}\n".format(_tag))
    # Get the veths created
    create_output.append("# Creating veths\n")
    for _veth in VETH_PAIRS:
        _v1, _v2 = _veth.split("-")
        create_output.append("sudo ip link add {0} type veth peer name {1}\n".format(_v1, _v2))
        startup_output.append("sudo ip link add {0} type veth peer name {1}\n".format(_v1, _v2))
        delete_output.append("sudo ip link delete {0} type veth peer name {1}\n".format(_v1, _v2))
    create_output.append("#\n#\n# Creating anchor containers\n#\n")
    # Create initial cEOS anchor containers
    for _node in CEOS:
        create_output.append("# Getting {0} nodes plumbing\n".format(_node))
        create_output.append("docker run -d --restart=always --name={0}-net --net=none busybox /bin/init\n".format(CEOS[_node].ceos_name))
        startup_output.append("docker start {0}-net\n".format(CEOS[_node].ceos_name))
        create_output.append("{0}pid=$(docker inspect --format '{{{{.State.Pid}}}}' {0}-net)\n".format(CEOS[_node].ceos_name))
        create_output.append("sudo ln -sf /proc/${{{0}pid}}/ns/net /var/run/netns/{0}\n".format(CEOS[_node].ceos_name))
        # Stop cEOS containers
        startup_output.append("docker stop {0}\n".format(CEOS[_node].ceos_name))
        stop_output.append("docker stop {0}\n".format(CEOS[_node].ceos_name))
        stop_output.append("docker stop {0}-net\n".format(CEOS[_node].ceos_name))
        delete_output.append("docker stop {0}\n".format(CEOS[_node].ceos_name))
        delete_output.append("docker stop {0}-net\n".format(CEOS[_node].ceos_name))
        # Remove cEOS containers
        startup_output.append("docker rm {0}\n".format(CEOS[_node].ceos_name))
        delete_output.append("docker rm {0}\n".format(CEOS[_node].ceos_name))
        delete_output.append("docker rm {0}-net\n".format(CEOS[_node].ceos_name))
        delete_net_output.append("sudo rm -rf /var/run/netns/{0}\n".format(CEOS[_node].ceos_name))
        startup_output.append("{0}pid=$(docker inspect --format '{{{{.State.Pid}}}}' {0}-net)\n".format(CEOS[_node].ceos_name))
        startup_output.append("sudo ln -sf /proc/${{{0}pid}}/ns/net /var/run/netns/{0}\n".format(CEOS[_node].ceos_name))
        create_output.append("# Connecting cEOS containers together\n")
        # Output veth commands
        for _intf in CEOS[_node].intfs:
            _tmp_intf = CEOS[_node].intfs[_intf]
            if _node in  _tmp_intf['veth'].split('-')[0]:
                create_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[0], CEOS[_node].ceos_name, _tmp_intf['port']))
                startup_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[0], CEOS[_node].ceos_name, _tmp_intf['port']))
            else:
                create_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[1], CEOS[_node].ceos_name, _tmp_intf['port']))
                startup_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[1], CEOS[_node].ceos_name, _tmp_intf['port']))
            # Perform check if mgmt network is available
        if mgmt_network:
            # Get MGMT VETHS
            create_output.append("sudo ip link add {0}-eth0 type veth peer name {0}-mgmt\n".format(CEOS[_node].ceos_name))
            create_output.append("sudo brctl addif {0} {1}-mgmt\n".format(mgmt_network, CEOS[_node].ceos_name))
            create_output.append("sudo ip link set {0}-eth0 netns {0} name eth0 up\n".format(CEOS[_node].ceos_name))
            create_output.append("sudo ip link set {0}-mgmt up\n".format(CEOS[_node].ceos_name))
            create_output.append("sleep 1\n")
            create_output.append("docker run -d --name={0} --net=container:{0}-net --ip {1} --privileged -v {2}/{4}/{5}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:{3} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n".format(CEOS[_node].ceos_name, CEOS[_node].ip, CONFIGS, CEOS[_node].image, _tag, _node))
            startup_output.append("sudo ip link add {0}-eth0 type veth peer name {0}-mgmt\n".format(CEOS[_node].ceos_name))
            startup_output.append("sudo brctl addif {0} {1}-mgmt\n".format(mgmt_network, CEOS[_node].ceos_name))
            startup_output.append("sudo ip link set {0}-eth0 netns {0} name eth0 up\n".format(CEOS[_node].ceos_name))
            startup_output.append("sudo ip link set {0}-mgmt up\n".format(CEOS[_node].ceos_name))
            startup_output.append("sleep 1\n")
            startup_output.append("docker run -d --name={0} --net=container:{0}-net --ip {1} --privileged -v {2}/{4}/{5}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:{3} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n".format(CEOS[_node].ceos_name, CEOS[_node].ip, CONFIGS, CEOS[_node].image, _tag, _node))
        else:
            create_output.append("sleep 1\n")
            create_output.append("docker run -d --name={0} --net=container:{0}-net --privileged -v {1}/{3}/{4}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:{2} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n".format(CEOS[_node].ceos_name, CONFIGS, CEOS[_node].image, _tag, _node))
            startup_output.append("sleep 1\n")
            startup_output.append("docker run -d --name={0} --net=container:{0}-net --privileged -v {1}/{3}/{4}:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:{2} /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker\n".format(CEOS[_node].ceos_name, CONFIGS, CEOS[_node].image, _tag, _node))
    # Create initial host anchor containers
    for _host in HOSTS:
        create_output.append("# Getting {0} nodes plumbing\n".format(_host))
        create_output.append("docker run -d --restart=always --name={0}-net --net=none busybox /bin/init\n".format(HOSTS[_host].c_name))
        startup_output.append("docker start {0}-net\n".format(HOSTS[_host].c_name))
        create_output.append("{0}pid=$(docker inspect --format '{{{{.State.Pid}}}}' {0}-net)\n".format(HOSTS[_host].c_name))
        create_output.append("sudo ln -sf /proc/${{{0}pid}}/ns/net /var/run/netns/{0}\n".format(HOSTS[_host].c_name))
        # Stop host containers
        startup_output.append("docker stop {0}\n".format(HOSTS[_host].c_name))
        stop_output.append("docker stop {0}\n".format(HOSTS[_host].c_name))
        stop_output.append("docker stop {0}-net\n".format(HOSTS[_host].c_name))
        delete_output.append("docker stop {0}\n".format(HOSTS[_host].c_name))
        delete_output.append("docker stop {0}-net\n".format(HOSTS[_host].c_name))
        # Remove host containers
        startup_output.append("docker rm {0}\n".format(HOSTS[_host].c_name))
        delete_output.append("docker rm {0}\n".format(HOSTS[_host].c_name))
        delete_output.append("docker rm {0}-net\n".format(HOSTS[_host].c_name))
        startup_output.append("{0}pid=$(docker inspect --format '{{{{.State.Pid}}}}' {0}-net)\n".format(HOSTS[_host].c_name))
        startup_output.append("sudo ln -sf /proc/${{{0}pid}}/ns/net /var/run/netns/{0}\n".format(HOSTS[_host].c_name))
        create_output.append("# Connecting host containers together\n")
        # Output veth commands
        for _intf in HOSTS[_host].intfs:
            _tmp_intf = HOSTS[_host].intfs[_intf]
            if _host in  _tmp_intf['veth'].split('-')[0]:
                create_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[0], HOSTS[_host].c_name, _tmp_intf['port']))
                startup_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[0], HOSTS[_host].c_name, _tmp_intf['port']))
            else:
                create_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[1], HOSTS[_host].c_name, _tmp_intf['port']))
                startup_output.append("sudo ip link set {0} netns {1} name {2} up\n".format(_tmp_intf['veth'].split('-')[1], HOSTS[_host].c_name, _tmp_intf['port']))
        create_output.append("sleep 1\n")
        create_output.append("docker run -d --name={0} --privileged --net=container:{0}-net -e HOSTNAME={0} -e HOST_IP={1} -e HOST_MASK={3} -e HOST_GW={4} chost:{2} ipnet\n".format(HOSTS[_host].c_name, HOSTS[_host].ip, HOSTS[_host].image, HOSTS[_host].mask, HOSTS[_host].gw))
        startup_output.append("sleep 1\n")
        startup_output.append("docker run -d --name={0} --privileged --net=container:{0}-net -e HOSTNAME={0} -e HOST_IP={1} -e HOST_MASK={3} -e HOST_GW={4} chost:{2} ipnet\n".format(HOSTS[_host].c_name, HOSTS[_host].ip, HOSTS[_host].image, HOSTS[_host].mask, HOSTS[_host].gw))
    # Check for iPerf3 commands
    if topo_yaml['iperf']:
        _iperf = topo_yaml['iperf']
        _port = _iperf['port']
        _brate = _iperf['brate']
        for _server in _iperf['servers']:
            create_output.append("docker exec -d {0} iperf3 -s -p {1}".format(HOSTS[_server].c_name, _port))
            startup_output.append("docker exec -d {0} iperf3 -s -p {1}".format(HOSTS[_server].c_name, _port))
        for _client in _iperf['clients']:
            _target = topo_yaml['hosts'][_client['target']]['ipaddress']
            create_output.append("docker exec -d {0} iperf3client {1} {2} {3}".format(HOSTS[_client['client']].c_name, _target, _port, _brate))
            startup_output.append("docker exec -d {0} iperf3client {1} {2} {3}".format(HOSTS[_client['client']].c_name, _target, _port, _brate))
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
    args = parser.parse_args()
    #TODO add in logic to load custom build file. Default to tag's build file
    main(args)
    pS('OK', 'Complete!')
