#!/usr/bin/python
#
# Copyright (c) 2018, Arista Networks, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#  - Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#  - Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#  - Neither the name of Arista Networks nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL ARISTA NETWORKS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# locateMac
#
#    Written by:
#       Rob Martin, Arista Networks
#
"""
DESCRIPTION
A Python script for searching the local and then remote switches for a MAC address.
An alias can be created within EOS to execute the command
INSTALLATION
1. Copy the script to /mnt/flash on any switches that the command can be initiated from
2. Change values of switch_username and switch_password to valid account credentials for the switches
3. Create an EOS alias command
    switch(config)# alias findmac bash /mnt/flash/locateMac.py %1
"""
__author__ = 'rmartin'
__version__ = 3.2
from jsonrpclib import Server
from sys import argv, exit
import os, ssl

if (not os.environ.get('PYTHONHTTPSVERIFY', '') and
    getattr(ssl, '_create_unverified_context', None)): 
    ssl._create_default_https_context = ssl._create_unverified_context

switch_username = 'arista'
switch_password = 'arista'
checked_switches = []
search_devices = []
all_macs = []
all_switches = []
non_eapi = []


#==========================================
# Begin Class Declaration
#==========================================

class MACHOSTS:
    "Object created for each MAC address found that matches the queried string"
    def __init__(self,mac,vlan,switch,intf):
        self.mac = mac
        self.status = False
        self.switch = switch
        self.interface = intf
        self.vlan = vlan

class SwitchCon:
    "Object created for each queried switch"
    def __init__(self,ip,s_username,s_password,s_vend=False):
        self.sw_arista = s_vend
        if s_vend:
            self.ip = ip
            self.username = s_username
            self.password = s_password
            self.mac_entry = []
            self.server = self._create_switch()
            try:
                self.hostname = self._get_hostname()
                self.STATUS = True
                self.eapi = True
            except:
                self.STATUS = False
                self.eapi = False
            if self.STATUS:
                self.lldp_neighbors = self._add_lldp_neighbors()
                self.system_mac = self._get_system_mac()
                #Added try statement to catch if virtual device doesn't support virtual-router
                try:
                    self.virtual_mac = self._get_virtual_mac()
                except:
                    self.virtual_mac = '00000000000'
                if self.ip == 'localhost':
                    self._get_localhost_ip()  
        else:
            print('Device %s is not an Arista switch'%ip)         

    def _get_localhost_ip(self):
        "Gets the IP addresses configured for management on the localhost, and adds to checked switches object"
        for r1 in self.run_commands(['show management api http-commands'])[0]['urls']:
            if 'unix' not in r1:
                checked_switches.append(r1[r1.find('//')+2:r1.rfind(':')]) 

    def _create_switch(self):
        "This command will create a jsonrpclib Server object for the switch"
        target_switch = Server('https://%s:%s@%s/command-api'%(self.username,self.password,self.ip))
        return(target_switch)

    def run_commands(self,commands):
        "This command will send the commands to the targeted switch and return the results"
        try:
            switch_response = self.server.runCmds(1,commands)
            return(switch_response)
        except KeyboardInterrupt:
            self.eapi = False

    def add_mac(self,MAC):
        "Adds queried MAC addresses to Switch's MAC Entry attribute"
        add_code = True
        for r1 in self.mac_entry:
            if MAC.mac == r1.mac:
                add_code = False
        if add_code:
            self.mac_entry.append(MAC) 

    def _get_system_mac(self):
        "Gets the system MAC address for the switch"
        return(self.run_commands(['show version'])[0]['systemMacAddress'].replace(":",""))

    def _get_virtual_mac(self):
        "Gets the virtual-router MAC address for the switch"
        return(self.run_commands(['show ip virtual-router'])[0]['virtualMac'].replace(":",""))

    def _get_hostname(self):
        "Gets the hostname for the switch"
        return(self.run_commands(['show hostname'])[0]['hostname'])

    def _add_lldp_neighbors(self):
        "Gets LLDP neighbors on switch and adds to the lldp_neighbors attribute"
        dict_lldp = {}
        lldp_results = self.run_commands(['show lldp neighbors detail'])[0]['lldpNeighbors']
        for r1 in lldp_results:
            if lldp_results[r1]['lldpNeighborInfo']:
                if len(lldp_results[r1]['lldpNeighborInfo']) > 0:
                    l_base = lldp_results[r1]['lldpNeighborInfo'][0]
                    if 'systemDescription'in l_base:
                        if 'Arista' in l_base['systemDescription']:
                            a_vend = True
                            dict_lldp[r1] = {'neighbor':l_base['systemName'],'ip':l_base['managementAddresses'][0]['address'],'remote':l_base['neighborInterfaceInfo']['interfaceId'],'Arista':a_vend}
        return(dict_lldp)
            

