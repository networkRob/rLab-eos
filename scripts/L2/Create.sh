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
sudo ip netns add L2
# Creating veths
sudo ip link add l2spine1et1 type veth peer name l2spine2et1
sudo ip link add l2spine1et2 type veth peer name l2leaf1et1
sudo ip link add l2spine1et3 type veth peer name l2leaf2et1
sudo ip link add l2spine1et4 type veth peer name l2leaf3et1
sudo ip link add l2spine2et2 type veth peer name l2leaf1et2
sudo ip link add l2spine2et3 type veth peer name l2leaf2et2
sudo ip link add l2spine2et4 type veth peer name l2leaf3et2
sudo ip link add l2leaf1et3 type veth peer name l2host10et0
sudo ip link add l2leaf1et4 type veth peer name l2host11et0
sudo ip link add l2leaf2et3 type veth peer name l2host20et0
sudo ip link add l2leaf2et4 type veth peer name l2host21et0
sudo ip link add l2leaf3et3 type veth peer name l2host30et0
sudo ip link add l2leaf3et4 type veth peer name l2host31et0
#
#
# Creating anchor containers
#
# Getting spine1 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2spine1-net --net=none busybox /bin/init
l2spine1pid=$(docker inspect --format '{{.State.Pid}}' l2spine1-net)
sudo ln -sf /proc/${l2spine1pid}/ns/net /var/run/netns/l2spine1
# Connecting cEOS containers together
sudo ip link set l2spine1et1 netns l2spine1 name et1 up
sudo ip link set l2spine1et2 netns l2spine1 name et2 up
sudo ip link set l2spine1et3 netns l2spine1 name et3 up
sudo ip link set l2spine1et4 netns l2spine1 name et4 up
sudo ip link add l2spine1-eth0 type veth peer name l2spine1-mgmt
sudo brctl addif vmgmt l2spine1-mgmt
sudo ip link set l2spine1-eth0 netns l2spine1 name eth0 up
sudo ip link set l2spine1-mgmt up
sleep 1
docker run -d --name=l2spine1 --log-opt max-size=1m --net=container:l2spine1-net --ip 192.168.50.21 --privileged -v /workspaces/rLab-eos/configs/L2/spine1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting spine2 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2spine2-net --net=none busybox /bin/init
l2spine2pid=$(docker inspect --format '{{.State.Pid}}' l2spine2-net)
sudo ln -sf /proc/${l2spine2pid}/ns/net /var/run/netns/l2spine2
# Connecting cEOS containers together
sudo ip link set l2spine2et1 netns l2spine2 name et1 up
sudo ip link set l2spine2et2 netns l2spine2 name et2 up
sudo ip link set l2spine2et3 netns l2spine2 name et3 up
sudo ip link set l2spine2et4 netns l2spine2 name et4 up
sudo ip link add l2spine2-eth0 type veth peer name l2spine2-mgmt
sudo brctl addif vmgmt l2spine2-mgmt
sudo ip link set l2spine2-eth0 netns l2spine2 name eth0 up
sudo ip link set l2spine2-mgmt up
sleep 1
docker run -d --name=l2spine2 --log-opt max-size=1m --net=container:l2spine2-net --ip 192.168.50.22 --privileged -v /workspaces/rLab-eos/configs/L2/spine2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting leaf1 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2leaf1-net --net=none busybox /bin/init
l2leaf1pid=$(docker inspect --format '{{.State.Pid}}' l2leaf1-net)
sudo ln -sf /proc/${l2leaf1pid}/ns/net /var/run/netns/l2leaf1
# Connecting cEOS containers together
sudo ip link set l2leaf1et1 netns l2leaf1 name et1 up
sudo ip link set l2leaf1et2 netns l2leaf1 name et2 up
sudo ip link set l2leaf1et3 netns l2leaf1 name et3 up
sudo ip link set l2leaf1et4 netns l2leaf1 name et4 up
sudo ip link add l2leaf1-eth0 type veth peer name l2leaf1-mgmt
sudo brctl addif vmgmt l2leaf1-mgmt
sudo ip link set l2leaf1-eth0 netns l2leaf1 name eth0 up
sudo ip link set l2leaf1-mgmt up
sleep 1
docker run -d --name=l2leaf1 --log-opt max-size=1m --net=container:l2leaf1-net --ip 192.168.50.23 --privileged -v /workspaces/rLab-eos/configs/L2/leaf1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting leaf2 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2leaf2-net --net=none busybox /bin/init
l2leaf2pid=$(docker inspect --format '{{.State.Pid}}' l2leaf2-net)
sudo ln -sf /proc/${l2leaf2pid}/ns/net /var/run/netns/l2leaf2
# Connecting cEOS containers together
sudo ip link set l2leaf2et1 netns l2leaf2 name et1 up
sudo ip link set l2leaf2et2 netns l2leaf2 name et2 up
sudo ip link set l2leaf2et3 netns l2leaf2 name et3 up
sudo ip link set l2leaf2et4 netns l2leaf2 name et4 up
sudo ip link add l2leaf2-eth0 type veth peer name l2leaf2-mgmt
sudo brctl addif vmgmt l2leaf2-mgmt
sudo ip link set l2leaf2-eth0 netns l2leaf2 name eth0 up
sudo ip link set l2leaf2-mgmt up
sleep 1
docker run -d --name=l2leaf2 --log-opt max-size=1m --net=container:l2leaf2-net --ip 192.168.50.24 --privileged -v /workspaces/rLab-eos/configs/L2/leaf2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting leaf3 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2leaf3-net --net=none busybox /bin/init
l2leaf3pid=$(docker inspect --format '{{.State.Pid}}' l2leaf3-net)
sudo ln -sf /proc/${l2leaf3pid}/ns/net /var/run/netns/l2leaf3
# Connecting cEOS containers together
sudo ip link set l2leaf3et1 netns l2leaf3 name et1 up
sudo ip link set l2leaf3et2 netns l2leaf3 name et2 up
sudo ip link set l2leaf3et3 netns l2leaf3 name et3 up
sudo ip link set l2leaf3et4 netns l2leaf3 name et4 up
sudo ip link add l2leaf3-eth0 type veth peer name l2leaf3-mgmt
sudo brctl addif vmgmt l2leaf3-mgmt
sudo ip link set l2leaf3-eth0 netns l2leaf3 name eth0 up
sudo ip link set l2leaf3-mgmt up
sleep 1
docker run -d --name=l2leaf3 --log-opt max-size=1m --net=container:l2leaf3-net --ip 192.168.50.25 --privileged -v /workspaces/rLab-eos/configs/L2/leaf3:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting host10 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host10-net --net=none busybox /bin/init
l2host10pid=$(docker inspect --format '{{.State.Pid}}' l2host10-net)
sudo ln -sf /proc/${l2host10pid}/ns/net /var/run/netns/l2host10
# Connecting host containers together
sudo ip link set l2host10et0 netns l2host10 name et0 up
sleep 1
docker run -d --name=l2host10 --privileged --log-opt max-size=1m --net=container:l2host10-net -e HOSTNAME=l2host10 -e HOST_IP=10.0.12.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.12.1 chost:0.5 ipnet
# Getting host11 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host11-net --net=none busybox /bin/init
l2host11pid=$(docker inspect --format '{{.State.Pid}}' l2host11-net)
sudo ln -sf /proc/${l2host11pid}/ns/net /var/run/netns/l2host11
# Connecting host containers together
sudo ip link set l2host11et0 netns l2host11 name et0 up
sleep 1
docker run -d --name=l2host11 --privileged --log-opt max-size=1m --net=container:l2host11-net -e HOSTNAME=l2host11 -e HOST_IP=10.0.13.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.13.1 chost:0.5 ipnet
# Getting host20 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host20-net --net=none busybox /bin/init
l2host20pid=$(docker inspect --format '{{.State.Pid}}' l2host20-net)
sudo ln -sf /proc/${l2host20pid}/ns/net /var/run/netns/l2host20
# Connecting host containers together
sudo ip link set l2host20et0 netns l2host20 name et0 up
sleep 1
docker run -d --name=l2host20 --privileged --log-opt max-size=1m --net=container:l2host20-net -e HOSTNAME=l2host20 -e HOST_IP=10.0.12.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.12.1 chost:0.5 ipnet
# Getting host21 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host21-net --net=none busybox /bin/init
l2host21pid=$(docker inspect --format '{{.State.Pid}}' l2host21-net)
sudo ln -sf /proc/${l2host21pid}/ns/net /var/run/netns/l2host21
# Connecting host containers together
sudo ip link set l2host21et0 netns l2host21 name et0 up
sleep 1
docker run -d --name=l2host21 --privileged --log-opt max-size=1m --net=container:l2host21-net -e HOSTNAME=l2host21 -e HOST_IP=10.0.13.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.13.1 chost:0.5 ipnet
# Getting host30 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host30-net --net=none busybox /bin/init
l2host30pid=$(docker inspect --format '{{.State.Pid}}' l2host30-net)
sudo ln -sf /proc/${l2host30pid}/ns/net /var/run/netns/l2host30
# Connecting host containers together
sudo ip link set l2host30et0 netns l2host30 name et0 up
sleep 1
docker run -d --name=l2host30 --privileged --log-opt max-size=1m --net=container:l2host30-net -e HOSTNAME=l2host30 -e HOST_IP=10.0.12.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.12.1 chost:0.5 ipnet
# Getting host31 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host31-net --net=none busybox /bin/init
l2host31pid=$(docker inspect --format '{{.State.Pid}}' l2host31-net)
sudo ln -sf /proc/${l2host31pid}/ns/net /var/run/netns/l2host31
# Connecting host containers together
sudo ip link set l2host31et0 netns l2host31 name et0 up
sleep 1
docker run -d --name=l2host31 --privileged --log-opt max-size=1m --net=container:l2host31-net -e HOSTNAME=l2host31 -e HOST_IP=10.0.13.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.13.1 chost:0.5 ipnet
docker exec -d l2host10 iperf3 -s -p 5010
docker exec -d l2host30 iperf3 -s -p 5010
docker exec -d l2host31 iperf3 -s -p 5010
docker exec -d l2host11 iperf3client 10.0.12.31 5010 1000000
docker exec -d l2host20 iperf3client 10.0.12.11 5010 1000000
docker exec -d l2host21 iperf3client 10.0.13.31 5010 1000000
