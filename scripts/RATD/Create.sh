#!/bin/bash
if [ "$(docker image ls | grep ceosimage | grep -c 4.25.0F)" == 0 ]
then
    echo "Docker image not found for ceosimage:4.25.0F, please build it first."
    exit
fi
if [ "$(docker image ls | grep chost | grep -c 0.5)" == 0 ]
then
    echo "Docker image not found for chost:0.5, please build it first."
    exit
fi
ip netns add RATD
# Creating veths
ip link add ratdeos1et1 type veth peer name ratdeos2et5
ip link add ratdeos1et2 type veth peer name ratdeos7et3
ip link add ratdeos1et3 type veth peer name ratdeos11et1
ip link add ratdeos1et4 type veth peer name ratdeos6et4
ip link add ratdeos1et5 type veth peer name ratdeos5et4
ip link add ratdeos1et6 type veth peer name ratdeos17et1
ip link add ratdeos2et1 type veth peer name ratdeos3et3
ip link add ratdeos2et2 type veth peer name ratdeos4et4
ip link add ratdeos2et3 type veth peer name ratdeos5et3
ip link add ratdeos2et4 type veth peer name ratdeos6et5
ip link add ratdeos3et1 type veth peer name ratdeos9et2
ip link add ratdeos3et2 type veth peer name ratdeos7et1
ip link add ratdeos3et4 type veth peer name ratdeos5et2
ip link add ratdeos3et5 type veth peer name ratdeos4et5
ip link add ratdeos3et6 type veth peer name ratdeos20et1
ip link add ratdeos4et1 type veth peer name ratdeos9et1
ip link add ratdeos4et2 type veth peer name ratdeos8et1
ip link add ratdeos4et3 type veth peer name ratdeos5et1
ip link add ratdeos4et6 type veth peer name ratdeos16et1
ip link add ratdeos5et5 type veth peer name ratdeos6et1
ip link add ratdeos6et2 type veth peer name ratdeos8et3
ip link add ratdeos6et3 type veth peer name ratdeos13et1
ip link add ratdeos6et6 type veth peer name ratdeos14et2
ip link add ratdeos7et2 type veth peer name ratdeos10et1
ip link add ratdeos7et4 type veth peer name ratdeos19et1
ip link add ratdeos8et2 type veth peer name ratdeos15et1
ip link add ratdeos8et4 type veth peer name ratdeos14et1
ip link add ratdeos8et5 type veth peer name ratdeos18et1
ip link add ratdeos11et2 type veth peer name ratdeos12et2
ip link add ratdeos11et3 type veth peer name ratdeos13et3
ip link add ratdeos12et1 type veth peer name ratdeos13et2
#
#
# Creating anchor containers
#
# Getting eos1 nodes plumbing
docker run -d --restart=always --name=ratdeos1-net --net=none busybox /bin/init
ratdeos1pid=$(docker inspect --format '{{.State.Pid}}' ratdeos1-net)
ln -sf /proc/${ratdeos1pid}/ns/net /var/run/netns/ratdeos1
# Connecting cEOS containers together
ip link set ratdeos1et1 netns ratdeos1 name et1 up
ip link set ratdeos1et2 netns ratdeos1 name et2 up
ip link set ratdeos1et3 netns ratdeos1 name et3 up
ip link set ratdeos1et4 netns ratdeos1 name et4 up
ip link set ratdeos1et5 netns ratdeos1 name et5 up
ip link set ratdeos1et6 netns ratdeos1 name et6 up
sleep 1
docker run -d --name=ratdeos1 --net=container:ratdeos1-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos2 nodes plumbing
docker run -d --restart=always --name=ratdeos2-net --net=none busybox /bin/init
ratdeos2pid=$(docker inspect --format '{{.State.Pid}}' ratdeos2-net)
ln -sf /proc/${ratdeos2pid}/ns/net /var/run/netns/ratdeos2
# Connecting cEOS containers together
ip link set ratdeos2et1 netns ratdeos2 name et1 up
ip link set ratdeos2et2 netns ratdeos2 name et2 up
ip link set ratdeos2et3 netns ratdeos2 name et3 up
ip link set ratdeos2et4 netns ratdeos2 name et4 up
ip link set ratdeos2et5 netns ratdeos2 name et5 up
sleep 1
docker run -d --name=ratdeos2 --net=container:ratdeos2-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos3 nodes plumbing
docker run -d --restart=always --name=ratdeos3-net --net=none busybox /bin/init
ratdeos3pid=$(docker inspect --format '{{.State.Pid}}' ratdeos3-net)
ln -sf /proc/${ratdeos3pid}/ns/net /var/run/netns/ratdeos3
# Connecting cEOS containers together
ip link set ratdeos3et1 netns ratdeos3 name et1 up
ip link set ratdeos3et2 netns ratdeos3 name et2 up
ip link set ratdeos3et3 netns ratdeos3 name et3 up
ip link set ratdeos3et4 netns ratdeos3 name et4 up
ip link set ratdeos3et5 netns ratdeos3 name et5 up
ip link set ratdeos3et6 netns ratdeos3 name et6 up
sleep 1
docker run -d --name=ratdeos3 --net=container:ratdeos3-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos3:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos4 nodes plumbing
docker run -d --restart=always --name=ratdeos4-net --net=none busybox /bin/init
ratdeos4pid=$(docker inspect --format '{{.State.Pid}}' ratdeos4-net)
ln -sf /proc/${ratdeos4pid}/ns/net /var/run/netns/ratdeos4
# Connecting cEOS containers together
ip link set ratdeos4et1 netns ratdeos4 name et1 up
ip link set ratdeos4et2 netns ratdeos4 name et2 up
ip link set ratdeos4et3 netns ratdeos4 name et3 up
ip link set ratdeos4et4 netns ratdeos4 name et4 up
ip link set ratdeos4et5 netns ratdeos4 name et5 up
ip link set ratdeos4et6 netns ratdeos4 name et6 up
sleep 1
docker run -d --name=ratdeos4 --net=container:ratdeos4-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos4:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos5 nodes plumbing
docker run -d --restart=always --name=ratdeos5-net --net=none busybox /bin/init
ratdeos5pid=$(docker inspect --format '{{.State.Pid}}' ratdeos5-net)
ln -sf /proc/${ratdeos5pid}/ns/net /var/run/netns/ratdeos5
# Connecting cEOS containers together
ip link set ratdeos5et1 netns ratdeos5 name et1 up
ip link set ratdeos5et2 netns ratdeos5 name et2 up
ip link set ratdeos5et3 netns ratdeos5 name et3 up
ip link set ratdeos5et4 netns ratdeos5 name et4 up
ip link set ratdeos5et5 netns ratdeos5 name et5 up
sleep 1
docker run -d --name=ratdeos5 --net=container:ratdeos5-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos5:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos6 nodes plumbing
docker run -d --restart=always --name=ratdeos6-net --net=none busybox /bin/init
ratdeos6pid=$(docker inspect --format '{{.State.Pid}}' ratdeos6-net)
ln -sf /proc/${ratdeos6pid}/ns/net /var/run/netns/ratdeos6
# Connecting cEOS containers together
ip link set ratdeos6et1 netns ratdeos6 name et1 up
ip link set ratdeos6et2 netns ratdeos6 name et2 up
ip link set ratdeos6et3 netns ratdeos6 name et3 up
ip link set ratdeos6et4 netns ratdeos6 name et4 up
ip link set ratdeos6et5 netns ratdeos6 name et5 up
ip link set ratdeos6et6 netns ratdeos6 name et6 up
sleep 1
docker run -d --name=ratdeos6 --net=container:ratdeos6-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos6:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos7 nodes plumbing
docker run -d --restart=always --name=ratdeos7-net --net=none busybox /bin/init
ratdeos7pid=$(docker inspect --format '{{.State.Pid}}' ratdeos7-net)
ln -sf /proc/${ratdeos7pid}/ns/net /var/run/netns/ratdeos7
# Connecting cEOS containers together
ip link set ratdeos7et1 netns ratdeos7 name et1 up
ip link set ratdeos7et2 netns ratdeos7 name et2 up
ip link set ratdeos7et3 netns ratdeos7 name et3 up
ip link set ratdeos7et4 netns ratdeos7 name et4 up
sleep 1
docker run -d --name=ratdeos7 --net=container:ratdeos7-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos7:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos8 nodes plumbing
docker run -d --restart=always --name=ratdeos8-net --net=none busybox /bin/init
ratdeos8pid=$(docker inspect --format '{{.State.Pid}}' ratdeos8-net)
ln -sf /proc/${ratdeos8pid}/ns/net /var/run/netns/ratdeos8
# Connecting cEOS containers together
ip link set ratdeos8et1 netns ratdeos8 name et1 up
ip link set ratdeos8et2 netns ratdeos8 name et2 up
ip link set ratdeos8et3 netns ratdeos8 name et3 up
ip link set ratdeos8et4 netns ratdeos8 name et4 up
ip link set ratdeos8et5 netns ratdeos8 name et5 up
sleep 1
docker run -d --name=ratdeos8 --net=container:ratdeos8-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos8:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos9 nodes plumbing
docker run -d --restart=always --name=ratdeos9-net --net=none busybox /bin/init
ratdeos9pid=$(docker inspect --format '{{.State.Pid}}' ratdeos9-net)
ln -sf /proc/${ratdeos9pid}/ns/net /var/run/netns/ratdeos9
# Connecting cEOS containers together
ip link set ratdeos9et1 netns ratdeos9 name et1 up
ip link set ratdeos9et2 netns ratdeos9 name et2 up
sleep 1
docker run -d --name=ratdeos9 --net=container:ratdeos9-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos9:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos10 nodes plumbing
docker run -d --restart=always --name=ratdeos10-net --net=none busybox /bin/init
ratdeos10pid=$(docker inspect --format '{{.State.Pid}}' ratdeos10-net)
ln -sf /proc/${ratdeos10pid}/ns/net /var/run/netns/ratdeos10
# Connecting cEOS containers together
ip link set ratdeos10et1 netns ratdeos10 name et1 up
sleep 1
docker run -d --name=ratdeos10 --net=container:ratdeos10-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos10:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos11 nodes plumbing
docker run -d --restart=always --name=ratdeos11-net --net=none busybox /bin/init
ratdeos11pid=$(docker inspect --format '{{.State.Pid}}' ratdeos11-net)
ln -sf /proc/${ratdeos11pid}/ns/net /var/run/netns/ratdeos11
# Connecting cEOS containers together
ip link set ratdeos11et1 netns ratdeos11 name et1 up
ip link set ratdeos11et2 netns ratdeos11 name et2 up
ip link set ratdeos11et3 netns ratdeos11 name et3 up
sleep 1
docker run -d --name=ratdeos11 --net=container:ratdeos11-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos11:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos12 nodes plumbing
docker run -d --restart=always --name=ratdeos12-net --net=none busybox /bin/init
ratdeos12pid=$(docker inspect --format '{{.State.Pid}}' ratdeos12-net)
ln -sf /proc/${ratdeos12pid}/ns/net /var/run/netns/ratdeos12
# Connecting cEOS containers together
ip link set ratdeos12et1 netns ratdeos12 name et1 up
ip link set ratdeos12et2 netns ratdeos12 name et2 up
sleep 1
docker run -d --name=ratdeos12 --net=container:ratdeos12-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos12:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos13 nodes plumbing
docker run -d --restart=always --name=ratdeos13-net --net=none busybox /bin/init
ratdeos13pid=$(docker inspect --format '{{.State.Pid}}' ratdeos13-net)
ln -sf /proc/${ratdeos13pid}/ns/net /var/run/netns/ratdeos13
# Connecting cEOS containers together
ip link set ratdeos13et1 netns ratdeos13 name et1 up
ip link set ratdeos13et2 netns ratdeos13 name et2 up
ip link set ratdeos13et3 netns ratdeos13 name et3 up
sleep 1
docker run -d --name=ratdeos13 --net=container:ratdeos13-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos13:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos14 nodes plumbing
docker run -d --restart=always --name=ratdeos14-net --net=none busybox /bin/init
ratdeos14pid=$(docker inspect --format '{{.State.Pid}}' ratdeos14-net)
ln -sf /proc/${ratdeos14pid}/ns/net /var/run/netns/ratdeos14
# Connecting cEOS containers together
ip link set ratdeos14et1 netns ratdeos14 name et1 up
ip link set ratdeos14et2 netns ratdeos14 name et2 up
sleep 1
docker run -d --name=ratdeos14 --net=container:ratdeos14-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos14:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos15 nodes plumbing
docker run -d --restart=always --name=ratdeos15-net --net=none busybox /bin/init
ratdeos15pid=$(docker inspect --format '{{.State.Pid}}' ratdeos15-net)
ln -sf /proc/${ratdeos15pid}/ns/net /var/run/netns/ratdeos15
# Connecting cEOS containers together
ip link set ratdeos15et1 netns ratdeos15 name et1 up
sleep 1
docker run -d --name=ratdeos15 --net=container:ratdeos15-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos15:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos16 nodes plumbing
docker run -d --restart=always --name=ratdeos16-net --net=none busybox /bin/init
ratdeos16pid=$(docker inspect --format '{{.State.Pid}}' ratdeos16-net)
ln -sf /proc/${ratdeos16pid}/ns/net /var/run/netns/ratdeos16
# Connecting cEOS containers together
ip link set ratdeos16et1 netns ratdeos16 name et1 up
sleep 1
docker run -d --name=ratdeos16 --net=container:ratdeos16-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos16:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos17 nodes plumbing
docker run -d --restart=always --name=ratdeos17-net --net=none busybox /bin/init
ratdeos17pid=$(docker inspect --format '{{.State.Pid}}' ratdeos17-net)
ln -sf /proc/${ratdeos17pid}/ns/net /var/run/netns/ratdeos17
# Connecting cEOS containers together
ip link set ratdeos17et1 netns ratdeos17 name et1 up
sleep 1
docker run -d --name=ratdeos17 --net=container:ratdeos17-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos17:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos18 nodes plumbing
docker run -d --restart=always --name=ratdeos18-net --net=none busybox /bin/init
ratdeos18pid=$(docker inspect --format '{{.State.Pid}}' ratdeos18-net)
ln -sf /proc/${ratdeos18pid}/ns/net /var/run/netns/ratdeos18
# Connecting cEOS containers together
ip link set ratdeos18et1 netns ratdeos18 name et1 up
sleep 1
docker run -d --name=ratdeos18 --net=container:ratdeos18-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos18:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos19 nodes plumbing
docker run -d --restart=always --name=ratdeos19-net --net=none busybox /bin/init
ratdeos19pid=$(docker inspect --format '{{.State.Pid}}' ratdeos19-net)
ln -sf /proc/${ratdeos19pid}/ns/net /var/run/netns/ratdeos19
# Connecting cEOS containers together
ip link set ratdeos19et1 netns ratdeos19 name et1 up
sleep 1
docker run -d --name=ratdeos19 --net=container:ratdeos19-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos19:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting eos20 nodes plumbing
docker run -d --restart=always --name=ratdeos20-net --net=none busybox /bin/init
ratdeos20pid=$(docker inspect --format '{{.State.Pid}}' ratdeos20-net)
ln -sf /proc/${ratdeos20pid}/ns/net /var/run/netns/ratdeos20
# Connecting cEOS containers together
ip link set ratdeos20et1 netns ratdeos20 name et1 up
sleep 1
docker run -d --name=ratdeos20 --net=container:ratdeos20-net --privileged -v /workspaces/rLab-eos/configs/RATD/eos20:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
