#!/bin/bash
docker start l3leaf21
sudo ovs-docker add-port l3leaf21leaf22 et1 l3leaf21 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l3spine1leaf21 et2 l3leaf21
sudo ovs-docker add-port l3spine2leaf21 et3 l3leaf21
sudo ovs-docker add-port l3leaf21host21 et4 l3leaf21
docker start l3leaf22
sudo ovs-docker add-port l3leaf21leaf22 et1 l3leaf22 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port l3spine1leaf22 et2 l3leaf22
sudo ovs-docker add-port l3spine2leaf22 et3 l3leaf22
sudo ovs-docker add-port l3leaf22host22 et4 l3leaf22
docker start l3leaf11
sudo ovs-docker add-port l3leaf11leaf12 et1 l3leaf11 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l3spine1leaf11 et2 l3leaf11
sudo ovs-docker add-port l3spine2leaf11 et3 l3leaf11
sudo ovs-docker add-port l3leaf11host11 et4 l3leaf11
sudo ovs-docker add-port l3leaf11host12 et5 l3leaf11
docker start l3leaf12
sudo ovs-docker add-port l3leaf11leaf12 et1 l3leaf12 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l3spine1leaf12 et2 l3leaf12
sudo ovs-docker add-port l3spine2leaf12 et3 l3leaf12
docker start l3leaf32
sudo ovs-docker add-port l3leaf31leaf32 et1 l3leaf32 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port l3spine1leaf32 et2 l3leaf32
sudo ovs-docker add-port l3spine2leaf32 et3 l3leaf32
docker start l3leaf31
sudo ovs-docker add-port l3leaf31leaf32 et1 l3leaf31 --macaddress=00:1c:73:c6:c6:01
sudo ovs-docker add-port l3spine1leaf31 et2 l3leaf31
sudo ovs-docker add-port l3spine2leaf31 et3 l3leaf31
sudo ovs-docker add-port l3leaf31host31 et4 l3leaf31
sudo ovs-docker add-port l3leaf31host32 et5 l3leaf31
docker start l3spine1
sudo ovs-docker add-port l3spine1leaf11 et1 l3spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l3spine1leaf12 et2 l3spine1
sudo ovs-docker add-port l3spine1leaf21 et3 l3spine1
sudo ovs-docker add-port l3spine1leaf22 et4 l3spine1
sudo ovs-docker add-port l3spine1leaf31 et5 l3spine1
sudo ovs-docker add-port l3spine1leaf32 et6 l3spine1
sudo ovs-docker add-port l3spine1brdr1 et7 l3spine1
sudo ovs-docker add-port l3spine1brdr2 et8 l3spine1
docker start l3spine2
sudo ovs-docker add-port l3spine2leaf11 et1 l3spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l3spine2leaf12 et2 l3spine2
sudo ovs-docker add-port l3spine2leaf21 et3 l3spine2
sudo ovs-docker add-port l3spine2leaf22 et4 l3spine2
sudo ovs-docker add-port l3spine2leaf31 et5 l3spine2
sudo ovs-docker add-port l3spine2leaf32 et6 l3spine2
sudo ovs-docker add-port l3spine2brdr1 et7 l3spine2
sudo ovs-docker add-port l3spine2brdr2 et8 l3spine2
docker start l3brdr2
sudo ovs-docker add-port l3brdr1brdr2 et1 l3brdr2 --macaddress=00:1c:73:c9:c6:01
sudo ovs-docker add-port l3spine1brdr2 et2 l3brdr2
sudo ovs-docker add-port l3spine2brdr2 et3 l3brdr2
docker start l3brdr1
sudo ovs-docker add-port l3brdr1brdr2 et1 l3brdr1 --macaddress=00:1c:73:c8:c6:01
sudo ovs-docker add-port l3spine1brdr1 et2 l3brdr1
sudo ovs-docker add-port l3spine2brdr1 et3 l3brdr1
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
