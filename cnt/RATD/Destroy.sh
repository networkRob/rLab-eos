#!/bin/bash
sudo ovs-docker del-port ratdeos4eos16 et1 ratdeos16
docker stop ratdeos16
docker rm ratdeos16
sudo ovs-docker del-port ratdeos4eos9 et1 ratdeos9
sudo ovs-docker del-port ratdeos3eos9 et2 ratdeos9
docker stop ratdeos9
docker rm ratdeos9
sudo ovs-docker del-port ratdeos4eos8 et1 ratdeos8
sudo ovs-docker del-port ratdeos8eos15 et2 ratdeos8
sudo ovs-docker del-port ratdeos6eos8 et3 ratdeos8
sudo ovs-docker del-port ratdeos8eos14 et4 ratdeos8
sudo ovs-docker del-port ratdeos8eos18 et5 ratdeos8
docker stop ratdeos8
docker rm ratdeos8
sudo ovs-docker del-port ratdeos4eos5 et1 ratdeos5
sudo ovs-docker del-port ratdeos3eos5 et2 ratdeos5
sudo ovs-docker del-port ratdeos2eos5 et3 ratdeos5
sudo ovs-docker del-port ratdeos1eos5 et4 ratdeos5
sudo ovs-docker del-port ratdeos5eos6 et5 ratdeos5
docker stop ratdeos5
docker rm ratdeos5
sudo ovs-docker del-port ratdeos4eos9 et1 ratdeos4
sudo ovs-docker del-port ratdeos4eos8 et2 ratdeos4
sudo ovs-docker del-port ratdeos4eos5 et3 ratdeos4
sudo ovs-docker del-port ratdeos2eos4 et4 ratdeos4
sudo ovs-docker del-port ratdeos3eos4 et5 ratdeos4
sudo ovs-docker del-port ratdeos4eos16 et6 ratdeos4
docker stop ratdeos4
docker rm ratdeos4
sudo ovs-docker del-port ratdeos3eos7 et1 ratdeos7
sudo ovs-docker del-port ratdeos7eos10 et2 ratdeos7
sudo ovs-docker del-port ratdeos1eos7 et3 ratdeos7
sudo ovs-docker del-port ratdeos7eos19 et4 ratdeos7
docker stop ratdeos7
docker rm ratdeos7
sudo ovs-docker del-port ratdeos5eos6 et1 ratdeos6
sudo ovs-docker del-port ratdeos6eos8 et2 ratdeos6
sudo ovs-docker del-port ratdeos6eos13 et3 ratdeos6
sudo ovs-docker del-port ratdeos1eos6 et4 ratdeos6
sudo ovs-docker del-port ratdeos2eos6 et5 ratdeos6
sudo ovs-docker del-port ratdeos6eos14 et6 ratdeos6
docker stop ratdeos6
docker rm ratdeos6
sudo ovs-docker del-port ratdeos1eos2 et1 ratdeos1
sudo ovs-docker del-port ratdeos1eos7 et2 ratdeos1
sudo ovs-docker del-port ratdeos1eos11 et3 ratdeos1
sudo ovs-docker del-port ratdeos1eos6 et4 ratdeos1
sudo ovs-docker del-port ratdeos1eos5 et5 ratdeos1
sudo ovs-docker del-port ratdeos1eos17 et6 ratdeos1
docker stop ratdeos1
docker rm ratdeos1
sudo ovs-docker del-port ratdeos7eos10 et1 ratdeos10
docker stop ratdeos10
docker rm ratdeos10
sudo ovs-docker del-port ratdeos3eos9 et1 ratdeos3
sudo ovs-docker del-port ratdeos3eos7 et2 ratdeos3
sudo ovs-docker del-port ratdeos2eos3 et3 ratdeos3
sudo ovs-docker del-port ratdeos3eos5 et4 ratdeos3
sudo ovs-docker del-port ratdeos3eos4 et5 ratdeos3
sudo ovs-docker del-port ratdeos3eos20 et6 ratdeos3
docker stop ratdeos3
docker rm ratdeos3
sudo ovs-docker del-port ratdeos2eos3 et1 ratdeos2
sudo ovs-docker del-port ratdeos2eos4 et2 ratdeos2
sudo ovs-docker del-port ratdeos2eos5 et3 ratdeos2
sudo ovs-docker del-port ratdeos2eos6 et4 ratdeos2
sudo ovs-docker del-port ratdeos1eos2 et5 ratdeos2
docker stop ratdeos2
docker rm ratdeos2
sudo ovs-docker del-port ratdeos8eos15 et1 ratdeos15
docker stop ratdeos15
docker rm ratdeos15
sudo ovs-docker del-port ratdeos3eos20 et1 ratdeos20
docker stop ratdeos20
docker rm ratdeos20
sudo ovs-docker del-port ratdeos6eos13 et1 ratdeos13
sudo ovs-docker del-port ratdeos12eos13 et2 ratdeos13
sudo ovs-docker del-port ratdeos11eos13 et3 ratdeos13
docker stop ratdeos13
docker rm ratdeos13
sudo ovs-docker del-port ratdeos8eos14 et1 ratdeos14
sudo ovs-docker del-port ratdeos6eos14 et2 ratdeos14
docker stop ratdeos14
docker rm ratdeos14
sudo ovs-docker del-port ratdeos7eos19 et1 ratdeos19
docker stop ratdeos19
docker rm ratdeos19
sudo ovs-docker del-port ratdeos12eos13 et1 ratdeos12
sudo ovs-docker del-port ratdeos11eos12 et2 ratdeos12
docker stop ratdeos12
docker rm ratdeos12
sudo ovs-docker del-port ratdeos1eos11 et1 ratdeos11
sudo ovs-docker del-port ratdeos11eos12 et2 ratdeos11
sudo ovs-docker del-port ratdeos11eos13 et3 ratdeos11
docker stop ratdeos11
docker rm ratdeos11
sudo ovs-docker del-port ratdeos1eos17 et1 ratdeos17
docker stop ratdeos17
docker rm ratdeos17
sudo ovs-docker del-port ratdeos8eos18 et1 ratdeos18
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
