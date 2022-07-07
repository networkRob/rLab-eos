#!/bin/bash
sudo ip link delete 32ceet1 type veth peer name 429det1
sudo ip link delete 32ceet2 type veth peer name 6f70et1
sudo ip link delete 32ceet3 type veth peer name c06fet1
sudo ip link delete 32ceet4 type veth peer name fbb5et1
sudo ip link delete 429det2 type veth peer name 6f70et2
sudo ip link delete 429det3 type veth peer name c06fet2
sudo ip link delete 429det4 type veth peer name fbb5et2
sudo ip link delete 6f70et3 type veth peer name 29a4et0
sudo ip link delete 6f70et4 type veth peer name 98b4et0
sudo ip link delete c06fet3 type veth peer name 0bccet0
sudo ip link delete c06fet4 type veth peer name b143et0
sudo ip link delete fbb5et3 type veth peer name 2092et0
sudo ip link delete fbb5et4 type veth peer name 5aacet0
docker stop l2spine1
docker stop l2spine1-net
docker rm l2spine1
docker rm l2spine1-net
docker stop l2spine2
docker stop l2spine2-net
docker rm l2spine2
docker rm l2spine2-net
docker stop l2leaf1
docker stop l2leaf1-net
docker rm l2leaf1
docker rm l2leaf1-net
docker stop l2leaf2
docker stop l2leaf2-net
docker rm l2leaf2
docker rm l2leaf2-net
docker stop l2leaf3
docker stop l2leaf3-net
docker rm l2leaf3
docker rm l2leaf3-net
docker stop l2host10
docker stop l2host10-net
docker rm l2host10
docker rm l2host10-net
docker stop l2host11
docker stop l2host11-net
docker rm l2host11
docker rm l2host11-net
docker stop l2host20
docker stop l2host20-net
docker rm l2host20
docker rm l2host20-net
docker stop l2host21
docker stop l2host21-net
docker rm l2host21
docker rm l2host21-net
docker stop l2host30
docker stop l2host30-net
docker rm l2host30
docker rm l2host30-net
docker stop l2host31
docker stop l2host31-net
docker rm l2host31
docker rm l2host31-net
sudo ip netns delete L2
sudo rm -rf /var/run/netns/l2spine1
sudo rm -rf /var/run/netns/l2spine2
sudo rm -rf /var/run/netns/l2leaf1
sudo rm -rf /var/run/netns/l2leaf2
sudo rm -rf /var/run/netns/l2leaf3
