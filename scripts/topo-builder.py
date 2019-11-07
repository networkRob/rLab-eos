#!/usr/bin/env python

import argparse
from ruamel.yaml import YAML
from os import getcwd
from pprint import pprint as pp

BASE_PATH = getcwd()
CONFIGS = BASE_PATH + "/configs/"

OVS_BRIDGES = []
NODES = {}
HOSTS = {}
CMDS = []
CMDS_DOWN = []

def openTopo(topo):
    try:
        tmp_topo = open(BASE_PATH + "/topologies/{}.yaml".format(topo), 'r')
        tmp_yaml = YAML().load(tmp_topo)
        tmp_topo.close()
        return(tmp_yaml)
    except:
        return(False)

def checkBridge(dev1, dev2, _tag):
    global OVS_BRIDGES
    _addBr = True
    name_len = len(dev1 + dev2 + _tag)
    for _br in OVS_BRIDGES:
        if dev1 in _br and dev2 in _br and len(_br) == name_len:
            _addBr = False
            return({'status': _addBr, 'name': _br})
    return({'status': _addBr, 'name':''})


def main(args):
    global OVS_BRIDGES, NODES
    topo_yaml = openTopo(args.type)
    ceos_img = topo_yaml['images']['ceos']
    host_img = topo_yaml['images']['host']
    if topo_yaml:
        _tag = topo_yaml['topology']['name']
        for _node in topo_yaml['nodes']:
            intf = 0
            NODES[_node] = {
                "intfs": {},
                "name": _tag.lower() + _node
            }
            for _peer in topo_yaml['nodes'][_node]['links']:
                intf += 1
                _brCheck = checkBridge(_node, _peer, _tag)
                if _brCheck['status']:
                    _brName = _tag.lower() + _node + _peer
                    OVS_BRIDGES.append(_brName)
                    NODES[_node]['intfs']['eth{}'.format(intf)] = _brName
                else:
                    NODES[_node]['intfs']['eth{}'.format(intf)] = _brCheck['name']
        # Section to parse hosts
        if topo_yaml['hosts']:
            for _host in topo_yaml['hosts']:
                intf = 0
                HOSTS[_host] = {
                    'intfs': {},
                    'name': _tag.lower() + _host
                }
                for _peer in topo_yaml['hosts'][_host]['links']:
                    _brCheck = checkBridge(_host, _peer, _tag)
                    HOSTS[_host]['intfs']['eth{}'.format(intf)] = _brCheck['name']
                    intf += 1
            
    # Create commands to create Open vSwitch bridges
    for _br in OVS_BRIDGES:
        CMDS.append("sudo ovs-vsctl add-br {}".format(_br))
        CMDS.append("sudo ovs-vsctl set bridge {} other-config:forward-bpdu=true".format(_br))
    
    # Create commands to create cEOS containers:
    for _node in NODES:
        _name = NODES[_node]['name']
        CMDS.append("docker volume create {0}".format(_name))
        CMDS.append("docker create --name={0} --net=none --privileged --mount source={0},target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:{1} /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker".format(_name, ceos_img))
        # CMDS.append("sudo cp $(pwd)/configs/{0}/{1}/startup-config $(docker inspect -f '{{ (index .Mounts 0).Source }}' {2}/)".format(topo_yaml['topology']['name'], _node, _name))
        CMDS.append("docker start {}".format(_name))
        for eindex in range(1, len(NODES[_node]['intfs']) + 1):
            if eindex == 1:
                CMDS.append("sudo ovs-docker add-port {0} eth{1} {2} --macaddress={3}".format(NODES[_node]['intfs']['eth{}'.format(eindex)], eindex, _name, topo_yaml['nodes'][_node]['mac']))
            else:
                CMDS.append("sudo ovs-docker add-port {0} eth{1} {2}".format(NODES[_node]['intfs']['eth{}'.format(eindex)], eindex, _name))
            CMDS_DOWN.append("sudo ovs-docker del-port {0} eth{1} {2}".format(NODES[_node]['intfs']['eth{}'.format(eindex)], eindex, _name))
        CMDS_DOWN.append("docker stop {}".format(_name))
        CMDS_DOWN.append("docker rm {}".format(_name))
    # Create commands to create host containers
    for _host in HOSTS:
        CMDS.append("docker create --name={0} --hostname={0} --net=none {1}".format(HOSTS[_host]['name'], host_img))
        CMDS.append("docker start {}".format(HOSTS[_host]['name']))
        for eindex in range(0, len(HOSTS[_host]['intfs'])):
            CMDS.append("sudo ovs-docker add-port {0} eth{1} {2} --ipaddress={3} --gateway={4}".format(HOSTS[_host]['intfs']['eth{}'.format(eindex)], eindex, HOSTS[_host]['name'], topo_yaml['hosts'][_host]['ipaddress'], topo_yaml['hosts'][_host]['gateway']))
            CMDS_DOWN.append("sudo ovs-docker del-port {0} eth{1} {2} --ipaddress={3} --gateway={4}".format(HOSTS[_host]['intfs']['eth{}'.format(eindex)], eindex, HOSTS[_host]['name'], topo_yaml['hosts'][_host]['ipaddress'], topo_yaml['hosts'][_host]['gateway']))
        CMDS_DOWN.append("docker stop {}".format(HOSTS[_host]['name']))
        CMDS_DOWN.append("docker rm {}".format(HOSTS[_host]['name']))
    if CMDS:
        with open(BASE_PATH + "/cnt/{}-start.sh".format(_tag), 'w') as fout:
            fout.write("#!/bin/bash\n")
            for _cmd in CMDS:
                fout.write(_cmd + "\n")
        with open(BASE_PATH + "/cnt/{}-stop.sh".format(_tag), 'w') as fout:
            fout.write("#!/bin/bash\n")
            for _cmd in CMDS_DOWN:
                fout.write(_cmd + "\n")
            for _br in OVS_BRIDGES:
                fout.write("sudo ovs-vsctl del-br {}\n".format(_br))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--type", type=str, help="Topology to build", default=None, required=True)
    args = parser.parse_args()
    main(args)
