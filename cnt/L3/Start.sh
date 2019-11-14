#!/bin/bash
docker start l3leaf21
sudo ovs-docker add-port l3leaf21leaf22 eth1 l3leaf21 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l3spine1leaf21 eth2 l3leaf21
sudo ovs-docker add-port l3spine2leaf21 eth3 l3leaf21
sudo ovs-docker add-port l3leaf21host21 eth4 l3leaf21
docker start l3leaf22
sudo ovs-docker add-port l3leaf21leaf22 eth1 l3leaf22 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port l3spine1leaf22 eth2 l3leaf22
sudo ovs-docker add-port l3spine2leaf22 eth3 l3leaf22
sudo ovs-docker add-port l3leaf22host22 eth4 l3leaf22
docker start l3leaf11
sudo ovs-docker add-port l3leaf11leaf12 eth1 l3leaf11 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l3spine1leaf11 eth2 l3leaf11
sudo ovs-docker add-port l3spine2leaf11 eth3 l3leaf11
sudo ovs-docker add-port l3leaf11host11 eth4 l3leaf11
sudo ovs-docker add-port l3leaf11host12 eth5 l3leaf11
docker start l3leaf12
sudo ovs-docker add-port l3leaf11leaf12 eth1 l3leaf12 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l3spine1leaf12 eth2 l3leaf12
sudo ovs-docker add-port l3spine2leaf12 eth3 l3leaf12
docker start l3leaf32
sudo ovs-docker add-port l3leaf31leaf32 eth1 l3leaf32 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port l3spine1leaf32 eth2 l3leaf32
sudo ovs-docker add-port l3spine2leaf32 eth3 l3leaf32
docker start l3leaf31
sudo ovs-docker add-port l3leaf31leaf32 eth1 l3leaf31 --macaddress=00:1c:73:c6:c6:01
sudo ovs-docker add-port l3spine1leaf31 eth2 l3leaf31
sudo ovs-docker add-port l3spine2leaf31 eth3 l3leaf31
sudo ovs-docker add-port l3leaf31host31 eth4 l3leaf31
sudo ovs-docker add-port l3leaf31host32 eth5 l3leaf31
docker start l3spine1
sudo ovs-docker add-port l3spine1leaf11 eth1 l3spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l3spine1leaf12 eth2 l3spine1
sudo ovs-docker add-port l3spine1leaf21 eth3 l3spine1
sudo ovs-docker add-port l3spine1leaf22 eth4 l3spine1
sudo ovs-docker add-port l3spine1leaf31 eth5 l3spine1
sudo ovs-docker add-port l3spine1leaf32 eth6 l3spine1
docker start l3spine2
sudo ovs-docker add-port l3spine2leaf11 eth1 l3spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l3spine2leaf12 eth2 l3spine2
sudo ovs-docker add-port l3spine2leaf21 eth3 l3spine2
sudo ovs-docker add-port l3spine2leaf22 eth4 l3spine2
sudo ovs-docker add-port l3spine2leaf31 eth5 l3spine2
sudo ovs-docker add-port l3spine2leaf32 eth6 l3spine2
docker start l3host31
sudo ovs-docker add-port l3leaf31host31 eth0 l3host31 --ipaddress=192.168.12.31/24 --gateway=192.168.12.1
docker start l3host32
sudo ovs-docker add-port l3leaf31host32 eth0 l3host32 --ipaddress=192.168.13.31/24 --gateway=192.168.13.1
docker start l3host21
sudo ovs-docker add-port l3leaf21host21 eth0 l3host21 --ipaddress=192.168.12.21/24 --gateway=192.168.12.1
docker start l3host12
sudo ovs-docker add-port l3leaf11host12 eth0 l3host12 --ipaddress=192.168.13.11/24 --gateway=192.168.13.1
docker start l3host11
sudo ovs-docker add-port l3leaf11host11 eth0 l3host11 --ipaddress=192.168.12.11/24 --gateway=192.168.12.1
docker start l3host22
sudo ovs-docker add-port l3leaf22host22 eth0 l3host22 --ipaddress=192.168.13.21/24 --gateway=192.168.13.1
docker exec -d l3host11 iperf3 -s -p 5010
docker exec -d l3host12 iperf3 -s -p 5010
docker exec -d l3host31 iperf3 -s -p 5010
docker exec -d l3host21 iperf3client 192.168.12.11 5010 1000000
docker exec -d l3host32 iperf3client 192.168.13.11 5010 1000000
docker exec -d l3host22 iperf3client 192.168.12.31 5010 1000000
