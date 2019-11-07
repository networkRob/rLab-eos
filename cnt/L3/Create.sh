#!/bin/bash
sudo ovs-vsctl add-br l3spine1leaf11
sudo ovs-vsctl set bridge l3spine1leaf11 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine1leaf12
sudo ovs-vsctl set bridge l3spine1leaf12 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine1leaf21
sudo ovs-vsctl set bridge l3spine1leaf21 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine1leaf22
sudo ovs-vsctl set bridge l3spine1leaf22 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine1leaf31
sudo ovs-vsctl set bridge l3spine1leaf31 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine1leaf32
sudo ovs-vsctl set bridge l3spine1leaf32 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine2leaf11
sudo ovs-vsctl set bridge l3spine2leaf11 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine2leaf12
sudo ovs-vsctl set bridge l3spine2leaf12 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine2leaf21
sudo ovs-vsctl set bridge l3spine2leaf21 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine2leaf22
sudo ovs-vsctl set bridge l3spine2leaf22 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine2leaf31
sudo ovs-vsctl set bridge l3spine2leaf31 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3spine2leaf32
sudo ovs-vsctl set bridge l3spine2leaf32 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3leaf11leaf12
sudo ovs-vsctl set bridge l3leaf11leaf12 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3leaf11host11
sudo ovs-vsctl set bridge l3leaf11host11 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3leaf21leaf22
sudo ovs-vsctl set bridge l3leaf21leaf22 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3leaf21host21
sudo ovs-vsctl set bridge l3leaf21host21 other-config:forward-bpdu=true
sudo ovs-vsctl add-br l3leaf31leaf32
sudo ovs-vsctl set bridge l3leaf31leaf32 other-config:forward-bpdu=true
docker volume create l3leaf21
docker create --name=l3leaf21 --net=none --privileged --mount source=l3leaf21,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/leaf21/* $(docker volume inspect --format '{{ .Mountpoint }}' l3leaf21)/
docker start l3leaf21
sudo ovs-docker add-port l3leaf21leaf22 eth1 l3leaf21 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port l3spine1leaf21 eth2 l3leaf21
sudo ovs-docker add-port l3spine2leaf21 eth3 l3leaf21
sudo ovs-docker add-port l3leaf21host21 eth4 l3leaf21
docker volume create l3leaf22
docker create --name=l3leaf22 --net=none --privileged --mount source=l3leaf22,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/leaf22/* $(docker volume inspect --format '{{ .Mountpoint }}' l3leaf22)/
docker start l3leaf22
sudo ovs-docker add-port l3leaf21leaf22 eth1 l3leaf22 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port l3spine1leaf22 eth2 l3leaf22
sudo ovs-docker add-port l3spine2leaf22 eth3 l3leaf22
docker volume create l3leaf11
docker create --name=l3leaf11 --net=none --privileged --mount source=l3leaf11,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/leaf11/* $(docker volume inspect --format '{{ .Mountpoint }}' l3leaf11)/
docker start l3leaf11
sudo ovs-docker add-port l3leaf11leaf12 eth1 l3leaf11 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port l3spine1leaf11 eth2 l3leaf11
sudo ovs-docker add-port l3spine2leaf11 eth3 l3leaf11
sudo ovs-docker add-port l3leaf11host11 eth4 l3leaf11
docker volume create l3leaf12
docker create --name=l3leaf12 --net=none --privileged --mount source=l3leaf12,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/leaf12/* $(docker volume inspect --format '{{ .Mountpoint }}' l3leaf12)/
docker start l3leaf12
sudo ovs-docker add-port l3leaf11leaf12 eth1 l3leaf12 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port l3spine1leaf12 eth2 l3leaf12
sudo ovs-docker add-port l3spine2leaf12 eth3 l3leaf12
docker volume create l3leaf32
docker create --name=l3leaf32 --net=none --privileged --mount source=l3leaf32,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/leaf32/* $(docker volume inspect --format '{{ .Mountpoint }}' l3leaf32)/
docker start l3leaf32
sudo ovs-docker add-port l3leaf31leaf32 eth1 l3leaf32 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port l3spine1leaf32 eth2 l3leaf32
sudo ovs-docker add-port l3spine2leaf32 eth3 l3leaf32
docker volume create l3leaf31
docker create --name=l3leaf31 --net=none --privileged --mount source=l3leaf31,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/leaf31/* $(docker volume inspect --format '{{ .Mountpoint }}' l3leaf31)/
docker start l3leaf31
sudo ovs-docker add-port l3leaf31leaf32 eth1 l3leaf31 --macaddress=00:1c:73:c6:c6:01
sudo ovs-docker add-port l3spine1leaf31 eth2 l3leaf31
sudo ovs-docker add-port l3spine2leaf31 eth3 l3leaf31
docker volume create l3spine1
docker create --name=l3spine1 --net=none --privileged --mount source=l3spine1,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/spine1/* $(docker volume inspect --format '{{ .Mountpoint }}' l3spine1)/
docker start l3spine1
sudo ovs-docker add-port l3spine1leaf11 eth1 l3spine1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port l3spine1leaf12 eth2 l3spine1
sudo ovs-docker add-port l3spine1leaf21 eth3 l3spine1
sudo ovs-docker add-port l3spine1leaf22 eth4 l3spine1
sudo ovs-docker add-port l3spine1leaf31 eth5 l3spine1
sudo ovs-docker add-port l3spine1leaf32 eth6 l3spine1
docker volume create l3spine2
docker create --name=l3spine2 --net=none --privileged --mount source=l3spine2,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp -r $(pwd)/configs/L3/spine2/* $(docker volume inspect --format '{{ .Mountpoint }}' l3spine2)/
docker start l3spine2
sudo ovs-docker add-port l3spine2leaf11 eth1 l3spine2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port l3spine2leaf12 eth2 l3spine2
sudo ovs-docker add-port l3spine2leaf21 eth3 l3spine2
sudo ovs-docker add-port l3spine2leaf22 eth4 l3spine2
sudo ovs-docker add-port l3spine2leaf31 eth5 l3spine2
sudo ovs-docker add-port l3spine2leaf32 eth6 l3spine2
docker create --name=l3host11 --hostname=l3host11 --net=none chost:0.1
docker start l3host11
sudo ovs-docker add-port l3leaf11host11 eth0 l3host11 --ipaddress=192.168.12.11/24 --gateway=192.168.12.1
docker create --name=l3host21 --hostname=l3host21 --net=none chost:0.1
docker start l3host21
sudo ovs-docker add-port l3leaf21host21 eth0 l3host21 --ipaddress=192.168.12.21/24 --gateway=192.168.12.1
