#!/bin/bash
docker start ratdeos16
sudo ovs-docker add-port ratdeos4eos16 et1 ratdeos16 --macaddress=00:1c:73:d5:c6:01
docker start ratdeos9
sudo ovs-docker add-port ratdeos4eos9 et1 ratdeos9 --macaddress=00:1c:73:c8:c6:01
sudo ovs-docker add-port ratdeos3eos9 et2 ratdeos9
docker start ratdeos8
sudo ovs-docker add-port ratdeos4eos8 et1 ratdeos8 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port ratdeos8eos15 et2 ratdeos8
sudo ovs-docker add-port ratdeos6eos8 et3 ratdeos8
sudo ovs-docker add-port ratdeos8eos14 et4 ratdeos8
sudo ovs-docker add-port ratdeos8eos18 et5 ratdeos8
docker start ratdeos5
sudo ovs-docker add-port ratdeos4eos5 et1 ratdeos5 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port ratdeos3eos5 et2 ratdeos5
sudo ovs-docker add-port ratdeos2eos5 et3 ratdeos5
sudo ovs-docker add-port ratdeos1eos5 et4 ratdeos5
sudo ovs-docker add-port ratdeos5eos6 et5 ratdeos5
docker start ratdeos4
sudo ovs-docker add-port ratdeos4eos9 et1 ratdeos4 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port ratdeos4eos8 et2 ratdeos4
sudo ovs-docker add-port ratdeos4eos5 et3 ratdeos4
sudo ovs-docker add-port ratdeos2eos4 et4 ratdeos4
sudo ovs-docker add-port ratdeos3eos4 et5 ratdeos4
sudo ovs-docker add-port ratdeos4eos16 et6 ratdeos4
docker start ratdeos7
sudo ovs-docker add-port ratdeos3eos7 et1 ratdeos7 --macaddress=00:1c:73:c6:c6:01
sudo ovs-docker add-port ratdeos7eos10 et2 ratdeos7
sudo ovs-docker add-port ratdeos1eos7 et3 ratdeos7
sudo ovs-docker add-port ratdeos7eos19 et4 ratdeos7
docker start ratdeos6
sudo ovs-docker add-port ratdeos5eos6 et1 ratdeos6 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port ratdeos6eos8 et2 ratdeos6
sudo ovs-docker add-port ratdeos6eos13 et3 ratdeos6
sudo ovs-docker add-port ratdeos1eos6 et4 ratdeos6
sudo ovs-docker add-port ratdeos2eos6 et5 ratdeos6
sudo ovs-docker add-port ratdeos6eos14 et6 ratdeos6
docker start ratdeos1
sudo ovs-docker add-port ratdeos1eos2 et1 ratdeos1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port ratdeos1eos7 et2 ratdeos1
sudo ovs-docker add-port ratdeos1eos11 et3 ratdeos1
sudo ovs-docker add-port ratdeos1eos6 et4 ratdeos1
sudo ovs-docker add-port ratdeos1eos5 et5 ratdeos1
sudo ovs-docker add-port ratdeos1eos17 et6 ratdeos1
docker start ratdeos10
sudo ovs-docker add-port ratdeos7eos10 et1 ratdeos10 --macaddress=00:1c:73:c9:c6:01
docker start ratdeos3
sudo ovs-docker add-port ratdeos3eos9 et1 ratdeos3 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port ratdeos3eos7 et2 ratdeos3
sudo ovs-docker add-port ratdeos2eos3 et3 ratdeos3
sudo ovs-docker add-port ratdeos3eos5 et4 ratdeos3
sudo ovs-docker add-port ratdeos3eos4 et5 ratdeos3
sudo ovs-docker add-port ratdeos3eos20 et6 ratdeos3
docker start ratdeos2
sudo ovs-docker add-port ratdeos2eos3 et1 ratdeos2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port ratdeos2eos4 et2 ratdeos2
sudo ovs-docker add-port ratdeos2eos5 et3 ratdeos2
sudo ovs-docker add-port ratdeos2eos6 et4 ratdeos2
sudo ovs-docker add-port ratdeos1eos2 et5 ratdeos2
docker start ratdeos15
sudo ovs-docker add-port ratdeos8eos15 et1 ratdeos15 --macaddress=00:1c:73:d4:c6:01
docker start ratdeos20
sudo ovs-docker add-port ratdeos3eos20 et1 ratdeos20 --macaddress=00:1c:73:d9:c6:01
docker start ratdeos13
sudo ovs-docker add-port ratdeos6eos13 et1 ratdeos13 --macaddress=00:1c:73:d2:c6:01
sudo ovs-docker add-port ratdeos12eos13 et2 ratdeos13
sudo ovs-docker add-port ratdeos11eos13 et3 ratdeos13
docker start ratdeos14
sudo ovs-docker add-port ratdeos8eos14 et1 ratdeos14 --macaddress=00:1c:73:d3:c6:01
sudo ovs-docker add-port ratdeos6eos14 et2 ratdeos14
docker start ratdeos19
sudo ovs-docker add-port ratdeos7eos19 et1 ratdeos19 --macaddress=00:1c:73:d8:c6:01
docker start ratdeos12
sudo ovs-docker add-port ratdeos12eos13 et1 ratdeos12 --macaddress=00:1c:73:d1:c6:01
sudo ovs-docker add-port ratdeos11eos12 et2 ratdeos12
docker start ratdeos11
sudo ovs-docker add-port ratdeos1eos11 et1 ratdeos11 --macaddress=00:1c:73:d0:c6:01
sudo ovs-docker add-port ratdeos11eos12 et2 ratdeos11
sudo ovs-docker add-port ratdeos11eos13 et3 ratdeos11
docker start ratdeos17
sudo ovs-docker add-port ratdeos1eos17 et1 ratdeos17 --macaddress=00:1c:73:d6:c6:01
docker start ratdeos18
sudo ovs-docker add-port ratdeos8eos18 et1 ratdeos18 --macaddress=00:1c:73:d7:c6:01