#==========================================
# End Class Declaration
#==========================================
# Begin Function Declarations
#==========================================


def format_MAC(mac_string):
    "Function to format a string with ':'"
    new_mac_search = "%s%s:%s%s:%s%s:%s%s:%s%s:%s%s" %tuple(mac_string)
    return(new_mac_search)


def print_output(data):
    print('\nMAC Address\tHostname\tInterface\tVLAN\tStatus').expandtabs(20)
    print('------------------\t---------\t----------\t---------\t---------').expandtabs(20)
    for r1 in data:
        print_vlans = ''
        r1.vlan.sort()
        for r2 in r1.vlan:
            if print_vlans == '':
                print_vlans = str(r2)
            else:
                print_vlans += ', %s'%str(r2)
        if r1.status:
            print('%s\t%s\t%s\t%s\tFound'%(format_MAC(r1.mac),r1.switch,r1.interface,print_vlans)).expandtabs(20)
        else:
            print('%s\t%s\t%s\t%s\t*Not Found'%(format_MAC(r1.mac),r1.switch,r1.interface[0],print_vlans)).expandtabs(20)
    print

def check_all_macs(mac):
    "Checks to see if object has been created for a MAC Address"
    for r1 in all_macs:
        if mac == r1.mac:
            return r1
    else:
        return None

def check_all_mac_status(am):
    if not am:
        return False
    for r1 in am:
        if not r1.status:
            return False
    return True        

def check_system_mac(mac):
    for r1 in all_switches:
        if mac == r1.system_mac:
            return r1.hostname
    else:
        return None

def check_virtual_mac(mac):
    "Checks virtual MACs for all queried switches"
    for r1 in all_switches:
        if mac == r1.virtual_mac:
            return r1.hostname
    else:
        return False



def query_switch(switch_con,new_mac_search):
    response_current_switch = switch_con.run_commands(['show mac address-table'])
    #Check to see if a response was returned for the 'show mac address-table command'
    if response_current_switch[0]:
        mac_response = response_current_switch[0]['unicastTable']['tableEntries']
        #Iterate through all unicast table entries
        for r1 in mac_response:
            #Create tmp variable to hold stripped down MAC string
            resp_mac = r1['macAddress'].replace(':','')
            #Check if partial query MAC string is in MAC address table entry
            if new_mac_search in resp_mac:
                #If Port-Channel, grab intf members for that Port-Channel
                if 'Port-Channel' in r1['interface']:
                    port_details = switch_con.run_commands(['show interfaces %s'%r1['interface']])
                    if port_details[0]: #Verify a response was generated
                        intf_members = [] #Temp variable to contain interfaces within a port-channel
                        for r2 in port_details[0]['interfaces'][r1['interface']]['memberInterfaces']:
                            #Grab physical interfaces
                            if 'Peer' not in r2:
                                intf_members.append(r2)
                        #Check to see if MAC Address object has been created
                        res_check = check_all_macs(resp_mac)
                        if res_check:
                            #If MAC hasn't been located, update to most recent hop
                            if not res_check.status:
                                res_check.switch = switch_con.hostname
                                res_check.interface = intf_members
                                if r1['vlanId'] not in res_check.vlan:
                                    res_check.vlan.append(r1['vlanId'])
                            switch_con.add_mac(res_check)
                        else:
                            current_mac = MACHOSTS(resp_mac,[r1['vlanId']],switch_con.hostname,intf_members)
                            all_macs.append(current_mac)
                            switch_con.add_mac(current_mac)
                else:
                    #Check to see if MAC Address object has been created
                    res_check = check_all_macs(resp_mac)
                    if res_check:
                        #If MAC hasn't been located, update to most recent hop
                        if not res_check.status:
                            res_check.switch = switch_con.hostname
                            res_check.interface = [r1['interface']]
                            if r1['vlanId'] not in res_check.vlan:
                                res_check.vlan.append(r1['vlanId'])
                        #Add the MAC object to the switches list of known MAC objects
                        switch_con.add_mac(res_check)
                    else:
                        #If MAC object hasn't been create, create a MAC object
                        current_mac = MACHOSTS(resp_mac,[r1['vlanId']],switch_con.hostname,[r1['interface']])
                        #Add MAC to all_macs list and add it to the switches list of known MACs
                        all_macs.append(current_mac)
                        switch_con.add_mac(current_mac)

