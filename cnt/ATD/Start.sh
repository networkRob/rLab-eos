#!/bin/bash
docker start atdhost1
sudo ovs-docker add-port atdleaf1host1 et1 atdhost1 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port atdleaf2host1 et2 atdhost1 --macaddress=00:1c:73:c7:c6:01
docker start atdspine1
sudo ovs-docker add-port atdspine1spine2 et1 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf1 et2 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf2 et3 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf3 et4 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf4 et5 atdspine1 --macaddress=00:1c:73:c0:c6:01
docker start atdleaf4
sudo ovs-docker add-port atdleaf3leaf4 et1 atdleaf4 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port atdspine1leaf4 et2 atdleaf4 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port atdspine2leaf4 et3 atdleaf4 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port atdleaf4host2 et4 atdleaf4 --macaddress=00:1c:73:c5:c6:01
docker start atdspine2
sudo ovs-docker add-port atdspine1spine2 et1 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf1 et2 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf2 et3 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf3 et4 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf4 et5 atdspine2 --macaddress=00:1c:73:c1:c6:01
docker start atdleaf1
sudo ovs-docker add-port atdleaf1leaf2 et1 atdleaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port atdspine1leaf1 et2 atdleaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port atdspine2leaf1 et3 atdleaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port atdleaf1host1 et4 atdleaf1 --macaddress=00:1c:73:c2:c6:01
docker start atdhost2
sudo ovs-docker add-port atdleaf3host2 et1 atdhost2 --macaddress=00:1c:73:c8:c6:01
sudo ovs-docker add-port atdleaf4host2 et2 atdhost2 --macaddress=00:1c:73:c8:c6:01
docker start atdleaf3
sudo ovs-docker add-port atdleaf3leaf4 et1 atdleaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port atdspine1leaf3 et2 atdleaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port atdspine2leaf3 et3 atdleaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port atdleaf3host2 et4 atdleaf3 --macaddress=00:1c:73:c4:c6:01
docker start atdleaf2
sudo ovs-docker add-port atdleaf1leaf2 et1 atdleaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port atdspine1leaf2 et2 atdleaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port atdspine2leaf2 et3 atdleaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port atdleaf2host1 et4 atdleaf2 --macaddress=00:1c:73:c3:c6:01
