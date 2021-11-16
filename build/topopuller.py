#!/usr/bin/env python3
#
from jsonrpclib import Server
import socket
import csv
import requests
from getpass import getpass
import json
import urllib3
import ssl
import yaml as YAML
import random
import pprint
import re
import argparse

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


####################Global Variables####################


#if args.devlist:
#  device_list = args.devlist
#  with open(device_list) as device_file:
#      device_list = device_file.readlines()
#else:
#    print("You must provide a list of EOS devices to connect to")
#    exit(1)

#########################################


def get_credentials():
    '''
    Get Username and Password
    '''
    username = input("Please enter your EOS device username: ")
    password = getpass("Please enter your EOS device password: ")
    return username, password


def get_topology_info():
    _topology_info = {}

    confirmation = False

    while not confirmation:
        # Create Topology Key Information
        # vforward will default to 1
        topology_info = {'topology': {}, 'infra': {}, 'images': {}}
        if not args.toponame:
          _topology_name = input(
              'Please enter the name for the new topology: ')
        else:
            _topology_name = args.toponame
        topology_info['file_name'] = "topologies/{0}.yaml".format(
            _topology_name)
        topology_info['topology']['name'] = _topology_name
        topology_info['topology']['vforward'] = 1
        if not args.hexid:
          topology_info['topology_id'] = input(
              'Please enter a topology ID in hexidecimal format (only 1 character 0-F): ')
        else:
            topology_info['topology_id'] = args.hexid
        if not args.cvpip:
          _cvp_address = input(
              'Please enter the IP address of the CVP Server (Leave blank if not applicable): ')
        else:
            _cvp_address = args.cvpip
        if _cvp_address != '':
            topology_info['topology']['cvpaddress'] = _cvp_address
            if not args.cvpkey:
              topology_info['topology']['cvp-key'] = input(
                  'Please enter the Telemetry Key for CVP: ')
            else:
               topology_info['topology']['cvp-key'] = args.cvpkey
            while topology_info['topology']['cvp-key'] == '':
                print('***CVP Key cannot be null if CVP Address was provided.***')
                topology_info['topology']['cvp-key'] = input(
                    'Please enter the Telemetry Key for CVP: ')

        # Create Infra Key Information
        # Bridge will be left default for now
        if not args.bridge:
          topology_info['infra']['bridge'] = input(
              'Please enter the bridge for your management network: ')
        else:
           topology_info['infra']['bridge'] = args.bridge
        if not args.gw:
          topology_info['infra']['gateway'] = input(
              'Please enter the default gateway for your management network: ')
        else:
           topology_info['infra']['gateway'] = args.gw
        if not args.user:
          _username = input(
              'Please enter the username for EOS (Leave blank if you do not wish to create a username and password): ')
          topology_info['infra']['username'] = _username
        else:
            _username = args.user
            topology_info['infra']['username'] = _username
        if not args.password:
            topology_info['infra']['password'] = input(
                'Please enter your password: ')
        else:
            topology_info['infra']['password'] = args.password

        # Create Images Key Information
        # Hosts and host image tag will need to be added manually.
        if not args.ctag:
          topology_info['images']['ceos'] = input(
              'Please enter the tag for your cEOS Container Image: ')
        else:
           topology_info['images']['ceos'] = args.ctag
        if not args.htag:
          topology_info['images']['host'] = input(
              'Please enter the tag for your Host Container Image: ')
        else:
            topology_info['images']['host'] = args.htag

        print('Please verify that the data below is correct (Ignore anything that you were not prompted for): ')
        pprint.pprint(topology_info)
        check_confirmation = input('Is the above data correct? (Y/N): ')
        if check_confirmation.lower() == 'y':
            print('Input Verified.')
            confirmation = True
        elif check_confirmation.lower() == 'n':
            print('Input confirmation declined.')
        else:
            print('***Invalid Input on confirmation.***')

    return topology_info


def send_arista_commands_api(username, password, host):
    _create_unverified_https_context = ssl._create_unverified_context
    ssl._create_default_https_context = _create_unverified_https_context
    try:
        device = Server(
            f'https://{username}:{password}@{host}/command-api')
        result = device.runCmds(
            version=1, cmds=['enable', 'show hostname', 'show lldp neighbors'], format='json')
        #print(f'result is {result}')
        return (result[1]['fqdn'], result[2]['lldpNeighbors'])
    except:
        print(
            f'Error Connecting to {host}. Please ensure device is reachable and eAPI is enabled.')


def main(args):

    if args.devlist:
      _devices = args.devlist
      with open(_devices) as device_file:
        device_list = device_file.readlines()
    else:
      print("You must provide a list of EOS devices to connect to")
      exit(1)
    topology_info = get_topology_info()
    topology_info['nodes'] = {}

    username, password = get_credentials()

    print('Collecting device information...')
    device_count = 0
    for host in device_list:
        hoststrip = host.strip()

        hostname, lldp_neighbors = send_arista_commands_api(
            username, password, hoststrip)

        device_neighbors = []
        hexPattern = re.compile(
            r'^(?:[0-9A-Fa-f]{4}([.]?))(?:[0-9A-Fa-f]{4}\1){4}[0-9A-Fa-f]{4}|([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4}$')
        for neighbor in lldp_neighbors:
            neighbor.pop('ttl', None)
            if neighbor['neighborPort'][:-1] != "Management" and not re.match(hexPattern, neighbor['neighborPort']):
                device_neighbors.append(neighbor)

        topology_info['nodes'][hostname] = {}
        topology_info['nodes'][hostname]['mac'] = '00:1c:73:c{0}:c6:0{1}'.format(
            topology_info['topology_id'], device_count)
        topology_info['nodes'][hostname]['neighbors'] = device_neighbors
        topology_info['nodes'][hostname]['ipaddress'] = socket.gethostbyname(
            hoststrip)
        topology_info['iperf'] = {}
        topology_info['hosts'] = {}

        device_count += 1

    print('Creating topology file...')
    with open(topology_info['file_name'], 'w+') as topology_write_file:
        topology_info.pop('file_name', None)
        topology_info.pop('topology_id', None)
        topology_write_file.write(
            YAML.safe_dump(topology_info, sort_keys=False))

    print('File Created.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--toponame", type=str,
                        help="Topology name", default=None, required=False)
    parser.add_argument("-i", "--hexid", type=str,
                        help="Topo Hex ID", default=None, required=False)
    parser.add_argument("-c", "--cvpip", type=str,
                        help="CVP IP Address", default=None, required=False)
    parser.add_argument("-k", "--cvpkey", type=str,
                        help="CVP Streaming Telemetry key", default=None, required=False)
    parser.add_argument("-b", "--bridge", type=str,
                        help="Linux Bridge for ceos-lab management", default=None, required=False)
    parser.add_argument("-g", "--gw", type=str,
                        help="Linux gateway for ceos-lab management", default=None, required=False)
    parser.add_argument("-u", "--user", type=str,
                        help="username for ceos-lab config", default=None, required=False)
    parser.add_argument("-p", "--password", type=str,
                        help="password for ceos-lab config", default=None, required=False)
    parser.add_argument("-ct", "--ctag", type=str,
                        help="ceos-lab image tag", default=None, required=False)
    parser.add_argument("-ht", "--htag", type=str,
                        help="host image tag", default=None, required=False)
    parser.add_argument("-f", "--devlist", type=str,
                        help="list of devices to pull LLDP information from", default=None, required=True)
    args = parser.parse_args()
    main(args)
