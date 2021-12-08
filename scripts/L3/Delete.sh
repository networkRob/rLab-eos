#!/bin/bash
sudo ip link delete l3spine1et1 type veth peer name l3leaf11et2
sudo ip link delete l3spine1et2 type veth peer name l3leaf12et2
sudo ip link delete l3spine1et3 type veth peer name l3leaf21et2
sudo ip link delete l3spine1et4 type veth peer name l3leaf22et2
sudo ip link delete l3spine1et5 type veth peer name l3leaf31et2
sudo ip link delete l3spine1et6 type veth peer name l3leaf32et2
sudo ip link delete l3spine1et7 type veth peer name l3brdr1et2
sudo ip link delete l3spine1et8 type veth peer name l3brdr2et2
sudo ip link delete l3spine2et1 type veth peer name l3leaf11et3
sudo ip link delete l3spine2et2 type veth peer name l3leaf12et3
sudo ip link delete l3spine2et3 type veth peer name l3leaf21et3
sudo ip link delete l3spine2et4 type veth peer name l3leaf22et3
sudo ip link delete l3spine2et5 type veth peer name l3leaf31et3
sudo ip link delete l3spine2et6 type veth peer name l3leaf32et3
sudo ip link delete l3spine2et7 type veth peer name l3brdr1et3
sudo ip link delete l3spine2et8 type veth peer name l3brdr2et3
sudo ip link delete l3leaf11et1 type veth peer name l3leaf12et1
sudo ip link delete l3leaf11et4 type veth peer name l3host11et0
sudo ip link delete l3leaf11et5 type veth peer name l3host12et0
sudo ip link delete l3leaf21et1 type veth peer name l3leaf22et1
sudo ip link delete l3leaf21et4 type veth peer name l3host21et0
sudo ip link delete l3leaf22et4 type veth peer name l3host22et0
sudo ip link delete l3leaf31et1 type veth peer name l3leaf32et1
sudo ip link delete l3leaf31et4 type veth peer name l3host31et0
sudo ip link delete l3leaf31et5 type veth peer name l3host32et0
sudo ip link delete l3brdr1et1 type veth peer name l3brdr2et1
sudo podman stop l3spine1
sudo podman stop l3spine1-net
sudo podman rm l3spine1
sudo podman rm l3spine1-net
sudo podman stop l3spine2
sudo podman stop l3spine2-net
sudo podman rm l3spine2
sudo podman rm l3spine2-net
sudo podman stop l3leaf11
sudo podman stop l3leaf11-net
sudo podman rm l3leaf11
sudo podman rm l3leaf11-net
sudo podman stop l3leaf12
sudo podman stop l3leaf12-net
sudo podman rm l3leaf12
sudo podman rm l3leaf12-net
sudo podman stop l3leaf21
sudo podman stop l3leaf21-net
sudo podman rm l3leaf21
sudo podman rm l3leaf21-net
sudo podman stop l3leaf22
sudo podman stop l3leaf22-net
sudo podman rm l3leaf22
sudo podman rm l3leaf22-net
sudo podman stop l3leaf31
sudo podman stop l3leaf31-net
sudo podman rm l3leaf31
sudo podman rm l3leaf31-net
sudo podman stop l3leaf32
sudo podman stop l3leaf32-net
sudo podman rm l3leaf32
sudo podman rm l3leaf32-net
sudo podman stop l3brdr1
sudo podman stop l3brdr1-net
sudo podman rm l3brdr1
sudo podman rm l3brdr1-net
sudo podman stop l3brdr2
sudo podman stop l3brdr2-net
sudo podman rm l3brdr2
sudo podman rm l3brdr2-net
sudo podman stop l3host11
sudo podman stop l3host11-net
sudo podman rm l3host11
sudo podman rm l3host11-net
sudo podman stop l3host12
sudo podman stop l3host12-net
sudo podman rm l3host12
sudo podman rm l3host12-net
sudo podman stop l3host21
sudo podman stop l3host21-net
sudo podman rm l3host21
sudo podman rm l3host21-net
sudo podman stop l3host22
sudo podman stop l3host22-net
sudo podman rm l3host22
sudo podman rm l3host22-net
sudo podman stop l3host31
sudo podman stop l3host31-net
sudo podman rm l3host31
sudo podman rm l3host31-net
sudo podman stop l3host32
sudo podman stop l3host32-net
sudo podman rm l3host32
sudo podman rm l3host32-net
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
