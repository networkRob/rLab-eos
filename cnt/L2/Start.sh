#!/bin/bash
docker start l2spine1
sudo ovs-docker add-port l2spine1spine2 eth1 l2spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l2spine1leaf1 eth2 l2spine1
sudo ovs-docker add-port l2spine1leaf2 eth3 l2spine1
sudo ovs-docker add-port l2spine1leaf3 eth4 l2spine1
docker start l2spine2
sudo ovs-docker add-port l2spine1spine2 eth1 l2spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l2spine2leaf1 eth2 l2spine2
sudo ovs-docker add-port l2spine2leaf2 eth3 l2spine2
sudo ovs-docker add-port l2spine2leaf3 eth4 l2spine2
docker start l2leaf1
sudo ovs-docker add-port l2spine1leaf1 eth1 l2leaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l2spine2leaf1 eth2 l2leaf1
sudo ovs-docker add-port l2leaf1host10 eth3 l2leaf1
sudo ovs-docker add-port l2leaf1host11 eth4 l2leaf1
docker start l2leaf3
sudo ovs-docker add-port l2spine1leaf3 eth1 l2leaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l2spine2leaf3 eth2 l2leaf3
sudo ovs-docker add-port l2leaf3host30 eth3 l2leaf3
sudo ovs-docker add-port l2leaf3host31 eth4 l2leaf3
docker start l2leaf2
sudo ovs-docker add-port l2spine1leaf2 eth1 l2leaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l2spine2leaf2 eth2 l2leaf2
sudo ovs-docker add-port l2leaf2host20 eth3 l2leaf2
sudo ovs-docker add-port l2leaf2host21 eth4 l2leaf2
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
docker exec -d l2host11 while true; do iperf3 -c 10.0.12.31/24 -p 5010 -b 10000000; done
docker exec -d l2host20 while true; do iperf3 -c 10.0.12.11/24 -p 5010 -b 10000000; done
docker exec -d l2host21 while true; do iperf3 -c 10.0.13.31/24 -p 5010 -b 10000000; done
