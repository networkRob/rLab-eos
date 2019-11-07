#!/bin/bash
docker start ratdeos16
sudo ovs-docker add-port ratdeos4eos16 eth1 ratdeos16 --macaddress=00:1c:73:d5:c6:01
docker start ratdeos9
sudo ovs-docker add-port ratdeos4eos9 eth1 ratdeos9 --macaddress=00:1c:73:c8:c6:01
sudo ovs-docker add-port ratdeos3eos9 eth2 ratdeos9
docker start ratdeos8
sudo ovs-docker add-port ratdeos4eos8 eth1 ratdeos8 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port ratdeos8eos15 eth2 ratdeos8
sudo ovs-docker add-port ratdeos6eos8 eth3 ratdeos8
sudo ovs-docker add-port ratdeos8eos14 eth4 ratdeos8
sudo ovs-docker add-port ratdeos8eos18 eth5 ratdeos8
docker start ratdeos5
sudo ovs-docker add-port ratdeos4eos5 eth1 ratdeos5 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port ratdeos3eos5 eth2 ratdeos5
sudo ovs-docker add-port ratdeos2eos5 eth3 ratdeos5
sudo ovs-docker add-port ratdeos1eos5 eth4 ratdeos5
sudo ovs-docker add-port ratdeos5eos6 eth5 ratdeos5
docker start ratdeos4
sudo ovs-docker add-port ratdeos4eos9 eth1 ratdeos4 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port ratdeos4eos8 eth2 ratdeos4
sudo ovs-docker add-port ratdeos4eos5 eth3 ratdeos4
sudo ovs-docker add-port ratdeos2eos4 eth4 ratdeos4
sudo ovs-docker add-port ratdeos3eos4 eth5 ratdeos4
sudo ovs-docker add-port ratdeos4eos16 eth6 ratdeos4
docker start ratdeos7
sudo ovs-docker add-port ratdeos3eos7 eth1 ratdeos7 --macaddress=00:1c:73:c6:c6:01
sudo ovs-docker add-port ratdeos7eos10 eth2 ratdeos7
sudo ovs-docker add-port ratdeos1eos7 eth3 ratdeos7
sudo ovs-docker add-port ratdeos7eos19 eth4 ratdeos7
docker start ratdeos6
sudo ovs-docker add-port ratdeos5eos6 eth1 ratdeos6 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port ratdeos6eos8 eth2 ratdeos6
sudo ovs-docker add-port ratdeos6eos13 eth3 ratdeos6
sudo ovs-docker add-port ratdeos1eos6 eth4 ratdeos6
sudo ovs-docker add-port ratdeos2eos6 eth5 ratdeos6
sudo ovs-docker add-port ratdeos6eos14 eth6 ratdeos6
docker start ratdeos1
sudo ovs-docker add-port ratdeos1eos2 eth1 ratdeos1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port ratdeos1eos7 eth2 ratdeos1
sudo ovs-docker add-port ratdeos1eos11 eth3 ratdeos1
sudo ovs-docker add-port ratdeos1eos6 eth4 ratdeos1
sudo ovs-docker add-port ratdeos1eos5 eth5 ratdeos1
sudo ovs-docker add-port ratdeos1eos17 eth6 ratdeos1
docker start ratdeos10
sudo ovs-docker add-port ratdeos7eos10 eth1 ratdeos10 --macaddress=00:1c:73:c9:c6:01
docker start ratdeos3
sudo ovs-docker add-port ratdeos3eos9 eth1 ratdeos3 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port ratdeos3eos7 eth2 ratdeos3
sudo ovs-docker add-port ratdeos2eos3 eth3 ratdeos3
sudo ovs-docker add-port ratdeos3eos5 eth4 ratdeos3
sudo ovs-docker add-port ratdeos3eos4 eth5 ratdeos3
sudo ovs-docker add-port ratdeos3eos20 eth6 ratdeos3
docker start ratdeos2
sudo ovs-docker add-port ratdeos2eos3 eth1 ratdeos2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port ratdeos2eos4 eth2 ratdeos2
sudo ovs-docker add-port ratdeos2eos5 eth3 ratdeos2
sudo ovs-docker add-port ratdeos2eos6 eth4 ratdeos2
sudo ovs-docker add-port ratdeos1eos2 eth5 ratdeos2
docker start ratdeos15
sudo ovs-docker add-port ratdeos8eos15 eth1 ratdeos15 --macaddress=00:1c:73:d4:c6:01
docker start ratdeos20
sudo ovs-docker add-port ratdeos3eos20 eth1 ratdeos20 --macaddress=00:1c:73:d9:c6:01
docker start ratdeos13
sudo ovs-docker add-port ratdeos6eos13 eth1 ratdeos13 --macaddress=00:1c:73:d2:c6:01
sudo ovs-docker add-port ratdeos12eos13 eth2 ratdeos13
sudo ovs-docker add-port ratdeos11eos13 eth3 ratdeos13
docker start ratdeos14
sudo ovs-docker add-port ratdeos8eos14 eth1 ratdeos14 --macaddress=00:1c:73:d3:c6:01
sudo ovs-docker add-port ratdeos6eos14 eth2 ratdeos14
docker start ratdeos19
sudo ovs-docker add-port ratdeos7eos19 eth1 ratdeos19 --macaddress=00:1c:73:d8:c6:01
docker start ratdeos12
sudo ovs-docker add-port ratdeos12eos13 eth1 ratdeos12 --macaddress=00:1c:73:d1:c6:01
sudo ovs-docker add-port ratdeos11eos12 eth2 ratdeos12
docker start ratdeos11
sudo ovs-docker add-port ratdeos1eos11 eth1 ratdeos11 --macaddress=00:1c:73:d0:c6:01
sudo ovs-docker add-port ratdeos11eos12 eth2 ratdeos11
sudo ovs-docker add-port ratdeos11eos13 eth3 ratdeos11
docker start ratdeos17
sudo ovs-docker add-port ratdeos1eos17 eth1 ratdeos17 --macaddress=00:1c:73:d6:c6:01
docker start ratdeos18
sudo ovs-docker add-port ratdeos8eos18 eth1 ratdeos18 --macaddress=00:1c:73:d7:c6:01
