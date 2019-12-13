#!/bin/bash
docker start l2spine1
sudo ovs-docker add-port l2spine1spine2 et1 l2spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l2spine1leaf1 et2 l2spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l2spine1leaf2 et3 l2spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l2spine1leaf3 et4 l2spine1 --macaddress=00:1c:73:c0:c6:01
docker start l2spine2
sudo ovs-docker add-port l2spine1spine2 et1 l2spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l2spine2leaf1 et2 l2spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l2spine2leaf2 et3 l2spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l2spine2leaf3 et4 l2spine2 --macaddress=00:1c:73:c1:c6:01
docker start l2leaf1
sudo ovs-docker add-port l2spine1leaf1 et1 l2leaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l2spine2leaf1 et2 l2leaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l2leaf1host10 et3 l2leaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l2leaf1host11 et4 l2leaf1 --macaddress=00:1c:73:c2:c6:01
docker start l2leaf3
sudo ovs-docker add-port l2spine1leaf3 et1 l2leaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l2spine2leaf3 et2 l2leaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l2leaf3host30 et3 l2leaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l2leaf3host31 et4 l2leaf3 --macaddress=00:1c:73:c4:c6:01
docker start l2leaf2
sudo ovs-docker add-port l2spine1leaf2 et1 l2leaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l2spine2leaf2 et2 l2leaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l2leaf2host20 et3 l2leaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l2leaf2host21 et4 l2leaf2 --macaddress=00:1c:73:c3:c6:01
docker start l2host31
sudo ovs-docker add-port l2leaf3host31 eth0 l2host31 --ipaddress=10.0.13.31/24 --gateway=10.0.13.1
docker start l2host30
sudo ovs-docker add-port l2leaf3host30 eth0 l2host30 --ipaddress=10.0.12.31/24 --gateway=10.0.12.1
docker start l2host20
sudo ovs-docker add-port l2leaf2host20 eth0 l2host20 --ipaddress=10.0.12.21/24 --gateway=10.0.12.1
docker start l2host21
sudo ovs-docker add-port l2leaf2host21 eth0 l2host21 --ipaddress=10.0.13.21/24 --gateway=10.0.13.1
docker start l2host11
sudo ovs-docker add-port l2leaf1host11 eth0 l2host11 --ipaddress=10.0.13.11/24 --gateway=10.0.13.1
docker start l2host10
sudo ovs-docker add-port l2leaf1host10 eth0 l2host10 --ipaddress=10.0.12.11/24 --gateway=10.0.12.1
docker exec -d l2host10 iperf3 -s -p 5010
docker exec -d l2host30 iperf3 -s -p 5010
docker exec -d l2host31 iperf3 -s -p 5010
docker exec -d l2host11 iperf3client 10.0.12.31 5010 1000000
docker exec -d l2host20 iperf3client 10.0.12.11 5010 1000000
docker exec -d l2host21 iperf3client 10.0.13.31 5010 1000000
