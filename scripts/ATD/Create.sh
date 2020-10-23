#!/bin/bash
ip netns add ATD
# Creating veths
ip link add atdspine1et1 type veth peer name atdspine2et1
ip link add atdspine1et2 type veth peer name atdleaf1et2
ip link add atdspine1et3 type veth peer name atdleaf2et2
ip link add atdspine1et4 type veth peer name atdleaf3et2
ip link add atdspine1et5 type veth peer name atdleaf4et2
ip link add atdspine1et6 type veth peer name atdspine2et6
ip link add atdspine2et2 type veth peer name atdleaf1et3
ip link add atdspine2et3 type veth peer name atdleaf2et3
ip link add atdspine2et4 type veth peer name atdleaf3et3
ip link add atdspine2et5 type veth peer name atdleaf4et3
ip link add atdleaf1et1 type veth peer name atdleaf2et1
ip link add atdleaf1et4 type veth peer name atdhost1et1
ip link add atdleaf1et5 type veth peer name atdhost1et3
ip link add atdleaf1et6 type veth peer name atdleaf2et6
ip link add atdleaf2et4 type veth peer name atdhost1et2
ip link add atdleaf2et5 type veth peer name atdhost1et4
ip link add atdleaf3et1 type veth peer name atdleaf4et1
ip link add atdleaf3et4 type veth peer name atdhost2et1
ip link add atdleaf3et5 type veth peer name atdhost2et3
ip link add atdleaf3et6 type veth peer name atdleaf4et6
ip link add atdleaf4et4 type veth peer name atdhost2et2
ip link add atdleaf4et5 type veth peer name atdhost2et4
#
#
# Creating anchor containers
#
# Getting spine1 nodes plubming
docker run -d --restart=always --name=atdspine1-net --net=none busybox /bin/init
atdspine1pid=$(docker inspect --format '{{.State.Pid}}' atdspine1-net)
ln -sf /proc/${atdspine1pid}/ns/net /var/run/netns/atdspine1
# Connecting cEOS containers together
ip link set atdspine1et1 netns spine1 name et1 up
ip link set atdspine1et2 netns spine1 name et2 up
ip link set atdspine1et3 netns spine1 name et3 up
ip link set atdspine1et4 netns spine1 name et4 up
ip link set atdspine1et5 netns spine1 name et5 up
ip link set atdspine1et6 netns spine1 name et6 up
sleep 1
docker run -d --name=atdspine1 --net=container:atdspine1-net --privileged -v /workspaces/rLab-eos/configs/ATD/spine1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting spine2 nodes plubming
docker run -d --restart=always --name=atdspine2-net --net=none busybox /bin/init
atdspine2pid=$(docker inspect --format '{{.State.Pid}}' atdspine2-net)
ln -sf /proc/${atdspine2pid}/ns/net /var/run/netns/atdspine2
# Connecting cEOS containers together
ip link set atdspine2et1 netns spine2 name et1 up
ip link set atdspine2et2 netns spine2 name et2 up
ip link set atdspine2et3 netns spine2 name et3 up
ip link set atdspine2et4 netns spine2 name et4 up
ip link set atdspine2et5 netns spine2 name et5 up
ip link set atdspine2et6 netns spine2 name et6 up
sleep 1
docker run -d --name=atdspine2 --net=container:atdspine2-net --privileged -v /workspaces/rLab-eos/configs/ATD/spine2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting leaf1 nodes plubming
docker run -d --restart=always --name=atdleaf1-net --net=none busybox /bin/init
atdleaf1pid=$(docker inspect --format '{{.State.Pid}}' atdleaf1-net)
ln -sf /proc/${atdleaf1pid}/ns/net /var/run/netns/atdleaf1
# Connecting cEOS containers together
ip link set atdleaf1et1 netns leaf1 name et1 up
ip link set atdleaf1et2 netns leaf1 name et2 up
ip link set atdleaf1et3 netns leaf1 name et3 up
ip link set atdleaf1et4 netns leaf1 name et4 up
ip link set atdleaf1et5 netns leaf1 name et5 up
ip link set atdleaf1et6 netns leaf1 name et6 up
sleep 1
docker run -d --name=atdleaf1 --net=container:atdleaf1-net --privileged -v /workspaces/rLab-eos/configs/ATD/leaf1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting leaf2 nodes plubming
docker run -d --restart=always --name=atdleaf2-net --net=none busybox /bin/init
atdleaf2pid=$(docker inspect --format '{{.State.Pid}}' atdleaf2-net)
ln -sf /proc/${atdleaf2pid}/ns/net /var/run/netns/atdleaf2
# Connecting cEOS containers together
ip link set atdleaf2et1 netns leaf2 name et1 up
ip link set atdleaf2et2 netns leaf2 name et2 up
ip link set atdleaf2et3 netns leaf2 name et3 up
ip link set atdleaf2et4 netns leaf2 name et4 up
ip link set atdleaf2et5 netns leaf2 name et5 up
ip link set atdleaf2et6 netns leaf2 name et6 up
sleep 1
docker run -d --name=atdleaf2 --net=container:atdleaf2-net --privileged -v /workspaces/rLab-eos/configs/ATD/leaf2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting leaf3 nodes plubming
docker run -d --restart=always --name=atdleaf3-net --net=none busybox /bin/init
atdleaf3pid=$(docker inspect --format '{{.State.Pid}}' atdleaf3-net)
ln -sf /proc/${atdleaf3pid}/ns/net /var/run/netns/atdleaf3
# Connecting cEOS containers together
ip link set atdleaf3et1 netns leaf3 name et1 up
ip link set atdleaf3et2 netns leaf3 name et2 up
ip link set atdleaf3et3 netns leaf3 name et3 up
ip link set atdleaf3et4 netns leaf3 name et4 up
ip link set atdleaf3et5 netns leaf3 name et5 up
ip link set atdleaf3et6 netns leaf3 name et6 up
sleep 1
docker run -d --name=atdleaf3 --net=container:atdleaf3-net --privileged -v /workspaces/rLab-eos/configs/ATD/leaf3:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting leaf4 nodes plubming
docker run -d --restart=always --name=atdleaf4-net --net=none busybox /bin/init
atdleaf4pid=$(docker inspect --format '{{.State.Pid}}' atdleaf4-net)
ln -sf /proc/${atdleaf4pid}/ns/net /var/run/netns/atdleaf4
# Connecting cEOS containers together
ip link set atdleaf4et1 netns leaf4 name et1 up
ip link set atdleaf4et2 netns leaf4 name et2 up
ip link set atdleaf4et3 netns leaf4 name et3 up
ip link set atdleaf4et4 netns leaf4 name et4 up
ip link set atdleaf4et5 netns leaf4 name et5 up
ip link set atdleaf4et6 netns leaf4 name et6 up
sleep 1
docker run -d --name=atdleaf4 --net=container:atdleaf4-net --privileged -v /workspaces/rLab-eos/configs/ATD/leaf4:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting host1 nodes plubming
docker run -d --restart=always --name=atdhost1-net --net=none busybox /bin/init
atdhost1pid=$(docker inspect --format '{{.State.Pid}}' atdhost1-net)
ln -sf /proc/${atdhost1pid}/ns/net /var/run/netns/atdhost1
# Connecting cEOS containers together
ip link set atdhost1et1 netns host1 name et1 up
ip link set atdhost1et2 netns host1 name et2 up
ip link set atdhost1et3 netns host1 name et3 up
ip link set atdhost1et4 netns host1 name et4 up
sleep 1
docker run -d --name=atdhost1 --net=container:atdhost1-net --privileged -v /workspaces/rLab-eos/configs/ATD/host1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting host2 nodes plubming
docker run -d --restart=always --name=atdhost2-net --net=none busybox /bin/init
atdhost2pid=$(docker inspect --format '{{.State.Pid}}' atdhost2-net)
ln -sf /proc/${atdhost2pid}/ns/net /var/run/netns/atdhost2
# Connecting cEOS containers together
ip link set atdhost2et1 netns host2 name et1 up
ip link set atdhost2et2 netns host2 name et2 up
ip link set atdhost2et3 netns host2 name et3 up
ip link set atdhost2et4 netns host2 name et4 up
sleep 1
docker run -d --name=atdhost2 --net=container:atdhost2-net --privileged -v /workspaces/rLab-eos/configs/ATD/host2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.23.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
