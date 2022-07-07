#!/bin/bash
sudo ip link delete 657cet1 type veth peer name 8f30et1
sudo ip link delete 657cet2 type veth peer name 0aafet2
sudo ip link delete 657cet3 type veth peer name 7b82et2
sudo ip link delete 657cet4 type veth peer name 0369et2
sudo ip link delete 657cet5 type veth peer name 3226et2
sudo ip link delete 657cet6 type veth peer name 8f30et6
sudo ip link delete 8f30et2 type veth peer name 0aafet3
sudo ip link delete 8f30et3 type veth peer name 7b82et3
sudo ip link delete 8f30et4 type veth peer name 0369et3
sudo ip link delete 8f30et5 type veth peer name 3226et3
sudo ip link delete 0aafet1 type veth peer name 7b82et1
sudo ip link delete 0aafet4 type veth peer name 57e1et1
sudo ip link delete 0aafet5 type veth peer name 57e1et3
sudo ip link delete 0aafet6 type veth peer name 7b82et6
sudo ip link delete 7b82et4 type veth peer name 57e1et2
sudo ip link delete 7b82et5 type veth peer name 57e1et4
sudo ip link delete 7b82et6 type veth peer name 57e1et6
sudo ip link delete 0369et1 type veth peer name 3226et1
sudo ip link delete 0369et4 type veth peer name a49det1
sudo ip link delete 0369et5 type veth peer name a49det3
sudo ip link delete 0369et6 type veth peer name 3226et6
sudo ip link delete 3226et4 type veth peer name a49det2
sudo ip link delete 3226et5 type veth peer name a49det4
sudo ip link delete 3226et6 type veth peer name a49det6
docker stop atdspine1
docker stop atdspine1-net
docker rm atdspine1
docker rm atdspine1-net
docker stop atdspine2
docker stop atdspine2-net
docker rm atdspine2
docker rm atdspine2-net
docker stop atdleaf1
docker stop atdleaf1-net
docker rm atdleaf1
docker rm atdleaf1-net
docker stop atdleaf2
docker stop atdleaf2-net
docker rm atdleaf2
docker rm atdleaf2-net
docker stop atdleaf3
docker stop atdleaf3-net
docker rm atdleaf3
docker rm atdleaf3-net
docker stop atdleaf4
docker stop atdleaf4-net
docker rm atdleaf4
docker rm atdleaf4-net
docker stop atdhost1
docker stop atdhost1-net
docker rm atdhost1
docker rm atdhost1-net
docker stop atdhost2
docker stop atdhost2-net
docker rm atdhost2
docker rm atdhost2-net
sudo ip netns delete ATD
sudo rm -rf /var/run/netns/atdspine1
sudo rm -rf /var/run/netns/atdspine2
sudo rm -rf /var/run/netns/atdleaf1
sudo rm -rf /var/run/netns/atdleaf2
sudo rm -rf /var/run/netns/atdleaf3
sudo rm -rf /var/run/netns/atdleaf4
sudo rm -rf /var/run/netns/atdhost1
sudo rm -rf /var/run/netns/atdhost2
