#!/bin/bash
sudo ovs-docker del-port ratdeos4eos16 eth1 ratdeos16
docker stop ratdeos16
docker rm ratdeos16
sudo ovs-docker del-port ratdeos4eos9 eth1 ratdeos9
sudo ovs-docker del-port ratdeos3eos9 eth2 ratdeos9
docker stop ratdeos9
docker rm ratdeos9
sudo ovs-docker del-port ratdeos4eos8 eth1 ratdeos8
sudo ovs-docker del-port ratdeos8eos15 eth2 ratdeos8
sudo ovs-docker del-port ratdeos6eos8 eth3 ratdeos8
sudo ovs-docker del-port ratdeos8eos14 eth4 ratdeos8
sudo ovs-docker del-port ratdeos8eos18 eth5 ratdeos8
docker stop ratdeos8
docker rm ratdeos8
sudo ovs-docker del-port ratdeos4eos5 eth1 ratdeos5
sudo ovs-docker del-port ratdeos3eos5 eth2 ratdeos5
sudo ovs-docker del-port ratdeos2eos5 eth3 ratdeos5
sudo ovs-docker del-port ratdeos1eos5 eth4 ratdeos5
sudo ovs-docker del-port ratdeos5eos6 eth5 ratdeos5
docker stop ratdeos5
docker rm ratdeos5
sudo ovs-docker del-port ratdeos4eos9 eth1 ratdeos4
sudo ovs-docker del-port ratdeos4eos8 eth2 ratdeos4
sudo ovs-docker del-port ratdeos4eos5 eth3 ratdeos4
sudo ovs-docker del-port ratdeos2eos4 eth4 ratdeos4
sudo ovs-docker del-port ratdeos3eos4 eth5 ratdeos4
sudo ovs-docker del-port ratdeos4eos16 eth6 ratdeos4
docker stop ratdeos4
docker rm ratdeos4
sudo ovs-docker del-port ratdeos3eos7 eth1 ratdeos7
sudo ovs-docker del-port ratdeos7eos10 eth2 ratdeos7
sudo ovs-docker del-port ratdeos1eos7 eth3 ratdeos7
sudo ovs-docker del-port ratdeos7eos19 eth4 ratdeos7
docker stop ratdeos7
docker rm ratdeos7
sudo ovs-docker del-port ratdeos5eos6 eth1 ratdeos6
sudo ovs-docker del-port ratdeos6eos8 eth2 ratdeos6
sudo ovs-docker del-port ratdeos6eos13 eth3 ratdeos6
sudo ovs-docker del-port ratdeos1eos6 eth4 ratdeos6
sudo ovs-docker del-port ratdeos2eos6 eth5 ratdeos6
sudo ovs-docker del-port ratdeos6eos14 eth6 ratdeos6
docker stop ratdeos6
docker rm ratdeos6
sudo ovs-docker del-port ratdeos1eos2 eth1 ratdeos1
sudo ovs-docker del-port ratdeos1eos7 eth2 ratdeos1
sudo ovs-docker del-port ratdeos1eos11 eth3 ratdeos1
sudo ovs-docker del-port ratdeos1eos6 eth4 ratdeos1
sudo ovs-docker del-port ratdeos1eos5 eth5 ratdeos1
sudo ovs-docker del-port ratdeos1eos17 eth6 ratdeos1
docker stop ratdeos1
docker rm ratdeos1
sudo ovs-docker del-port ratdeos7eos10 eth1 ratdeos10
docker stop ratdeos10
docker rm ratdeos10
sudo ovs-docker del-port ratdeos3eos9 eth1 ratdeos3
sudo ovs-docker del-port ratdeos3eos7 eth2 ratdeos3
sudo ovs-docker del-port ratdeos2eos3 eth3 ratdeos3
sudo ovs-docker del-port ratdeos3eos5 eth4 ratdeos3
sudo ovs-docker del-port ratdeos3eos4 eth5 ratdeos3
sudo ovs-docker del-port ratdeos3eos20 eth6 ratdeos3
docker stop ratdeos3
docker rm ratdeos3
sudo ovs-docker del-port ratdeos2eos3 eth1 ratdeos2
sudo ovs-docker del-port ratdeos2eos4 eth2 ratdeos2
sudo ovs-docker del-port ratdeos2eos5 eth3 ratdeos2
sudo ovs-docker del-port ratdeos2eos6 eth4 ratdeos2
sudo ovs-docker del-port ratdeos1eos2 eth5 ratdeos2
docker stop ratdeos2
docker rm ratdeos2
sudo ovs-docker del-port ratdeos8eos15 eth1 ratdeos15
docker stop ratdeos15
docker rm ratdeos15
sudo ovs-docker del-port ratdeos3eos20 eth1 ratdeos20
docker stop ratdeos20
docker rm ratdeos20
sudo ovs-docker del-port ratdeos6eos13 eth1 ratdeos13
sudo ovs-docker del-port ratdeos12eos13 eth2 ratdeos13
sudo ovs-docker del-port ratdeos11eos13 eth3 ratdeos13
docker stop ratdeos13
docker rm ratdeos13
sudo ovs-docker del-port ratdeos8eos14 eth1 ratdeos14
sudo ovs-docker del-port ratdeos6eos14 eth2 ratdeos14
docker stop ratdeos14
docker rm ratdeos14
sudo ovs-docker del-port ratdeos7eos19 eth1 ratdeos19
docker stop ratdeos19
docker rm ratdeos19
sudo ovs-docker del-port ratdeos12eos13 eth1 ratdeos12
sudo ovs-docker del-port ratdeos11eos12 eth2 ratdeos12
docker stop ratdeos12
docker rm ratdeos12
sudo ovs-docker del-port ratdeos1eos11 eth1 ratdeos11
sudo ovs-docker del-port ratdeos11eos12 eth2 ratdeos11
sudo ovs-docker del-port ratdeos11eos13 eth3 ratdeos11
docker stop ratdeos11
docker rm ratdeos11
sudo ovs-docker del-port ratdeos1eos17 eth1 ratdeos17
docker stop ratdeos17
docker rm ratdeos17
sudo ovs-docker del-port ratdeos8eos18 eth1 ratdeos18
docker stop ratdeos18
docker rm ratdeos18
sudo ovs-vsctl del-br ratdeos1eos2
sudo ovs-vsctl del-br ratdeos1eos7
sudo ovs-vsctl del-br ratdeos1eos11
sudo ovs-vsctl del-br ratdeos1eos6
sudo ovs-vsctl del-br ratdeos1eos5
sudo ovs-vsctl del-br ratdeos1eos17
sudo ovs-vsctl del-br ratdeos2eos3
sudo ovs-vsctl del-br ratdeos2eos4
sudo ovs-vsctl del-br ratdeos2eos5
sudo ovs-vsctl del-br ratdeos2eos6
sudo ovs-vsctl del-br ratdeos3eos9
sudo ovs-vsctl del-br ratdeos3eos7
sudo ovs-vsctl del-br ratdeos3eos5
sudo ovs-vsctl del-br ratdeos3eos4
sudo ovs-vsctl del-br ratdeos3eos20
sudo ovs-vsctl del-br ratdeos4eos9
sudo ovs-vsctl del-br ratdeos4eos8
sudo ovs-vsctl del-br ratdeos4eos5
sudo ovs-vsctl del-br ratdeos4eos16
sudo ovs-vsctl del-br ratdeos5eos6
sudo ovs-vsctl del-br ratdeos6eos8
sudo ovs-vsctl del-br ratdeos6eos13
sudo ovs-vsctl del-br ratdeos6eos14
sudo ovs-vsctl del-br ratdeos7eos10
sudo ovs-vsctl del-br ratdeos7eos19
sudo ovs-vsctl del-br ratdeos8eos15
sudo ovs-vsctl del-br ratdeos8eos14
sudo ovs-vsctl del-br ratdeos8eos18
sudo ovs-vsctl del-br ratdeos11eos12
sudo ovs-vsctl del-br ratdeos11eos13
sudo ovs-vsctl del-br ratdeos12eos13
