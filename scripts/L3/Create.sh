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
sudo ip netns add L3
# Creating veths
sudo ip link add 52bcet1 type veth peer name 69f0et2
sudo ip link add 52bcet2 type veth peer name b332et2
sudo ip link add 52bcet3 type veth peer name 3979et2
sudo ip link add 52bcet4 type veth peer name a9daet2
sudo ip link add 52bcet5 type veth peer name f3adet2
sudo ip link add 52bcet6 type veth peer name 3b37et2
sudo ip link add 52bcet7 type veth peer name 9eaaet2
sudo ip link add 52bcet8 type veth peer name 69b5et2
sudo ip link add 80ceet1 type veth peer name 69f0et3
sudo ip link add 80ceet2 type veth peer name b332et3
sudo ip link add 80ceet3 type veth peer name 3979et3
sudo ip link add 80ceet4 type veth peer name a9daet3
sudo ip link add 80ceet5 type veth peer name f3adet3
sudo ip link add 80ceet6 type veth peer name 3b37et3
sudo ip link add 80ceet7 type veth peer name 9eaaet3
sudo ip link add 80ceet8 type veth peer name 69b5et3
sudo ip link add 69f0et1 type veth peer name b332et1
sudo ip link add 69f0et4 type veth peer name 8d5aet0
sudo ip link add 69f0et5 type veth peer name 679det0
sudo ip link add 3979et1 type veth peer name a9daet1
sudo ip link add 3979et4 type veth peer name 8872et0
sudo ip link add a9daet4 type veth peer name 0259et0
sudo ip link add f3adet1 type veth peer name 3b37et1
sudo ip link add f3adet4 type veth peer name 0c74et0
sudo ip link add f3adet5 type veth peer name 361aet0
sudo ip link add 9eaaet1 type veth peer name 69b5et1
#
#
# Creating anchor containers
#
# Checking to make sure topo config directory exists
if ! [ -d "/workspaces/rLab-eos/configs/L3" ]; then mkdir /workspaces/rLab-eos/configs/L3; fi
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/spine1" ]; then mkdir /workspaces/rLab-eos/configs/L3/spine1; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3spine1" > /workspaces/rLab-eos/configs/L3/spine1/ceos-config
# Getting spine1 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3spine1-net --net=none busybox /bin/init
l3spine1pid=$(docker inspect --format '{{.State.Pid}}' l3spine1-net)
sudo ln -sf /proc/${l3spine1pid}/ns/net /var/run/netns/l3spine1
# Connecting cEOS containers together
sudo ip link set 52bcet1 netns l3spine1 name et1 up
sudo ip link set 52bcet2 netns l3spine1 name et2 up
sudo ip link set 52bcet3 netns l3spine1 name et3 up
sudo ip link set 52bcet4 netns l3spine1 name et4 up
sudo ip link set 52bcet5 netns l3spine1 name et5 up
sudo ip link set 52bcet6 netns l3spine1 name et6 up
sudo ip link set 52bcet7 netns l3spine1 name et7 up
sudo ip link set 52bcet8 netns l3spine1 name et8 up
sudo ip link add l3spine1-eth0 type veth peer name l3spine1-mgmt
sudo ip link set l3spine1-eth0 netns l3spine1 name eth0 up
sudo ip netns exec l3spine1 ip link set dev eth0 down
sudo ip netns exec l3spine1 ip link set dev eth0 address 00:1c:73:c0:c6:01
sudo ip netns exec l3spine1 ip link set dev eth0 up
sudo ip link set l3spine1-mgmt up
sleep 1
sudo brctl addif vmgmt l3spine1-mgmt
docker run -d --name=l3spine1 --log-opt max-size=1m --net=container:l3spine1-net --ip 192.168.50.31 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/spine1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/spine2" ]; then mkdir /workspaces/rLab-eos/configs/L3/spine2; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3spine2" > /workspaces/rLab-eos/configs/L3/spine2/ceos-config
# Getting spine2 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3spine2-net --net=none busybox /bin/init
l3spine2pid=$(docker inspect --format '{{.State.Pid}}' l3spine2-net)
sudo ln -sf /proc/${l3spine2pid}/ns/net /var/run/netns/l3spine2
# Connecting cEOS containers together
sudo ip link set 80ceet1 netns l3spine2 name et1 up
sudo ip link set 80ceet2 netns l3spine2 name et2 up
sudo ip link set 80ceet3 netns l3spine2 name et3 up
sudo ip link set 80ceet4 netns l3spine2 name et4 up
sudo ip link set 80ceet5 netns l3spine2 name et5 up
sudo ip link set 80ceet6 netns l3spine2 name et6 up
sudo ip link set 80ceet7 netns l3spine2 name et7 up
sudo ip link set 80ceet8 netns l3spine2 name et8 up
sudo ip link add l3spine2-eth0 type veth peer name l3spine2-mgmt
sudo ip link set l3spine2-eth0 netns l3spine2 name eth0 up
sudo ip netns exec l3spine2 ip link set dev eth0 down
sudo ip netns exec l3spine2 ip link set dev eth0 address 00:1c:73:c1:c6:01
sudo ip netns exec l3spine2 ip link set dev eth0 up
sudo ip link set l3spine2-mgmt up
sleep 1
sudo brctl addif vmgmt l3spine2-mgmt
docker run -d --name=l3spine2 --log-opt max-size=1m --net=container:l3spine2-net --ip 192.168.50.32 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/spine2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/leaf11" ]; then mkdir /workspaces/rLab-eos/configs/L3/leaf11; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3leaf11" > /workspaces/rLab-eos/configs/L3/leaf11/ceos-config
# Getting leaf11 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3leaf11-net --net=none busybox /bin/init
l3leaf11pid=$(docker inspect --format '{{.State.Pid}}' l3leaf11-net)
sudo ln -sf /proc/${l3leaf11pid}/ns/net /var/run/netns/l3leaf11
# Connecting cEOS containers together
sudo ip link set 69f0et2 netns l3leaf11 name et2 up
sudo ip link set 69f0et3 netns l3leaf11 name et3 up
sudo ip link set 69f0et1 netns l3leaf11 name et1 up
sudo ip link set 69f0et4 netns l3leaf11 name et4 up
sudo ip link set 69f0et5 netns l3leaf11 name et5 up
sudo ip link add l3leaf11-eth0 type veth peer name l3leaf11-mgmt
sudo ip link set l3leaf11-eth0 netns l3leaf11 name eth0 up
sudo ip netns exec l3leaf11 ip link set dev eth0 down
sudo ip netns exec l3leaf11 ip link set dev eth0 address 00:1c:73:c2:c6:01
sudo ip netns exec l3leaf11 ip link set dev eth0 up
sudo ip link set l3leaf11-mgmt up
sleep 1
sudo brctl addif vmgmt l3leaf11-mgmt
docker run -d --name=l3leaf11 --log-opt max-size=1m --net=container:l3leaf11-net --ip 192.168.50.33 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/leaf11:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/leaf12" ]; then mkdir /workspaces/rLab-eos/configs/L3/leaf12; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3leaf12" > /workspaces/rLab-eos/configs/L3/leaf12/ceos-config
# Getting leaf12 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3leaf12-net --net=none busybox /bin/init
l3leaf12pid=$(docker inspect --format '{{.State.Pid}}' l3leaf12-net)
sudo ln -sf /proc/${l3leaf12pid}/ns/net /var/run/netns/l3leaf12
# Connecting cEOS containers together
sudo ip link set b332et2 netns l3leaf12 name et2 up
sudo ip link set b332et3 netns l3leaf12 name et3 up
sudo ip link set b332et1 netns l3leaf12 name et1 up
sudo ip link add l3leaf12-eth0 type veth peer name l3leaf12-mgmt
sudo ip link set l3leaf12-eth0 netns l3leaf12 name eth0 up
sudo ip netns exec l3leaf12 ip link set dev eth0 down
sudo ip netns exec l3leaf12 ip link set dev eth0 address 00:1c:73:c3:c6:01
sudo ip netns exec l3leaf12 ip link set dev eth0 up
sudo ip link set l3leaf12-mgmt up
sleep 1
sudo brctl addif vmgmt l3leaf12-mgmt
docker run -d --name=l3leaf12 --log-opt max-size=1m --net=container:l3leaf12-net --ip 192.168.50.34 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/leaf12:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/leaf21" ]; then mkdir /workspaces/rLab-eos/configs/L3/leaf21; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3leaf21" > /workspaces/rLab-eos/configs/L3/leaf21/ceos-config
# Getting leaf21 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3leaf21-net --net=none busybox /bin/init
l3leaf21pid=$(docker inspect --format '{{.State.Pid}}' l3leaf21-net)
sudo ln -sf /proc/${l3leaf21pid}/ns/net /var/run/netns/l3leaf21
# Connecting cEOS containers together
sudo ip link set 3979et2 netns l3leaf21 name et2 up
sudo ip link set 3979et3 netns l3leaf21 name et3 up
sudo ip link set 3979et1 netns l3leaf21 name et1 up
sudo ip link set 3979et4 netns l3leaf21 name et4 up
sudo ip link add l3leaf21-eth0 type veth peer name l3leaf21-mgmt
sudo ip link set l3leaf21-eth0 netns l3leaf21 name eth0 up
sudo ip netns exec l3leaf21 ip link set dev eth0 down
sudo ip netns exec l3leaf21 ip link set dev eth0 address 00:1c:73:c4:c6:01
sudo ip netns exec l3leaf21 ip link set dev eth0 up
sudo ip link set l3leaf21-mgmt up
sleep 1
sudo brctl addif vmgmt l3leaf21-mgmt
docker run -d --name=l3leaf21 --log-opt max-size=1m --net=container:l3leaf21-net --ip 192.168.50.35 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/leaf21:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/leaf22" ]; then mkdir /workspaces/rLab-eos/configs/L3/leaf22; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3leaf22" > /workspaces/rLab-eos/configs/L3/leaf22/ceos-config
# Getting leaf22 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3leaf22-net --net=none busybox /bin/init
l3leaf22pid=$(docker inspect --format '{{.State.Pid}}' l3leaf22-net)
sudo ln -sf /proc/${l3leaf22pid}/ns/net /var/run/netns/l3leaf22
# Connecting cEOS containers together
sudo ip link set a9daet2 netns l3leaf22 name et2 up
sudo ip link set a9daet3 netns l3leaf22 name et3 up
sudo ip link set a9daet1 netns l3leaf22 name et1 up
sudo ip link set a9daet4 netns l3leaf22 name et4 up
sudo ip link add l3leaf22-eth0 type veth peer name l3leaf22-mgmt
sudo ip link set l3leaf22-eth0 netns l3leaf22 name eth0 up
sudo ip netns exec l3leaf22 ip link set dev eth0 down
sudo ip netns exec l3leaf22 ip link set dev eth0 address 00:1c:73:c5:c6:01
sudo ip netns exec l3leaf22 ip link set dev eth0 up
sudo ip link set l3leaf22-mgmt up
sleep 1
sudo brctl addif vmgmt l3leaf22-mgmt
docker run -d --name=l3leaf22 --log-opt max-size=1m --net=container:l3leaf22-net --ip 192.168.50.36 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/leaf22:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/leaf31" ]; then mkdir /workspaces/rLab-eos/configs/L3/leaf31; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3leaf31" > /workspaces/rLab-eos/configs/L3/leaf31/ceos-config
# Getting leaf31 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3leaf31-net --net=none busybox /bin/init
l3leaf31pid=$(docker inspect --format '{{.State.Pid}}' l3leaf31-net)
sudo ln -sf /proc/${l3leaf31pid}/ns/net /var/run/netns/l3leaf31
# Connecting cEOS containers together
sudo ip link set f3adet2 netns l3leaf31 name et2 up
sudo ip link set f3adet3 netns l3leaf31 name et3 up
sudo ip link set f3adet1 netns l3leaf31 name et1 up
sudo ip link set f3adet4 netns l3leaf31 name et4 up
sudo ip link set f3adet5 netns l3leaf31 name et5 up
sudo ip link add l3leaf31-eth0 type veth peer name l3leaf31-mgmt
sudo ip link set l3leaf31-eth0 netns l3leaf31 name eth0 up
sudo ip netns exec l3leaf31 ip link set dev eth0 down
sudo ip netns exec l3leaf31 ip link set dev eth0 address 00:1c:73:c6:c6:01
sudo ip netns exec l3leaf31 ip link set dev eth0 up
sudo ip link set l3leaf31-mgmt up
sleep 1
sudo brctl addif vmgmt l3leaf31-mgmt
docker run -d --name=l3leaf31 --log-opt max-size=1m --net=container:l3leaf31-net --ip 192.168.50.37 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/leaf31:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/leaf32" ]; then mkdir /workspaces/rLab-eos/configs/L3/leaf32; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3leaf32" > /workspaces/rLab-eos/configs/L3/leaf32/ceos-config
# Getting leaf32 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3leaf32-net --net=none busybox /bin/init
l3leaf32pid=$(docker inspect --format '{{.State.Pid}}' l3leaf32-net)
sudo ln -sf /proc/${l3leaf32pid}/ns/net /var/run/netns/l3leaf32
# Connecting cEOS containers together
sudo ip link set 3b37et2 netns l3leaf32 name et2 up
sudo ip link set 3b37et3 netns l3leaf32 name et3 up
sudo ip link set 3b37et1 netns l3leaf32 name et1 up
sudo ip link add l3leaf32-eth0 type veth peer name l3leaf32-mgmt
sudo ip link set l3leaf32-eth0 netns l3leaf32 name eth0 up
sudo ip netns exec l3leaf32 ip link set dev eth0 down
sudo ip netns exec l3leaf32 ip link set dev eth0 address 00:1c:73:c7:c6:01
sudo ip netns exec l3leaf32 ip link set dev eth0 up
sudo ip link set l3leaf32-mgmt up
sleep 1
sudo brctl addif vmgmt l3leaf32-mgmt
docker run -d --name=l3leaf32 --log-opt max-size=1m --net=container:l3leaf32-net --ip 192.168.50.38 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/leaf32:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/brdr1" ]; then mkdir /workspaces/rLab-eos/configs/L3/brdr1; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3brdr1" > /workspaces/rLab-eos/configs/L3/brdr1/ceos-config
# Getting brdr1 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3brdr1-net --net=none busybox /bin/init
l3brdr1pid=$(docker inspect --format '{{.State.Pid}}' l3brdr1-net)
sudo ln -sf /proc/${l3brdr1pid}/ns/net /var/run/netns/l3brdr1
# Connecting cEOS containers together
sudo ip link set 9eaaet2 netns l3brdr1 name et2 up
sudo ip link set 9eaaet3 netns l3brdr1 name et3 up
sudo ip link set 9eaaet1 netns l3brdr1 name et1 up
sudo ip link add l3brdr1-eth0 type veth peer name l3brdr1-mgmt
sudo ip link set l3brdr1-eth0 netns l3brdr1 name eth0 up
sudo ip netns exec l3brdr1 ip link set dev eth0 down
sudo ip netns exec l3brdr1 ip link set dev eth0 address 00:1c:73:c8:c6:01
sudo ip netns exec l3brdr1 ip link set dev eth0 up
sudo ip link set l3brdr1-mgmt up
sleep 1
sudo brctl addif vmgmt l3brdr1-mgmt
docker run -d --name=l3brdr1 --log-opt max-size=1m --net=container:l3brdr1-net --ip 192.168.50.39 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/brdr1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Checking for configs directory for each cEOS node
if ! [ -d "/workspaces/rLab-eos/configs/L3/brdr2" ]; then mkdir /workspaces/rLab-eos/configs/L3/brdr2; fi
# Creating the ceos-config file.
echo "SERIALNUMBER=l3brdr2" > /workspaces/rLab-eos/configs/L3/brdr2/ceos-config
# Getting brdr2 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3brdr2-net --net=none busybox /bin/init
l3brdr2pid=$(docker inspect --format '{{.State.Pid}}' l3brdr2-net)
sudo ln -sf /proc/${l3brdr2pid}/ns/net /var/run/netns/l3brdr2
# Connecting cEOS containers together
sudo ip link set 69b5et2 netns l3brdr2 name et2 up
sudo ip link set 69b5et3 netns l3brdr2 name et3 up
sudo ip link set 69b5et1 netns l3brdr2 name et1 up
sudo ip link add l3brdr2-eth0 type veth peer name l3brdr2-mgmt
sudo ip link set l3brdr2-eth0 netns l3brdr2 name eth0 up
sudo ip netns exec l3brdr2 ip link set dev eth0 down
sudo ip netns exec l3brdr2 ip link set dev eth0 address 00:1c:73:c9:c6:01
sudo ip netns exec l3brdr2 ip link set dev eth0 up
sudo ip link set l3brdr2-mgmt up
sleep 1
sudo brctl addif vmgmt l3brdr2-mgmt
docker run -d --name=l3brdr2 --log-opt max-size=1m --net=container:l3brdr2-net --ip 192.168.50.40 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/L3/brdr2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
# Getting host11 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3host11-net --net=none busybox /bin/init
l3host11pid=$(docker inspect --format '{{.State.Pid}}' l3host11-net)
sudo ln -sf /proc/${l3host11pid}/ns/net /var/run/netns/l3host11
# Connecting host containers together
sudo ip link set 8d5aet0 netns l3host11 name et0 up
sleep 1
docker run -d --name=l3host11 --privileged --log-opt max-size=1m --net=container:l3host11-net -e HOSTNAME=l3host11 -e HOST_IP=192.168.12.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.12.1 chost:1.0 ipnet
# Getting host12 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3host12-net --net=none busybox /bin/init
l3host12pid=$(docker inspect --format '{{.State.Pid}}' l3host12-net)
sudo ln -sf /proc/${l3host12pid}/ns/net /var/run/netns/l3host12
# Connecting host containers together
sudo ip link set 679det0 netns l3host12 name et0 up
sleep 1
docker run -d --name=l3host12 --privileged --log-opt max-size=1m --net=container:l3host12-net -e HOSTNAME=l3host12 -e HOST_IP=192.168.13.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.13.1 chost:1.0 ipnet
# Getting host21 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3host21-net --net=none busybox /bin/init
l3host21pid=$(docker inspect --format '{{.State.Pid}}' l3host21-net)
sudo ln -sf /proc/${l3host21pid}/ns/net /var/run/netns/l3host21
# Connecting host containers together
sudo ip link set 8872et0 netns l3host21 name et0 up
sleep 1
docker run -d --name=l3host21 --privileged --log-opt max-size=1m --net=container:l3host21-net -e HOSTNAME=l3host21 -e HOST_IP=192.168.12.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.12.1 chost:1.0 ipnet
# Getting host22 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3host22-net --net=none busybox /bin/init
l3host22pid=$(docker inspect --format '{{.State.Pid}}' l3host22-net)
sudo ln -sf /proc/${l3host22pid}/ns/net /var/run/netns/l3host22
# Connecting host containers together
sudo ip link set 0259et0 netns l3host22 name et0 up
sleep 1
docker run -d --name=l3host22 --privileged --log-opt max-size=1m --net=container:l3host22-net -e HOSTNAME=l3host22 -e HOST_IP=192.168.13.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.13.1 chost:1.0 ipnet
# Getting host31 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3host31-net --net=none busybox /bin/init
l3host31pid=$(docker inspect --format '{{.State.Pid}}' l3host31-net)
sudo ln -sf /proc/${l3host31pid}/ns/net /var/run/netns/l3host31
# Connecting host containers together
sudo ip link set 0c74et0 netns l3host31 name et0 up
sleep 1
docker run -d --name=l3host31 --privileged --log-opt max-size=1m --net=container:l3host31-net -e HOSTNAME=l3host31 -e HOST_IP=192.168.12.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.12.1 chost:1.0 ipnet
# Getting host32 nodes plumbing
docker run -d --restart=always --log-opt max-size=10k --name=l3host32-net --net=none busybox /bin/init
l3host32pid=$(docker inspect --format '{{.State.Pid}}' l3host32-net)
sudo ln -sf /proc/${l3host32pid}/ns/net /var/run/netns/l3host32
# Connecting host containers together
sudo ip link set 361aet0 netns l3host32 name et0 up
sleep 1
docker run -d --name=l3host32 --privileged --log-opt max-size=1m --net=container:l3host32-net -e HOSTNAME=l3host32 -e HOST_IP=192.168.13.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.13.1 chost:1.0 ipnet
docker exec -d l3host11 iperf3 -s -p 5010
docker exec -d l3host12 iperf3 -s -p 5010
docker exec -d l3host31 iperf3 -s -p 5010
docker exec -d l3host21 iperf3client 192.168.12.11 5010 1000000
docker exec -d l3host32 iperf3client 192.168.13.11 5010 1000000
docker exec -d l3host22 iperf3client 192.168.12.31 5010 1000000
