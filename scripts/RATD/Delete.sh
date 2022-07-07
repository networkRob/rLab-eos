#!/bin/bash
sudo ip link delete 04a3et1 type veth peer name 68adet5
sudo ip link delete 04a3et2 type veth peer name a5a3et3
sudo ip link delete 04a3et3 type veth peer name c82aet1
sudo ip link delete 04a3et4 type veth peer name ff8eet4
sudo ip link delete 04a3et5 type veth peer name 6e3fet4
sudo ip link delete 04a3et6 type veth peer name 6fbfet1
sudo ip link delete 68adet1 type veth peer name aa4aet3
sudo ip link delete 68adet2 type veth peer name 31cfet4
sudo ip link delete 68adet3 type veth peer name 6e3fet3
sudo ip link delete 68adet4 type veth peer name ff8eet5
sudo ip link delete aa4aet1 type veth peer name 2111et2
sudo ip link delete aa4aet2 type veth peer name a5a3et1
sudo ip link delete aa4aet4 type veth peer name 6e3fet2
sudo ip link delete aa4aet5 type veth peer name 31cfet5
sudo ip link delete aa4aet6 type veth peer name 7c47et1
sudo ip link delete 31cfet1 type veth peer name 2111et1
sudo ip link delete 31cfet2 type veth peer name 4952et1
sudo ip link delete 31cfet3 type veth peer name 6e3fet1
sudo ip link delete 31cfet6 type veth peer name 45c5et1
sudo ip link delete 6e3fet6 type veth peer name ff8eet1
sudo ip link delete ff8eet2 type veth peer name 4952et3
sudo ip link delete ff8eet3 type veth peer name d3f1et1
sudo ip link delete ff8eet6 type veth peer name f22aet2
sudo ip link delete a5a3et2 type veth peer name b3f9et1
sudo ip link delete a5a3et4 type veth peer name e430et1
sudo ip link delete 4952et2 type veth peer name 3480et1
sudo ip link delete 4952et4 type veth peer name f22aet1
sudo ip link delete 4952et5 type veth peer name 4e83et1
sudo ip link delete c82aet2 type veth peer name 7791et2
sudo ip link delete c82aet3 type veth peer name d3f1et3
sudo ip link delete 7791et1 type veth peer name d3f1et2
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
