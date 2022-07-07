#!/bin/bash

sudo sh -c 'echo "fs.inotify.max_user_instances = 50000" > /etc/sysctl.d/99-zceos.conf'
sudo sysctl -w fs.inotify.max_user_instances=50000
if [ "$(docker image ls | grep ceosimage | grep -c 4.28.0F)" == 0 ]
then
    echo "Docker image not found for ceosimage:4.28.0F, please build it first."
    exit
fi
if [ "$(docker image ls | grep chost | grep -c 1.0)" == 0 ]
then
    echo "Docker image not found for chost:1.0, please build it first."
    exit
fi
sudo ip netns add L2
# Creating veths
sudo ip link add 32ceet1 type veth peer name 429det1
sudo ip link add 32ceet2 type veth peer name 6f70et1
sudo ip link add 32ceet3 type veth peer name c06fet1
sudo ip link add 32ceet4 type veth peer name fbb5et1
sudo ip link add 429det2 type veth peer name 6f70et2
sudo ip link add 429det3 type veth peer name c06fet2
sudo ip link add 429det4 type veth peer name fbb5et2
sudo ip link add 6f70et3 type veth peer name 29a4et0
sudo ip link add 6f70et4 type veth peer name 98b4et0
sudo ip link add c06fet3 type veth peer name 0bccet0
sudo ip link add c06fet4 type veth peer name b143et0
sudo ip link add fbb5et3 type veth peer name 2092et0
sudo ip link add fbb5et4 type veth peer name 5aacet0
#
#
# Creating anchor containers
#
# Checking to make sure topo config directory exists
if ! [ -d "/workspaces/rLab-eos/configs/L2" ]; then mkdir /workspaces/rLab-eos/configs/L2; fi
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L2/spine1" ]; then mkdir /workspaces/rLab-eos/configs/L2/spine1; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l2spine1" > /workspaces/rLab-eos/configs/L2/spine1/ceos-config
# Getting spine1 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2spine1-net --net=none busybox /bin/init
l2spine1pid=$(docker inspect --format '{{.State.Pid}}' l2spine1-net)
sudo ln -sf /proc/${l2spine1pid}/ns/net /var/run/netns/l2spine1
# Connecting cEOS containers together
sudo ip link set 32ceet1 netns l2spine1 name et1 up
sudo ip link set 32ceet2 netns l2spine1 name et2 up
sudo ip link set 32ceet3 netns l2spine1 name et3 up
sudo ip link set 32ceet4 netns l2spine1 name et4 up
sudo ip link add l2spine1-eth0 type veth peer name l2spine1-mgmt
sudo ip link set l2spine1-eth0 netns l2spine1 name eth0 up
sudo ip netns exec l2spine1 ip link set dev eth0 down
sudo ip netns exec l2spine1 ip link set dev eth0 address 00:1c:73:b0:c6:01
sudo ip netns exec l2spine1 ip link set dev eth0 up
sudo ip link set l2spine1-mgmt up
sleep 1
sudo brctl addif vmgmt l2spine1-mgmt
docker run -d --name=l2spine1 --log-opt max-size=1m --net=container:l2spine1-net --ip 192.168.50.21 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L2/spine1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L2/spine2" ]; then mkdir /workspaces/rLab-eos/configs/L2/spine2; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l2spine2" > /workspaces/rLab-eos/configs/L2/spine2/ceos-config
# Getting spine2 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2spine2-net --net=none busybox /bin/init
l2spine2pid=$(docker inspect --format '{{.State.Pid}}' l2spine2-net)
sudo ln -sf /proc/${l2spine2pid}/ns/net /var/run/netns/l2spine2
# Connecting cEOS containers together
sudo ip link set 429det1 netns l2spine2 name et1 up
sudo ip link set 429det2 netns l2spine2 name et2 up
sudo ip link set 429det3 netns l2spine2 name et3 up
sudo ip link set 429det4 netns l2spine2 name et4 up
sudo ip link add l2spine2-eth0 type veth peer name l2spine2-mgmt
sudo ip link set l2spine2-eth0 netns l2spine2 name eth0 up
sudo ip netns exec l2spine2 ip link set dev eth0 down
sudo ip netns exec l2spine2 ip link set dev eth0 address 00:1c:73:b1:c6:01
sudo ip netns exec l2spine2 ip link set dev eth0 up
sudo ip link set l2spine2-mgmt up
sleep 1
sudo brctl addif vmgmt l2spine2-mgmt
docker run -d --name=l2spine2 --log-opt max-size=1m --net=container:l2spine2-net --ip 192.168.50.22 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L2/spine2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L2/leaf1" ]; then mkdir /workspaces/rLab-eos/configs/L2/leaf1; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l2leaf1" > /workspaces/rLab-eos/configs/L2/leaf1/ceos-config
# Getting leaf1 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2leaf1-net --net=none busybox /bin/init
l2leaf1pid=$(docker inspect --format '{{.State.Pid}}' l2leaf1-net)
sudo ln -sf /proc/${l2leaf1pid}/ns/net /var/run/netns/l2leaf1
# Connecting cEOS containers together
sudo ip link set 6f70et1 netns l2leaf1 name et1 up
sudo ip link set 6f70et2 netns l2leaf1 name et2 up
sudo ip link set 6f70et3 netns l2leaf1 name et3 up
sudo ip link set 6f70et4 netns l2leaf1 name et4 up
sudo ip link add l2leaf1-eth0 type veth peer name l2leaf1-mgmt
sudo ip link set l2leaf1-eth0 netns l2leaf1 name eth0 up
sudo ip netns exec l2leaf1 ip link set dev eth0 down
sudo ip netns exec l2leaf1 ip link set dev eth0 address 00:1c:73:b2:c6:01
sudo ip netns exec l2leaf1 ip link set dev eth0 up
sudo ip link set l2leaf1-mgmt up
sleep 1
sudo brctl addif vmgmt l2leaf1-mgmt
docker run -d --name=l2leaf1 --log-opt max-size=1m --net=container:l2leaf1-net --ip 192.168.50.23 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L2/leaf1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L2/leaf2" ]; then mkdir /workspaces/rLab-eos/configs/L2/leaf2; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l2leaf2" > /workspaces/rLab-eos/configs/L2/leaf2/ceos-config
# Getting leaf2 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2leaf2-net --net=none busybox /bin/init
l2leaf2pid=$(docker inspect --format '{{.State.Pid}}' l2leaf2-net)
sudo ln -sf /proc/${l2leaf2pid}/ns/net /var/run/netns/l2leaf2
# Connecting cEOS containers together
sudo ip link set c06fet1 netns l2leaf2 name et1 up
sudo ip link set c06fet2 netns l2leaf2 name et2 up
sudo ip link set c06fet3 netns l2leaf2 name et3 up
sudo ip link set c06fet4 netns l2leaf2 name et4 up
sudo ip link add l2leaf2-eth0 type veth peer name l2leaf2-mgmt
sudo ip link set l2leaf2-eth0 netns l2leaf2 name eth0 up
sudo ip netns exec l2leaf2 ip link set dev eth0 down
sudo ip netns exec l2leaf2 ip link set dev eth0 address 00:1c:73:b3:c6:01
sudo ip netns exec l2leaf2 ip link set dev eth0 up
sudo ip link set l2leaf2-mgmt up
sleep 1
sudo brctl addif vmgmt l2leaf2-mgmt
docker run -d --name=l2leaf2 --log-opt max-size=1m --net=container:l2leaf2-net --ip 192.168.50.24 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L2/leaf2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L2/leaf3" ]; then mkdir /workspaces/rLab-eos/configs/L2/leaf3; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l2leaf3" > /workspaces/rLab-eos/configs/L2/leaf3/ceos-config
# Getting leaf3 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2leaf3-net --net=none busybox /bin/init
l2leaf3pid=$(docker inspect --format '{{.State.Pid}}' l2leaf3-net)
sudo ln -sf /proc/${l2leaf3pid}/ns/net /var/run/netns/l2leaf3
# Connecting cEOS containers together
sudo ip link set fbb5et1 netns l2leaf3 name et1 up
sudo ip link set fbb5et2 netns l2leaf3 name et2 up
sudo ip link set fbb5et3 netns l2leaf3 name et3 up
sudo ip link set fbb5et4 netns l2leaf3 name et4 up
sudo ip link add l2leaf3-eth0 type veth peer name l2leaf3-mgmt
sudo ip link set l2leaf3-eth0 netns l2leaf3 name eth0 up
sudo ip netns exec l2leaf3 ip link set dev eth0 down
sudo ip netns exec l2leaf3 ip link set dev eth0 address 00:1c:73:b4:c6:01
sudo ip netns exec l2leaf3 ip link set dev eth0 up
sudo ip link set l2leaf3-mgmt up
sleep 1
sudo brctl addif vmgmt l2leaf3-mgmt
docker run -d --name=l2leaf3 --log-opt max-size=1m --net=container:l2leaf3-net --ip 192.168.50.25 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L2/leaf3:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting host10 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host10-net --net=none busybox /bin/init
l2host10pid=$(docker inspect --format '{{.State.Pid}}' l2host10-net)
sudo ln -sf /proc/${l2host10pid}/ns/net /var/run/netns/l2host10
# Connecting host containers together
sudo ip link set 29a4et0 netns l2host10 name et0 up
sleep 1
docker run -d --name=l2host10 --privileged --log-opt max-size=1m --net=container:l2host10-net -e HOSTNAME=l2host10 -e HOST_IP=10.0.12.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.12.1 chost:1.0 ipnet
# Getting host11 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host11-net --net=none busybox /bin/init
l2host11pid=$(docker inspect --format '{{.State.Pid}}' l2host11-net)
sudo ln -sf /proc/${l2host11pid}/ns/net /var/run/netns/l2host11
# Connecting host containers together
sudo ip link set 98b4et0 netns l2host11 name et0 up
sleep 1
docker run -d --name=l2host11 --privileged --log-opt max-size=1m --net=container:l2host11-net -e HOSTNAME=l2host11 -e HOST_IP=10.0.13.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.13.1 chost:1.0 ipnet
# Getting host20 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host20-net --net=none busybox /bin/init
l2host20pid=$(docker inspect --format '{{.State.Pid}}' l2host20-net)
sudo ln -sf /proc/${l2host20pid}/ns/net /var/run/netns/l2host20
# Connecting host containers together
sudo ip link set 0bccet0 netns l2host20 name et0 up
sleep 1
docker run -d --name=l2host20 --privileged --log-opt max-size=1m --net=container:l2host20-net -e HOSTNAME=l2host20 -e HOST_IP=10.0.12.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.12.1 chost:1.0 ipnet
# Getting host21 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host21-net --net=none busybox /bin/init
l2host21pid=$(docker inspect --format '{{.State.Pid}}' l2host21-net)
sudo ln -sf /proc/${l2host21pid}/ns/net /var/run/netns/l2host21
# Connecting host containers together
sudo ip link set b143et0 netns l2host21 name et0 up
sleep 1
docker run -d --name=l2host21 --privileged --log-opt max-size=1m --net=container:l2host21-net -e HOSTNAME=l2host21 -e HOST_IP=10.0.13.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.13.1 chost:1.0 ipnet
# Getting host30 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host30-net --net=none busybox /bin/init
l2host30pid=$(docker inspect --format '{{.State.Pid}}' l2host30-net)
sudo ln -sf /proc/${l2host30pid}/ns/net /var/run/netns/l2host30
# Connecting host containers together
sudo ip link set 2092et0 netns l2host30 name et0 up
sleep 1
docker run -d --name=l2host30 --privileged --log-opt max-size=1m --net=container:l2host30-net -e HOSTNAME=l2host30 -e HOST_IP=10.0.12.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.12.1 chost:1.0 ipnet
# Getting host31 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l2host31-net --net=none busybox /bin/init
l2host31pid=$(docker inspect --format '{{.State.Pid}}' l2host31-net)
sudo ln -sf /proc/${l2host31pid}/ns/net /var/run/netns/l2host31
# Connecting host containers together
sudo ip link set 5aacet0 netns l2host31 name et0 up
sleep 1
docker run -d --name=l2host31 --privileged --log-opt max-size=1m --net=container:l2host31-net -e HOSTNAME=l2host31 -e HOST_IP=10.0.13.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=10.0.13.1 chost:1.0 ipnet
docker exec -d l2host10 iperf3 -s -p 5010
docker exec -d l2host30 iperf3 -s -p 5010
docker exec -d l2host31 iperf3 -s -p 5010
docker exec -d l2host11 iperf3client 10.0.12.31 5010 1000000
docker exec -d l2host20 iperf3client 10.0.12.11 5010 1000000
docker exec -d l2host21 iperf3client 10.0.13.31 5010 1000000
