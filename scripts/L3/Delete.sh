#!/bin/bash
sudo ip link delete 52bcet1 type veth peer name 69f0et2
sudo ip link delete 52bcet2 type veth peer name b332et2
sudo ip link delete 52bcet3 type veth peer name 3979et2
sudo ip link delete 52bcet4 type veth peer name a9daet2
sudo ip link delete 52bcet5 type veth peer name f3adet2
sudo ip link delete 52bcet6 type veth peer name 3b37et2
sudo ip link delete 52bcet7 type veth peer name 9eaaet2
sudo ip link delete 52bcet8 type veth peer name 69b5et2
sudo ip link delete 80ceet1 type veth peer name 69f0et3
sudo ip link delete 80ceet2 type veth peer name b332et3
sudo ip link delete 80ceet3 type veth peer name 3979et3
sudo ip link delete 80ceet4 type veth peer name a9daet3
sudo ip link delete 80ceet5 type veth peer name f3adet3
sudo ip link delete 80ceet6 type veth peer name 3b37et3
sudo ip link delete 80ceet7 type veth peer name 9eaaet3
sudo ip link delete 80ceet8 type veth peer name 69b5et3
sudo ip link delete 69f0et1 type veth peer name b332et1
sudo ip link delete 69f0et4 type veth peer name 8d5aet0
sudo ip link delete 69f0et5 type veth peer name 679det0
sudo ip link delete 3979et1 type veth peer name a9daet1
sudo ip link delete 3979et4 type veth peer name 8872et0
sudo ip link delete a9daet4 type veth peer name 0259et0
sudo ip link delete f3adet1 type veth peer name 3b37et1
sudo ip link delete f3adet4 type veth peer name 0c74et0
sudo ip link delete f3adet5 type veth peer name 361aet0
sudo ip link delete 9eaaet1 type veth peer name 69b5et1
docker stop l3spine1
docker stop l3spine1-net
docker rm l3spine1
docker rm l3spine1-net
docker stop l3spine2
docker stop l3spine2-net
docker rm l3spine2
docker rm l3spine2-net
docker stop l3leaf11
docker stop l3leaf11-net
docker rm l3leaf11
docker rm l3leaf11-net
docker stop l3leaf12
docker stop l3leaf12-net
docker rm l3leaf12
docker rm l3leaf12-net
docker stop l3leaf21
docker stop l3leaf21-net
docker rm l3leaf21
docker rm l3leaf21-net
docker stop l3leaf22
docker stop l3leaf22-net
docker rm l3leaf22
docker rm l3leaf22-net
docker stop l3leaf31
docker stop l3leaf31-net
docker rm l3leaf31
docker rm l3leaf31-net
docker stop l3leaf32
docker stop l3leaf32-net
docker rm l3leaf32
docker rm l3leaf32-net
docker stop l3brdr1
docker stop l3brdr1-net
docker rm l3brdr1
docker rm l3brdr1-net
docker stop l3brdr2
docker stop l3brdr2-net
docker rm l3brdr2
docker rm l3brdr2-net
docker stop l3host11
docker stop l3host11-net
docker rm l3host11
docker rm l3host11-net
docker stop l3host12
docker stop l3host12-net
docker rm l3host12
docker rm l3host12-net
docker stop l3host21
docker stop l3host21-net
docker rm l3host21
docker rm l3host21-net
docker stop l3host22
docker stop l3host22-net
docker rm l3host22
docker rm l3host22-net
docker stop l3host31
docker stop l3host31-net
docker rm l3host31
docker rm l3host31-net
docker stop l3host32
docker stop l3host32-net
docker rm l3host32
docker rm l3host32-net
sudo ip netns delete L3
sudo rm -rf /var/run/netns/l3spine1
sudo rm -rf /var/run/netns/l3spine2
sudo rm -rf /var/run/netns/l3leaf11
sudo rm -rf /var/run/netns/l3leaf12
sudo rm -rf /var/run/netns/l3leaf21
sudo rm -rf /var/run/netns/l3leaf22
sudo rm -rf /var/run/netns/l3leaf31
sudo rm -rf /var/run/netns/l3leaf32
sudo rm -rf /var/run/netns/l3brdr1
sudo rm -rf /var/run/netns/l3brdr2
