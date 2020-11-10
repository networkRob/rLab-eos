#!/bin/bash
sudo ip link delete ratdeos1et1 type veth peer name ratdeos2et5
sudo ip link delete ratdeos1et2 type veth peer name ratdeos7et3
sudo ip link delete ratdeos1et3 type veth peer name ratdeos11et1
sudo ip link delete ratdeos1et4 type veth peer name ratdeos6et4
sudo ip link delete ratdeos1et5 type veth peer name ratdeos5et4
sudo ip link delete ratdeos1et6 type veth peer name ratdeos17et1
sudo ip link delete ratdeos2et1 type veth peer name ratdeos3et3
sudo ip link delete ratdeos2et2 type veth peer name ratdeos4et4
sudo ip link delete ratdeos2et3 type veth peer name ratdeos5et3
sudo ip link delete ratdeos2et4 type veth peer name ratdeos6et5
sudo ip link delete ratdeos3et1 type veth peer name ratdeos9et2
sudo ip link delete ratdeos3et2 type veth peer name ratdeos7et1
sudo ip link delete ratdeos3et4 type veth peer name ratdeos5et2
sudo ip link delete ratdeos3et5 type veth peer name ratdeos4et5
sudo ip link delete ratdeos3et6 type veth peer name ratdeos20et1
sudo ip link delete ratdeos4et1 type veth peer name ratdeos9et1
sudo ip link delete ratdeos4et2 type veth peer name ratdeos8et1
sudo ip link delete ratdeos4et3 type veth peer name ratdeos5et1
sudo ip link delete ratdeos4et6 type veth peer name ratdeos16et1
sudo ip link delete ratdeos5et5 type veth peer name ratdeos6et1
sudo ip link delete ratdeos6et2 type veth peer name ratdeos8et3
sudo ip link delete ratdeos6et3 type veth peer name ratdeos13et1
sudo ip link delete ratdeos6et6 type veth peer name ratdeos14et2
sudo ip link delete ratdeos7et2 type veth peer name ratdeos10et1
sudo ip link delete ratdeos7et4 type veth peer name ratdeos19et1
sudo ip link delete ratdeos8et2 type veth peer name ratdeos15et1
sudo ip link delete ratdeos8et4 type veth peer name ratdeos14et1
sudo ip link delete ratdeos8et5 type veth peer name ratdeos18et1
sudo ip link delete ratdeos11et2 type veth peer name ratdeos12et2
sudo ip link delete ratdeos11et3 type veth peer name ratdeos13et3
sudo ip link delete ratdeos12et1 type veth peer name ratdeos13et2
docker stop ratdeos1
docker stop ratdeos1-net
docker rm ratdeos1
docker rm ratdeos1-net
docker stop ratdeos2
docker stop ratdeos2-net
docker rm ratdeos2
docker rm ratdeos2-net
docker stop ratdeos3
docker stop ratdeos3-net
docker rm ratdeos3
docker rm ratdeos3-net
docker stop ratdeos4
docker stop ratdeos4-net
docker rm ratdeos4
docker rm ratdeos4-net
docker stop ratdeos5
docker stop ratdeos5-net
docker rm ratdeos5
docker rm ratdeos5-net
docker stop ratdeos6
docker stop ratdeos6-net
docker rm ratdeos6
docker rm ratdeos6-net
docker stop ratdeos7
docker stop ratdeos7-net
docker rm ratdeos7
docker rm ratdeos7-net
docker stop ratdeos8
docker stop ratdeos8-net
docker rm ratdeos8
docker rm ratdeos8-net
docker stop ratdeos9
docker stop ratdeos9-net
docker rm ratdeos9
docker rm ratdeos9-net
docker stop ratdeos10
docker stop ratdeos10-net
docker rm ratdeos10
docker rm ratdeos10-net
docker stop ratdeos11
docker stop ratdeos11-net
docker rm ratdeos11
docker rm ratdeos11-net
docker stop ratdeos12
docker stop ratdeos12-net
docker rm ratdeos12
docker rm ratdeos12-net
docker stop ratdeos13
docker stop ratdeos13-net
docker rm ratdeos13
docker rm ratdeos13-net
docker stop ratdeos14
docker stop ratdeos14-net
docker rm ratdeos14
docker rm ratdeos14-net
docker stop ratdeos15
docker stop ratdeos15-net
docker rm ratdeos15
docker rm ratdeos15-net
docker stop ratdeos16
docker stop ratdeos16-net
docker rm ratdeos16
docker rm ratdeos16-net
docker stop ratdeos17
docker stop ratdeos17-net
docker rm ratdeos17
docker rm ratdeos17-net
docker stop ratdeos18
docker stop ratdeos18-net
docker rm ratdeos18
docker rm ratdeos18-net
docker stop ratdeos19
docker stop ratdeos19-net
docker rm ratdeos19
docker rm ratdeos19-net
docker stop ratdeos20
docker stop ratdeos20-net
docker rm ratdeos20
docker rm ratdeos20-net
sudo ip netns delete RATD
sudo rm -rf /var/run/netns/ratdeos1
sudo rm -rf /var/run/netns/ratdeos2
sudo rm -rf /var/run/netns/ratdeos3
sudo rm -rf /var/run/netns/ratdeos4
sudo rm -rf /var/run/netns/ratdeos5
sudo rm -rf /var/run/netns/ratdeos6
sudo rm -rf /var/run/netns/ratdeos7
sudo rm -rf /var/run/netns/ratdeos8
sudo rm -rf /var/run/netns/ratdeos9
sudo rm -rf /var/run/netns/ratdeos10
sudo rm -rf /var/run/netns/ratdeos11
sudo rm -rf /var/run/netns/ratdeos12
sudo rm -rf /var/run/netns/ratdeos13
sudo rm -rf /var/run/netns/ratdeos14
sudo rm -rf /var/run/netns/ratdeos15
sudo rm -rf /var/run/netns/ratdeos16
sudo rm -rf /var/run/netns/ratdeos17
sudo rm -rf /var/run/netns/ratdeos18
sudo rm -rf /var/run/netns/ratdeos19
sudo rm -rf /var/run/netns/ratdeos20
