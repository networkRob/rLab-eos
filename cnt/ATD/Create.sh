#!/bin/bash
sudo ovs-vsctl add-br atdspine1spine2
sudo ovs-vsctl set bridge atdspine1spine2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine1leaf1
sudo ovs-vsctl set bridge atdspine1leaf1 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine1leaf2
sudo ovs-vsctl set bridge atdspine1leaf2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine1leaf3
sudo ovs-vsctl set bridge atdspine1leaf3 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine1leaf4
sudo ovs-vsctl set bridge atdspine1leaf4 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine2leaf1
sudo ovs-vsctl set bridge atdspine2leaf1 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine2leaf2
sudo ovs-vsctl set bridge atdspine2leaf2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine2leaf3
sudo ovs-vsctl set bridge atdspine2leaf3 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdspine2leaf4
sudo ovs-vsctl set bridge atdspine2leaf4 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdleaf1leaf2
sudo ovs-vsctl set bridge atdleaf1leaf2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdleaf1host1
sudo ovs-vsctl set bridge atdleaf1host1 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdleaf2host1
sudo ovs-vsctl set bridge atdleaf2host1 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdleaf3leaf4
sudo ovs-vsctl set bridge atdleaf3leaf4 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdleaf3host2
sudo ovs-vsctl set bridge atdleaf3host2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br atdleaf4host2
sudo ovs-vsctl set bridge atdleaf4host2 other-config:forward-bpdu=true
docker create --name=atdhost1 --net=none --privileged -v $(pwd)/configs/ATD/host1/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdhost1
sudo ovs-docker add-port atdleaf1host1 et1 atdhost1 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port atdleaf2host1 et2 atdhost1 --macaddress=00:1c:73:c7:c6:01
docker create --name=atdspine1 --net=none --privileged -v $(pwd)/configs/ATD/spine1/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdspine1
sudo ovs-docker add-port atdspine1spine2 et1 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf1 et2 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf2 et3 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf3 et4 atdspine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port atdspine1leaf4 et5 atdspine1 --macaddress=00:1c:73:c0:c6:01
docker create --name=atdleaf4 --net=none --privileged -v $(pwd)/configs/ATD/leaf4/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf4
sudo ovs-docker add-port atdleaf3leaf4 et1 atdleaf4 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port atdspine1leaf4 et2 atdleaf4 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port atdspine2leaf4 et3 atdleaf4 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port atdleaf4host2 et4 atdleaf4 --macaddress=00:1c:73:c5:c6:01
docker create --name=atdspine2 --net=none --privileged -v $(pwd)/configs/ATD/spine2/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdspine2
sudo ovs-docker add-port atdspine1spine2 et1 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf1 et2 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf2 et3 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf3 et4 atdspine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port atdspine2leaf4 et5 atdspine2 --macaddress=00:1c:73:c1:c6:01
docker create --name=atdleaf1 --net=none --privileged -v $(pwd)/configs/ATD/leaf1/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf1
sudo ovs-docker add-port atdleaf1leaf2 et1 atdleaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port atdspine1leaf1 et2 atdleaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port atdspine2leaf1 et3 atdleaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port atdleaf1host1 et4 atdleaf1 --macaddress=00:1c:73:c2:c6:01
docker create --name=atdhost2 --net=none --privileged -v $(pwd)/configs/ATD/host2/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdhost2
sudo ovs-docker add-port atdleaf3host2 et1 atdhost2 --macaddress=00:1c:73:c8:c6:01
sudo ovs-docker add-port atdleaf4host2 et2 atdhost2 --macaddress=00:1c:73:c8:c6:01
docker create --name=atdleaf3 --net=none --privileged -v $(pwd)/configs/ATD/leaf3/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf3
sudo ovs-docker add-port atdleaf3leaf4 et1 atdleaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port atdspine1leaf3 et2 atdleaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port atdspine2leaf3 et3 atdleaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port atdleaf3host2 et4 atdleaf3 --macaddress=00:1c:73:c4:c6:01
docker create --name=atdleaf2 --net=none --privileged -v $(pwd)/configs/ATD/leaf2/:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=et0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=et0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf2
sudo ovs-docker add-port atdleaf1leaf2 et1 atdleaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port atdspine1leaf2 et2 atdleaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port atdspine1leaf2 et3 atdleaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port atdleaf2host1 et4 atdleaf2 --macaddress=00:1c:73:c3:c6:01
