#!/bin/bash
docker stop l2spine1
docker rm l2spine1
sudo ovs-docker del-port l2spine1spine2 eth1 l2spine1
sudo ovs-docker del-port l2spine1leaf1 eth2 l2spine1
sudo ovs-docker del-port l2spine1leaf2 eth3 l2spine1
sudo ovs-docker del-port l2spine1leaf3 eth4 l2spine1
docker stop l2spine2
docker rm l2spine2
sudo ovs-docker del-port l2spine1spine2 eth1 l2spine2
sudo ovs-docker del-port l2spine2leaf1 eth2 l2spine2
sudo ovs-docker del-port l2spine2leaf2 eth3 l2spine2
sudo ovs-docker del-port l2spine2leaf3 eth4 l2spine2
docker stop l2leaf1
docker rm l2leaf1
sudo ovs-docker del-port l2spine1leaf1 eth1 l2leaf1
sudo ovs-docker del-port l2spine2leaf1 eth2 l2leaf1
sudo ovs-docker del-port l2leaf1host10 eth3 l2leaf1
sudo ovs-docker del-port l2leaf1host11 eth4 l2leaf1
docker stop l2leaf3
docker rm l2leaf3
sudo ovs-docker del-port l2spine1leaf3 eth1 l2leaf3
sudo ovs-docker del-port l2spine2leaf3 eth2 l2leaf3
sudo ovs-docker del-port l2leaf3host30 eth3 l2leaf3
sudo ovs-docker del-port l2leaf3host31 eth4 l2leaf3
docker stop l2leaf2
docker rm l2leaf2
sudo ovs-docker del-port l2spine1leaf2 eth1 l2leaf2
sudo ovs-docker del-port l2spine2leaf2 eth2 l2leaf2
sudo ovs-docker del-port l2leaf2host20 eth3 l2leaf2
sudo ovs-docker del-port l2leaf2host21 eth4 l2leaf2
sudo ovs-vsctl del-br l2spine1spine2
sudo ovs-vsctl del-br l2spine1leaf1
sudo ovs-vsctl del-br l2spine1leaf2
sudo ovs-vsctl del-br l2spine1leaf3
sudo ovs-vsctl del-br l2spine2leaf1
sudo ovs-vsctl del-br l2spine2leaf2
sudo ovs-vsctl del-br l2spine2leaf3
sudo ovs-vsctl del-br l2leaf1host10
sudo ovs-vsctl del-br l2leaf1host11
sudo ovs-vsctl del-br l2leaf2host20
sudo ovs-vsctl del-br l2leaf2host21
sudo ovs-vsctl del-br l2leaf3host30
sudo ovs-vsctl del-br l2leaf3host31