def search_results(switch_object):
    """
    Function to take the search results and evaluate the data
    """
    if switch_object.mac_entry:
        #Iterate through all MAC objects for queried switch
        for r1 in switch_object.mac_entry:
            #If MAC object has been found, skip it
            if r1.status:
                continue
            #Check if MAC address is the switch's System or Virtual MACs
            check_system = check_system_mac(r1.mac)
            check_virtual = check_virtual_mac(r1.mac)
            if check_system:
                r1.status = True
                r1.switch = check_system
                r1.interface = 'SYSTEM MAC'
            elif check_virtual:
                r1.status = True
                r1.switch = check_virtual
                r1.interface = 'VIRTUAL MAC'
            else:
                #Iterate through switches intfs that has MAC associated with it
                for r2 in r1.interface:
                    #If intf for MAC does not have LLDP neighbor, Match Found
                    if r2 not in switch_object.lldp_neighbors:
                        r1.status = True
                        r1.switch = switch_object.hostname
                        r1.interface = r2
                    #If intf for MAC has an LLDP neighbor
                    elif r2 in switch_object.lldp_neighbors:
                        #Check if LLDP neighbor is a non-Arista switch, if so, Match Found
                        if not switch_object.lldp_neighbors[r2]['Arista']:
                            print('Non Arista LLDP port')
                            r1.status = True
                            r1.switch = switch_object.hostname
                            r1.interface = r2
                        #If LLDP neighbor and Arista switch, add the remote switches info to search_devices to be queried
                        else:
                            remote_ip = switch_object.lldp_neighbors[r2]['ip']
                            if remote_ip not in checked_switches and remote_ip not in search_devices:
                                search_devices.append({switch_object.lldp_neighbors[r2]['ip']:switch_object.lldp_neighbors[r2]['Arista']})
                    #Catch all to add remote switch info to search_devices to be queried
                    else:
                        for r3 in switch_object.lldp_neighbors:
                            remote_ip = switch_object.lldp_neighbors[r3]['ip']
                            if remote_ip not in checked_switches and remote_ip not in search_devices:
                                search_devices.append({remote_ip:switch_object.lldp_neighbors[r2]['Arista']})
    #Iterate through all LLDP neighbors
    for r1 in switch_object.lldp_neighbors:
        remote_ip = switch_object.lldp_neighbors[r1]['ip']
        #If remote LLDP neighbor hasn't been checked or to be searched, add it to the devices to be searched
        if remote_ip not in checked_switches and remote_ip not in search_devices:
            search_devices.append({remote_ip:switch_object.lldp_neighbors[r1]['Arista']})
    #check to see if MAC address is in all macs list object
    for r1 in all_macs:
        #Evaluate if MAC has been located on end intf, if not check if it's a System or Virtual MAC
        if not r1.status:
            check_system = check_system_mac(r1.mac)
            check_virtual = check_virtual_mac(r1.mac)
            if check_system:
                r1.status = True
                r1.switch = check_system
                r1.interface = 'SYSTEM MAC'
            if check_virtual:
                r1.status = True
                r1.switch = check_virtual
                r1.interface = 'VIRTUAL MAC'
            
        

#==========================================
# End Function Declarations
#==========================================
# Begin Main Function
#==========================================


def main(mac_to_search):
    "Main script to get started"
    print("Searching....")
    #Reformat MAC search string
    mac_to_search = mac_to_search.lower()
    if '.' in mac_to_search:
        new_mac_search = mac_to_search.replace('.','')
    elif ':' in mac_to_search:
        new_mac_search = mac_to_search.replace(':','')
    else:
        new_mac_search = mac_to_search
    #Create a Switch Object for the localhost and add it to the all_switches list object
    current_switch = SwitchCon('localhost',switch_username,switch_password,s_vend=True)
    if current_switch.eapi:
        all_switches.append(current_switch)
    else:
        exit()
    #Perform a query on the switch for MAC query string
    query_switch(current_switch,new_mac_search)
    #Iterate through mac entries found
    search_results(current_switch)
    if not check_all_mac_status(all_macs):
        for r1 in search_devices:
            rem_ip = r1.keys()[0]
            if rem_ip not in checked_switches:
                checked_switches.append(r1.keys()[0])
                rem_ven = r1[rem_ip]
                remote_switch = SwitchCon(rem_ip,switch_username,switch_password,s_vend=rem_ven)
                all_switches.append(remote_switch)
                if remote_switch.sw_arista and remote_switch.eapi:
                    query_switch(remote_switch,new_mac_search)
                    search_results(remote_switch)
    for r1 in all_switches:
        if r1.eapi == False and r1.sw_arista == True:
            non_eapi.append(r1)
    if len(non_eapi) > 0:
        print("\nUnable to access the following Arista Switches, Results maybe incomplete. Please enable eAPI on them...")
        for r1 in non_eapi:
            print("Switch IP: %s"%r1.ip)
    print_output(all_macs)
    for r1 in all_macs:
        if not r1.status:
            print("*Last Switch and Port to report this MAC Address. Check device connected to this port.\n")
            break

#==========================================
# End Main Function
#==========================================

if __name__ == '__main__':
    if len(argv) > 1:
        main(argv[1])
    else:
        print('MAC Address not provided')
