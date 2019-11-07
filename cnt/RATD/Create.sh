#!/bin/bash
sudo ovs-vsctl add-br ratdeos1eos2
sudo ovs-vsctl set bridge ratdeos1eos2 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos1eos7
sudo ovs-vsctl set bridge ratdeos1eos7 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos1eos11
sudo ovs-vsctl set bridge ratdeos1eos11 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos1eos6
sudo ovs-vsctl set bridge ratdeos1eos6 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos1eos5
sudo ovs-vsctl set bridge ratdeos1eos5 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos1eos17
sudo ovs-vsctl set bridge ratdeos1eos17 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos2eos3
sudo ovs-vsctl set bridge ratdeos2eos3 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos2eos4
sudo ovs-vsctl set bridge ratdeos2eos4 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos2eos5
sudo ovs-vsctl set bridge ratdeos2eos5 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos2eos6
sudo ovs-vsctl set bridge ratdeos2eos6 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos3eos9
sudo ovs-vsctl set bridge ratdeos3eos9 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos3eos7
sudo ovs-vsctl set bridge ratdeos3eos7 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos3eos5
sudo ovs-vsctl set bridge ratdeos3eos5 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos3eos4
sudo ovs-vsctl set bridge ratdeos3eos4 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos3eos20
sudo ovs-vsctl set bridge ratdeos3eos20 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos4eos9
sudo ovs-vsctl set bridge ratdeos4eos9 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos4eos8
sudo ovs-vsctl set bridge ratdeos4eos8 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos4eos5
sudo ovs-vsctl set bridge ratdeos4eos5 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos4eos16
sudo ovs-vsctl set bridge ratdeos4eos16 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos5eos6
sudo ovs-vsctl set bridge ratdeos5eos6 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos6eos8
sudo ovs-vsctl set bridge ratdeos6eos8 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos6eos13
sudo ovs-vsctl set bridge ratdeos6eos13 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos6eos14
sudo ovs-vsctl set bridge ratdeos6eos14 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos7eos10
sudo ovs-vsctl set bridge ratdeos7eos10 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos7eos19
sudo ovs-vsctl set bridge ratdeos7eos19 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos8eos15
sudo ovs-vsctl set bridge ratdeos8eos15 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos8eos14
sudo ovs-vsctl set bridge ratdeos8eos14 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos8eos18
sudo ovs-vsctl set bridge ratdeos8eos18 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos11eos12
sudo ovs-vsctl set bridge ratdeos11eos12 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos11eos13
sudo ovs-vsctl set bridge ratdeos11eos13 other-config:forward-bpdu=true
sudo ovs-vsctl add-br ratdeos12eos13
sudo ovs-vsctl set bridge ratdeos12eos13 other-config:forward-bpdu=true
docker volume create ratdeos16
docker create --name=ratdeos16 --net=none --privileged --mount source=ratdeos16,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos16/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos16)/
docker start ratdeos16
sudo ovs-docker add-port ratdeos4eos16 eth1 ratdeos16 --macaddress=00:1c:73:d5:c6:01
docker volume create ratdeos9
docker create --name=ratdeos9 --net=none --privileged --mount source=ratdeos9,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos9/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos9)/
docker start ratdeos9
sudo ovs-docker add-port ratdeos4eos9 eth1 ratdeos9 --macaddress=00:1c:73:c8:c6:01
sudo ovs-docker add-port ratdeos3eos9 eth2 ratdeos9
docker volume create ratdeos8
docker create --name=ratdeos8 --net=none --privileged --mount source=ratdeos8,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos8/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos8)/
docker start ratdeos8
sudo ovs-docker add-port ratdeos4eos8 eth1 ratdeos8 --macaddress=00:1c:73:c7:c6:01
sudo ovs-docker add-port ratdeos8eos15 eth2 ratdeos8
sudo ovs-docker add-port ratdeos6eos8 eth3 ratdeos8
sudo ovs-docker add-port ratdeos8eos14 eth4 ratdeos8
sudo ovs-docker add-port ratdeos8eos18 eth5 ratdeos8
docker volume create ratdeos5
docker create --name=ratdeos5 --net=none --privileged --mount source=ratdeos5,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos5/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos5)/
docker start ratdeos5
sudo ovs-docker add-port ratdeos4eos5 eth1 ratdeos5 --macaddress=00:1c:73:c4:c6:01
sudo ovs-docker add-port ratdeos3eos5 eth2 ratdeos5
sudo ovs-docker add-port ratdeos2eos5 eth3 ratdeos5
sudo ovs-docker add-port ratdeos1eos5 eth4 ratdeos5
sudo ovs-docker add-port ratdeos5eos6 eth5 ratdeos5
docker volume create ratdeos4
docker create --name=ratdeos4 --net=none --privileged --mount source=ratdeos4,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos4/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos4)/
docker start ratdeos4
sudo ovs-docker add-port ratdeos4eos9 eth1 ratdeos4 --macaddress=00:1c:73:c3:c6:01
sudo ovs-docker add-port ratdeos4eos8 eth2 ratdeos4
sudo ovs-docker add-port ratdeos4eos5 eth3 ratdeos4
sudo ovs-docker add-port ratdeos2eos4 eth4 ratdeos4
sudo ovs-docker add-port ratdeos3eos4 eth5 ratdeos4
sudo ovs-docker add-port ratdeos4eos16 eth6 ratdeos4
docker volume create ratdeos7
docker create --name=ratdeos7 --net=none --privileged --mount source=ratdeos7,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos7/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos7)/
docker start ratdeos7
sudo ovs-docker add-port ratdeos3eos7 eth1 ratdeos7 --macaddress=00:1c:73:c6:c6:01
sudo ovs-docker add-port ratdeos7eos10 eth2 ratdeos7
sudo ovs-docker add-port ratdeos1eos7 eth3 ratdeos7
sudo ovs-docker add-port ratdeos7eos19 eth4 ratdeos7
docker volume create ratdeos6
docker create --name=ratdeos6 --net=none --privileged --mount source=ratdeos6,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos6/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos6)/
docker start ratdeos6
sudo ovs-docker add-port ratdeos5eos6 eth1 ratdeos6 --macaddress=00:1c:73:c5:c6:01
sudo ovs-docker add-port ratdeos6eos8 eth2 ratdeos6
sudo ovs-docker add-port ratdeos6eos13 eth3 ratdeos6
sudo ovs-docker add-port ratdeos1eos6 eth4 ratdeos6
sudo ovs-docker add-port ratdeos2eos6 eth5 ratdeos6
sudo ovs-docker add-port ratdeos6eos14 eth6 ratdeos6
docker volume create ratdeos1
docker create --name=ratdeos1 --net=none --privileged --mount source=ratdeos1,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos1/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos1)/
docker start ratdeos1
sudo ovs-docker add-port ratdeos1eos2 eth1 ratdeos1 --macaddress=00:1c:73:c0:c6:01
sudo ovs-docker add-port ratdeos1eos7 eth2 ratdeos1
sudo ovs-docker add-port ratdeos1eos11 eth3 ratdeos1
sudo ovs-docker add-port ratdeos1eos6 eth4 ratdeos1
sudo ovs-docker add-port ratdeos1eos5 eth5 ratdeos1
sudo ovs-docker add-port ratdeos1eos17 eth6 ratdeos1
docker volume create ratdeos10
docker create --name=ratdeos10 --net=none --privileged --mount source=ratdeos10,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos10/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos10)/
docker start ratdeos10
sudo ovs-docker add-port ratdeos7eos10 eth1 ratdeos10 --macaddress=00:1c:73:c9:c6:01
docker volume create ratdeos3
docker create --name=ratdeos3 --net=none --privileged --mount source=ratdeos3,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos3/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos3)/
docker start ratdeos3
sudo ovs-docker add-port ratdeos3eos9 eth1 ratdeos3 --macaddress=00:1c:73:c2:c6:01
sudo ovs-docker add-port ratdeos3eos7 eth2 ratdeos3
sudo ovs-docker add-port ratdeos2eos3 eth3 ratdeos3
sudo ovs-docker add-port ratdeos3eos5 eth4 ratdeos3
sudo ovs-docker add-port ratdeos3eos4 eth5 ratdeos3
sudo ovs-docker add-port ratdeos3eos20 eth6 ratdeos3
docker volume create ratdeos2
docker create --name=ratdeos2 --net=none --privileged --mount source=ratdeos2,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos2/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos2)/
docker start ratdeos2
sudo ovs-docker add-port ratdeos2eos3 eth1 ratdeos2 --macaddress=00:1c:73:c1:c6:01
sudo ovs-docker add-port ratdeos2eos4 eth2 ratdeos2
sudo ovs-docker add-port ratdeos2eos5 eth3 ratdeos2
sudo ovs-docker add-port ratdeos2eos6 eth4 ratdeos2
sudo ovs-docker add-port ratdeos1eos2 eth5 ratdeos2
docker volume create ratdeos15
docker create --name=ratdeos15 --net=none --privileged --mount source=ratdeos15,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos15/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos15)/
docker start ratdeos15
sudo ovs-docker add-port ratdeos8eos15 eth1 ratdeos15 --macaddress=00:1c:73:d4:c6:01
docker volume create ratdeos20
docker create --name=ratdeos20 --net=none --privileged --mount source=ratdeos20,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos20/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos20)/
docker start ratdeos20
sudo ovs-docker add-port ratdeos3eos20 eth1 ratdeos20 --macaddress=00:1c:73:d9:c6:01
docker volume create ratdeos13
docker create --name=ratdeos13 --net=none --privileged --mount source=ratdeos13,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos13/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos13)/
docker start ratdeos13
sudo ovs-docker add-port ratdeos6eos13 eth1 ratdeos13 --macaddress=00:1c:73:d2:c6:01
sudo ovs-docker add-port ratdeos12eos13 eth2 ratdeos13
sudo ovs-docker add-port ratdeos11eos13 eth3 ratdeos13
docker volume create ratdeos14
docker create --name=ratdeos14 --net=none --privileged --mount source=ratdeos14,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos14/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos14)/
docker start ratdeos14
sudo ovs-docker add-port ratdeos8eos14 eth1 ratdeos14 --macaddress=00:1c:73:d3:c6:01
sudo ovs-docker add-port ratdeos6eos14 eth2 ratdeos14
docker volume create ratdeos19
docker create --name=ratdeos19 --net=none --privileged --mount source=ratdeos19,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos19/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos19)/
docker start ratdeos19
sudo ovs-docker add-port ratdeos7eos19 eth1 ratdeos19 --macaddress=00:1c:73:d8:c6:01
docker volume create ratdeos12
docker create --name=ratdeos12 --net=none --privileged --mount source=ratdeos12,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos12/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos12)/
docker start ratdeos12
sudo ovs-docker add-port ratdeos12eos13 eth1 ratdeos12 --macaddress=00:1c:73:d1:c6:01
sudo ovs-docker add-port ratdeos11eos12 eth2 ratdeos12
docker volume create ratdeos11
docker create --name=ratdeos11 --net=none --privileged --mount source=ratdeos11,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos11/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos11)/
docker start ratdeos11
sudo ovs-docker add-port ratdeos1eos11 eth1 ratdeos11 --macaddress=00:1c:73:d0:c6:01
sudo ovs-docker add-port ratdeos11eos12 eth2 ratdeos11
sudo ovs-docker add-port ratdeos11eos13 eth3 ratdeos11
docker volume create ratdeos17
docker create --name=ratdeos17 --net=none --privileged --mount source=ratdeos17,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos17/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos17)/
docker start ratdeos17
sudo ovs-docker add-port ratdeos1eos17 eth1 ratdeos17 --macaddress=00:1c:73:d6:c6:01
docker volume create ratdeos18
docker create --name=ratdeos18 --net=none --privileged --mount source=ratdeos18,target=/mnt/flash -e INTFTYPE=eth -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.22.1F.Trunk /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
sudo cp $(pwd)/configs/RATD/eos18/startup-config $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos18)/
docker start ratdeos18
sudo ovs-docker add-port ratdeos8eos18 eth1 ratdeos18 --macaddress=00:1c:73:d7:c6:01
