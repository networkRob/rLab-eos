#!/bin/bash
ip link delete l3spine1et1 type veth peer name l3leaf11et2
ip link delete l3spine1et2 type veth peer name l3leaf12et2
ip link delete l3spine1et3 type veth peer name l3leaf21et2
ip link delete l3spine1et4 type veth peer name l3leaf22et2
ip link delete l3spine1et5 type veth peer name l3leaf31et2
ip link delete l3spine1et6 type veth peer name l3leaf32et2
ip link delete l3spine1et7 type veth peer name l3brdr1et2
ip link delete l3spine1et8 type veth peer name l3brdr2et2
ip link delete l3spine2et1 type veth peer name l3leaf11et3
ip link delete l3spine2et2 type veth peer name l3leaf12et3
ip link delete l3spine2et3 type veth peer name l3leaf21et3
ip link delete l3spine2et4 type veth peer name l3leaf22et3
ip link delete l3spine2et5 type veth peer name l3leaf31et3
ip link delete l3spine2et6 type veth peer name l3leaf32et3
ip link delete l3spine2et7 type veth peer name l3brdr1et3
ip link delete l3spine2et8 type veth peer name l3brdr2et3
ip link delete l3leaf11et1 type veth peer name l3leaf12et1
ip link delete l3leaf11et4 type veth peer name l3host11et0
ip link delete l3leaf11et5 type veth peer name l3host12et0
ip link delete l3leaf21et1 type veth peer name l3leaf22et1
ip link delete l3leaf21et4 type veth peer name l3host21et0
ip link delete l3leaf22et4 type veth peer name l3host22et0
ip link delete l3leaf31et1 type veth peer name l3leaf32et1
ip link delete l3leaf31et4 type veth peer name l3host31et0
ip link delete l3leaf31et5 type veth peer name l3host32et0
ip link delete l3brdr1et1 type veth peer name l3brdr2et1
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
ip netns delete L3
rm -rf /var/run/netns/l3spine1
rm -rf /var/run/netns/l3spine2
rm -rf /var/run/netns/l3leaf11
rm -rf /var/run/netns/l3leaf12
rm -rf /var/run/netns/l3leaf21
rm -rf /var/run/netns/l3leaf22
rm -rf /var/run/netns/l3leaf31
rm -rf /var/run/netns/l3leaf32
rm -rf /var/run/netns/l3brdr1
rm -rf /var/run/netns/l3brdr2
