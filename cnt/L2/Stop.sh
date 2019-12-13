#!/bin/bash
sudo ovs-docker del-port l2spine1spine2 et1 l2spine1
sudo ovs-docker del-port l2spine1leaf1 et2 l2spine1
sudo ovs-docker del-port l2spine1leaf2 et3 l2spine1
sudo ovs-docker del-port l2spine1leaf3 et4 l2spine1
docker stop l2spine1
sudo ovs-docker del-port l2spine1spine2 et1 l2spine2
sudo ovs-docker del-port l2spine2leaf1 et2 l2spine2
sudo ovs-docker del-port l2spine2leaf2 et3 l2spine2
sudo ovs-docker del-port l2spine2leaf3 et4 l2spine2
docker stop l2spine2
sudo ovs-docker del-port l2spine1leaf1 et1 l2leaf1
sudo ovs-docker del-port l2spine2leaf1 et2 l2leaf1
sudo ovs-docker del-port l2leaf1host10 et3 l2leaf1
sudo ovs-docker del-port l2leaf1host11 et4 l2leaf1
docker stop l2leaf1
sudo ovs-docker del-port l2spine1leaf3 et1 l2leaf3
sudo ovs-docker del-port l2spine2leaf3 et2 l2leaf3
sudo ovs-docker del-port l2leaf3host30 et3 l2leaf3
sudo ovs-docker del-port l2leaf3host31 et4 l2leaf3
docker stop l2leaf3
sudo ovs-docker del-port l2spine1leaf2 et1 l2leaf2
sudo ovs-docker del-port l2spine2leaf2 et2 l2leaf2
sudo ovs-docker del-port l2leaf2host20 et3 l2leaf2
sudo ovs-docker del-port l2leaf2host21 et4 l2leaf2
docker stop l2leaf2
sudo ovs-docker del-port l2leaf3host31 eth0 l2host31 --ipaddress=10.0.13.31/24 --gateway=10.0.13.1
docker stop l2host31
sudo ovs-docker del-port l2leaf3host30 eth0 l2host30 --ipaddress=10.0.12.31/24 --gateway=10.0.12.1
docker stop l2host30
sudo ovs-docker del-port l2leaf2host20 eth0 l2host20 --ipaddress=10.0.12.21/24 --gateway=10.0.12.1
docker stop l2host20
sudo ovs-docker del-port l2leaf2host21 eth0 l2host21 --ipaddress=10.0.13.21/24 --gateway=10.0.13.1
docker stop l2host21
sudo ovs-docker del-port l2leaf1host11 eth0 l2host11 --ipaddress=10.0.13.11/24 --gateway=10.0.13.1
docker stop l2host11
sudo ovs-docker del-port l2leaf1host10 eth0 l2host10 --ipaddress=10.0.12.11/24 --gateway=10.0.12.1
docker stop l2host10
