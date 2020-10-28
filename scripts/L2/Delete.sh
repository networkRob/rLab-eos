#!/bin/bash
ip link delete l2spine1et1 type veth peer name l2spine2et1
ip link delete l2spine1et2 type veth peer name l2leaf1et1
ip link delete l2spine1et3 type veth peer name l2leaf2et1
ip link delete l2spine1et4 type veth peer name l2leaf3et1
ip link delete l2spine2et2 type veth peer name l2leaf1et2
ip link delete l2spine2et3 type veth peer name l2leaf2et2
ip link delete l2spine2et4 type veth peer name l2leaf3et2
ip link delete l2leaf1et3 type veth peer name l2host10et0
ip link delete l2leaf1et4 type veth peer name l2host11et0
ip link delete l2leaf2et3 type veth peer name l2host20et0
ip link delete l2leaf2et4 type veth peer name l2host21et0
ip link delete l2leaf3et3 type veth peer name l2host30et0
ip link delete l2leaf3et4 type veth peer name l2host31et0
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
ip netns delete L2
rm -rf /var/run/netns/l2spine1
rm -rf /var/run/netns/l2spine2
rm -rf /var/run/netns/l2leaf1
rm -rf /var/run/netns/l2leaf2
rm -rf /var/run/netns/l2leaf3
