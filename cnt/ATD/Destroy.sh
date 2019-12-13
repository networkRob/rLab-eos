#!/bin/bash
sudo ovs-docker del-port atdleaf1host1 et1 atdhost1
sudo ovs-docker del-port atdleaf2host1 et2 atdhost1
docker stop atdhost1
docker rm atdhost1
sudo ovs-docker del-port atdspine1spine2 et1 atdspine1
sudo ovs-docker del-port atdspine1leaf1 et2 atdspine1
sudo ovs-docker del-port atdspine1leaf2 et3 atdspine1
sudo ovs-docker del-port atdspine1leaf3 et4 atdspine1
sudo ovs-docker del-port atdspine1leaf4 et5 atdspine1
docker stop atdspine1
docker rm atdspine1
sudo ovs-docker del-port atdleaf3leaf4 et1 atdleaf4
sudo ovs-docker del-port atdspine1leaf4 et2 atdleaf4
sudo ovs-docker del-port atdspine2leaf4 et3 atdleaf4
sudo ovs-docker del-port atdleaf4host2 et4 atdleaf4
docker stop atdleaf4
docker rm atdleaf4
sudo ovs-docker del-port atdspine1spine2 et1 atdspine2
sudo ovs-docker del-port atdspine2leaf1 et2 atdspine2
sudo ovs-docker del-port atdspine2leaf2 et3 atdspine2
sudo ovs-docker del-port atdspine2leaf3 et4 atdspine2
sudo ovs-docker del-port atdspine2leaf4 et5 atdspine2
docker stop atdspine2
docker rm atdspine2
sudo ovs-docker del-port atdleaf1leaf2 et1 atdleaf1
sudo ovs-docker del-port atdspine1leaf1 et2 atdleaf1
sudo ovs-docker del-port atdspine2leaf1 et3 atdleaf1
sudo ovs-docker del-port atdleaf1host1 et4 atdleaf1
docker stop atdleaf1
docker rm atdleaf1
sudo ovs-docker del-port atdleaf3host2 et1 atdhost2
sudo ovs-docker del-port atdleaf4host2 et2 atdhost2
docker stop atdhost2
docker rm atdhost2
sudo ovs-docker del-port atdleaf3leaf4 et1 atdleaf3
sudo ovs-docker del-port atdspine1leaf3 et2 atdleaf3
sudo ovs-docker del-port atdspine2leaf3 et3 atdleaf3
sudo ovs-docker del-port atdleaf3host2 et4 atdleaf3
docker stop atdleaf3
docker rm atdleaf3
sudo ovs-docker del-port atdleaf1leaf2 et1 atdleaf2
sudo ovs-docker del-port atdspine1leaf2 et2 atdleaf2
sudo ovs-docker del-port atdspine1leaf2 et3 atdleaf2
sudo ovs-docker del-port atdleaf2host1 et4 atdleaf2
docker stop atdleaf2
docker rm atdleaf2
sudo ovs-vsctl del-br atdspine1spine2
sudo ovs-vsctl del-br atdspine1leaf1
sudo ovs-vsctl del-br atdspine1leaf2
sudo ovs-vsctl del-br atdspine1leaf3
sudo ovs-vsctl del-br atdspine1leaf4
sudo ovs-vsctl del-br atdspine2leaf1
sudo ovs-vsctl del-br atdspine2leaf2
sudo ovs-vsctl del-br atdspine2leaf3
sudo ovs-vsctl del-br atdspine2leaf4
sudo ovs-vsctl del-br atdleaf1leaf2
sudo ovs-vsctl del-br atdleaf1host1
sudo ovs-vsctl del-br atdleaf2host1
sudo ovs-vsctl del-br atdleaf3leaf4
sudo ovs-vsctl del-br atdleaf3host2
sudo ovs-vsctl del-br atdleaf4host2
