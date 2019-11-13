#!/bin/bash
sudo ovs-vsctl add-br l2spine1spine2
sudo ovs-vsctl set bridge l2spine1spine2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2spine1leaf1
sudo ovs-vsctl set bridge l2spine1leaf1 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2spine1leaf2
sudo ovs-vsctl set bridge l2spine1leaf2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2spine1leaf3
sudo ovs-vsctl set bridge l2spine1leaf3 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2spine2leaf1
sudo ovs-vsctl set bridge l2spine2leaf1 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2spine2leaf2
sudo ovs-vsctl set bridge l2spine2leaf2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2spine2leaf3
sudo ovs-vsctl set bridge l2spine2leaf3 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2leaf1host10
sudo ovs-vsctl set bridge l2leaf1host10 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2leaf1host11
sudo ovs-vsctl set bridge l2leaf1host11 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2leaf2host20
sudo ovs-vsctl set bridge l2leaf2host20 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2leaf2host21
sudo ovs-vsctl set bridge l2leaf2host21 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2leaf3host30
sudo ovs-vsctl set bridge l2leaf3host30 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l2leaf3host31
sudo ovs-vsctl set bridge l2leaf3host31 other-config:forward-bpdu=true
docker create --name=l2spine1 --net=none --privileged -v $(pwd)/configs/L2/spine1/:/mnt/flash:Z -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l2spine1
sudo ovs-docker add-port l2spine1spine2 eth1 l2spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l2spine1leaf1 eth2 l2spine1
sudo ovs-docker add-port l2spine1leaf2 eth3 l2spine1
sudo ovs-docker add-port l2spine1leaf3 eth4 l2spine1
docker create --name=l2spine2 --net=none --privileged -v $(pwd)/configs/L2/spine2/:/mnt/flash:Z -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l2spine2
sudo ovs-docker add-port l2spine1spine2 eth1 l2spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l2spine2leaf1 eth2 l2spine2
sudo ovs-docker add-port l2spine2leaf2 eth3 l2spine2
sudo ovs-docker add-port l2spine2leaf3 eth4 l2spine2
docker create --name=l2leaf1 --net=none --privileged -v $(pwd)/configs/L2/leaf1/:/mnt/flash:Z -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l2leaf1
sudo ovs-docker add-port l2spine1leaf1 eth1 l2leaf1 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l2spine2leaf1 eth2 l2leaf1
sudo ovs-docker add-port l2leaf1host10 eth3 l2leaf1
sudo ovs-docker add-port l2leaf1host11 eth4 l2leaf1
docker create --name=l2leaf3 --net=none --privileged -v $(pwd)/configs/L2/leaf3/:/mnt/flash:Z -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l2leaf3
sudo ovs-docker add-port l2spine1leaf3 eth1 l2leaf3 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l2spine2leaf3 eth2 l2leaf3
sudo ovs-docker add-port l2leaf3host30 eth3 l2leaf3
sudo ovs-docker add-port l2leaf3host31 eth4 l2leaf3
docker create --name=l2leaf2 --net=none --privileged -v $(pwd)/configs/L2/leaf2/:/mnt/flash:Z -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l2leaf2
sudo ovs-docker add-port l2spine1leaf2 eth1 l2leaf2 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l2spine2leaf2 eth2 l2leaf2
sudo ovs-docker add-port l2leaf2host20 eth3 l2leaf2
sudo ovs-docker add-port l2leaf2host21 eth4 l2leaf2
docker create --name=l2host31 --hostname=l2host31 --net=none chost:0.1
docker start l2host31
sudo ovs-docker add-port l2leaf3host31 eth0 l2host31 --ipaddress=10.0.13.31/24 --gateway=10.0.13.1
docker create --name=l2host30 --hostname=l2host30 --net=none chost:0.1
docker start l2host30
sudo ovs-docker add-port l2leaf3host30 eth0 l2host30 --ipaddress=10.0.12.31/24 --gateway=10.0.12.1
docker create --name=l2host20 --hostname=l2host20 --net=none chost:0.1
docker start l2host20
sudo ovs-docker add-port l2leaf2host20 eth0 l2host20 --ipaddress=10.0.12.21/24 --gateway=10.0.12.1
docker create --name=l2host21 --hostname=l2host21 --net=none chost:0.1
docker start l2host21
sudo ovs-docker add-port l2leaf2host21 eth0 l2host21 --ipaddress=10.0.13.21/24 --gateway=10.0.13.1
docker create --name=l2host11 --hostname=l2host11 --net=none chost:0.1
docker start l2host11
sudo ovs-docker add-port l2leaf1host11 eth0 l2host11 --ipaddress=10.0.13.11/24 --gateway=10.0.13.1
docker create --name=l2host10 --hostname=l2host10 --net=none chost:0.1
docker start l2host10
sudo ovs-docker add-port l2leaf1host10 eth0 l2host10 --ipaddress=10.0.12.11/24 --gateway=10.0.12.1
