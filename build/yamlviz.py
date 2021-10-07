#!/usr/bin/env python3

from graphviz import Digraph
import json
from os import getcwd
from ruamel.yaml import YAML
import argparse

BASE_PATH = getcwd()
looped = []
dooped = []


def openTopo(topo):
    try:
        tmp_topo = open(BASE_PATH + "/topologies/{}.yaml".format(topo), 'r')
        #tmp_topo = open(yaml_file, 'r')
        tmp_yaml = YAML().load(tmp_topo)
        tmp_topo.close()
        return(tmp_yaml)
    except:
        return(False)


def checkedge_exist(_local, _remote, dev_links):
    for _link in dev_links:
        if _local in _link and _remote in _link:
            return True
    return False

# Deprecated, function not used, wait to delete
#def checkedge_loop(_local, _remote):
#    if _local == _remote:
#        return True
#    return False


def checkedge_reused_remote(_remote, _remote_seen):
    if _remote in _remote_seen:
        return True
    return False


def create_topo(root, neigh_list):
    nodes = []
    edges = []
    remotes_seen = []
    dev_links = []
    for _node in neigh_list:
        nodes.append(_node['name'])
        for _neigh in _node['neighbors']:
            _local = _node['name'] + _neigh['port']
            _remote = _neigh['neighborDevice'] + _neigh['neighborPort']
            if checkedge_reused_remote(_remote, remotes_seen):
                global dooped
                dooped.append([_neigh['neighborDevice'], _remote])
                print(f'iBerg! {_remote}')
            if not checkedge_exist(_local, _remote, dev_links):
                edges.append([_node['name'], _neigh['neighborDevice'],
                             _neigh['neighborPort'] + "-" + _neigh['port']])
                dev_links.append(_local + "-" + _remote)
                remotes_seen.append(_remote)
    return [nodes, edges]


def make_topology(network_name, mytopo):
    dot = Digraph(comment=network_name, format='png')
    dot.attr('graph', fontname='Verdana', K='3.6')
    dot.attr('node', shape='none', overlap='false',
             fontsize='55', fontcolor='black', labelloc='b')
    dot.attr('node', image=BASE_PATH + "/images/switch.png")
    dot.attr('edge', penwidth='2')
    dot.attr('edge', arrowhead='none')
    if dooped:
        dot.body.append(
            rf'label = "\nDuped connection ALERT!\nCHECK YOUR TOPO YAML.\nConnection: {dooped} are being reused"')
    dot.body.append('fontsize=40')
    dot.engine = 'fdp'
    for i in mytopo[0]:
        dot.node(i)
    for i in mytopo[1]:
        head = "Eth" + i[2].split("-")[0].split("ernet")[1]
        tail = "Eth" + i[2].split("-")[1].split("ernet")[1]
        if "host" in i[1]:
            dot.node(i[1], imagesscale='true', image=BASE_PATH +
                     "/images/linux.png", labelloc='t')
        if dooped:
            if i[1] in str(dooped).split(",")[1]:
                dot.edge(i[0], i[1], headlabel=head, taillabel=tail,
                         fontcolor='red', color='red', penwidth='4', labelfontsize='20')
                dot.node(i[1], fontcolor='red', color='red',
                         shape='box', fontsize='65')
            else:
                dot.edge(i[0], i[1], headlabel=head,
                         taillabel=tail, labelfontsize='20')
        else:
            dot.edge(i[0], i[1], headlabel=head,
                     taillabel=tail, labelfontsize='20')
    return dot


def main(args):
    topo = openTopo(args.topo)
    nodes = []
    for node in topo['nodes']:
        nodes.append(
            {'name': node, 'neighbors': topo['nodes'][node]['neighbors']})
    topo_name = str(topo['topology']['name'])
    my_topo = create_topo(topo_name, nodes)
    dot = Digraph(comment=topo_name)

    dot = make_topology(topo_name, my_topo)
    dot.render(filename=args.topo, directory=BASE_PATH +
               "/topologies", cleanup=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--topo", type=str,
                        help="Topology diagram to build", default=None, required=True)
    args = parser.parse_args()
    main(args)
