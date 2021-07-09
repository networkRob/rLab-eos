#!/bin/bash

sudo sh -c 'echo "fs.inotify.max_user_instances = 50000" > /etc/sysctl.d/99-zceos.conf'
sudo sysctl -w fs.inotify.max_user_instances=50000
sudo ip netns add L3
sudo ip link add l3spine1et1 type veth peer name l3leaf11et2
sudo ip link add l3spine1et2 type veth peer name l3leaf12et2
sudo ip link add l3spine1et3 type veth peer name l3leaf21et2
sudo ip link add l3spine1et4 type veth peer name l3leaf22et2
sudo ip link add l3spine1et5 type veth peer name l3leaf31et2
sudo ip link add l3spine1et6 type veth peer name l3leaf32et2
sudo ip link add l3spine1et7 type veth peer name l3brdr1et2
sudo ip link add l3spine1et8 type veth peer name l3brdr2et2
sudo ip link add l3spine2et1 type veth peer name l3leaf11et3
sudo ip link add l3spine2et2 type veth peer name l3leaf12et3
sudo ip link add l3spine2et3 type veth peer name l3leaf21et3
sudo ip link add l3spine2et4 type veth peer name l3leaf22et3
sudo ip link add l3spine2et5 type veth peer name l3leaf31et3
sudo ip link add l3spine2et6 type veth peer name l3leaf32et3
sudo ip link add l3spine2et7 type veth peer name l3brdr1et3
sudo ip link add l3spine2et8 type veth peer name l3brdr2et3
sudo ip link add l3leaf11et1 type veth peer name l3leaf12et1
sudo ip link add l3leaf11et4 type veth peer name l3host11et0
sudo ip link add l3leaf11et5 type veth peer name l3host12et0
sudo ip link add l3leaf21et1 type veth peer name l3leaf22et1
sudo ip link add l3leaf21et4 type veth peer name l3host21et0
sudo ip link add l3leaf22et4 type veth peer name l3host22et0
sudo ip link add l3leaf31et1 type veth peer name l3leaf32et1
sudo ip link add l3leaf31et4 type veth peer name l3host31et0
sudo ip link add l3leaf31et5 type veth peer name l3host32et0
sudo ip link add l3brdr1et1 type veth peer name l3brdr2et1
docker start l3spine1-net
docker stop l3spine1
docker rm l3spine1
l3spine1pid=$(docker inspect --format '{{.State.Pid}}' l3spine1-net)
sudo ln -sf /proc/${l3spine1pid}/ns/net /var/run/netns/l3spine1
sudo ip link set l3spine1et1 netns l3spine1 name et1 up
sudo ip link set l3spine1et2 netns l3spine1 name et2 up
sudo ip link set l3spine1et3 netns l3spine1 name et3 up
sudo ip link set l3spine1et4 netns l3spine1 name et4 up
sudo ip link set l3spine1et5 netns l3spine1 name et5 up
sudo ip link set l3spine1et6 netns l3spine1 name et6 up
sudo ip link set l3spine1et7 netns l3spine1 name et7 up
sudo ip link set l3spine1et8 netns l3spine1 name et8 up
sudo ip link add l3spine1-eth0 type veth peer name l3spine1-mgmt
sudo brctl addif vmgmt l3spine1-mgmt
sudo ip link set l3spine1-eth0 netns l3spine1 name eth0 up
sudo ip link set l3spine1-mgmt up
sleep 1
docker run -d --name=l3spine1 --log-opt max-size=1m --net=container:l3spine1-net --ip 192.168.50.31 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/spine1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3spine2-net
docker stop l3spine2
docker rm l3spine2
l3spine2pid=$(docker inspect --format '{{.State.Pid}}' l3spine2-net)
sudo ln -sf /proc/${l3spine2pid}/ns/net /var/run/netns/l3spine2
sudo ip link set l3spine2et1 netns l3spine2 name et1 up
sudo ip link set l3spine2et2 netns l3spine2 name et2 up
sudo ip link set l3spine2et3 netns l3spine2 name et3 up
sudo ip link set l3spine2et4 netns l3spine2 name et4 up
sudo ip link set l3spine2et5 netns l3spine2 name et5 up
sudo ip link set l3spine2et6 netns l3spine2 name et6 up
sudo ip link set l3spine2et7 netns l3spine2 name et7 up
sudo ip link set l3spine2et8 netns l3spine2 name et8 up
sudo ip link add l3spine2-eth0 type veth peer name l3spine2-mgmt
sudo brctl addif vmgmt l3spine2-mgmt
sudo ip link set l3spine2-eth0 netns l3spine2 name eth0 up
sudo ip link set l3spine2-mgmt up
sleep 1
docker run -d --name=l3spine2 --log-opt max-size=1m --net=container:l3spine2-net --ip 192.168.50.32 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/spine2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3leaf11-net
docker stop l3leaf11
docker rm l3leaf11
l3leaf11pid=$(docker inspect --format '{{.State.Pid}}' l3leaf11-net)
sudo ln -sf /proc/${l3leaf11pid}/ns/net /var/run/netns/l3leaf11
sudo ip link set l3leaf11et1 netns l3leaf11 name et1 up
sudo ip link set l3leaf11et2 netns l3leaf11 name et2 up
sudo ip link set l3leaf11et3 netns l3leaf11 name et3 up
sudo ip link set l3leaf11et4 netns l3leaf11 name et4 up
sudo ip link set l3leaf11et5 netns l3leaf11 name et5 up
sudo ip link add l3leaf11-eth0 type veth peer name l3leaf11-mgmt
sudo brctl addif vmgmt l3leaf11-mgmt
sudo ip link set l3leaf11-eth0 netns l3leaf11 name eth0 up
sudo ip link set l3leaf11-mgmt up
sleep 1
docker run -d --name=l3leaf11 --log-opt max-size=1m --net=container:l3leaf11-net --ip 192.168.50.33 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/leaf11:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3leaf12-net
docker stop l3leaf12
docker rm l3leaf12
l3leaf12pid=$(docker inspect --format '{{.State.Pid}}' l3leaf12-net)
sudo ln -sf /proc/${l3leaf12pid}/ns/net /var/run/netns/l3leaf12
sudo ip link set l3leaf12et1 netns l3leaf12 name et1 up
sudo ip link set l3leaf12et2 netns l3leaf12 name et2 up
sudo ip link set l3leaf12et3 netns l3leaf12 name et3 up
sudo ip link add l3leaf12-eth0 type veth peer name l3leaf12-mgmt
sudo brctl addif vmgmt l3leaf12-mgmt
sudo ip link set l3leaf12-eth0 netns l3leaf12 name eth0 up
sudo ip link set l3leaf12-mgmt up
sleep 1
docker run -d --name=l3leaf12 --log-opt max-size=1m --net=container:l3leaf12-net --ip 192.168.50.34 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/leaf12:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3leaf21-net
docker stop l3leaf21
docker rm l3leaf21
l3leaf21pid=$(docker inspect --format '{{.State.Pid}}' l3leaf21-net)
sudo ln -sf /proc/${l3leaf21pid}/ns/net /var/run/netns/l3leaf21
sudo ip link set l3leaf21et1 netns l3leaf21 name et1 up
sudo ip link set l3leaf21et2 netns l3leaf21 name et2 up
sudo ip link set l3leaf21et3 netns l3leaf21 name et3 up
sudo ip link set l3leaf21et4 netns l3leaf21 name et4 up
sudo ip link add l3leaf21-eth0 type veth peer name l3leaf21-mgmt
sudo brctl addif vmgmt l3leaf21-mgmt
sudo ip link set l3leaf21-eth0 netns l3leaf21 name eth0 up
sudo ip link set l3leaf21-mgmt up
sleep 1
docker run -d --name=l3leaf21 --log-opt max-size=1m --net=container:l3leaf21-net --ip 192.168.50.35 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/leaf21:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3leaf22-net
docker stop l3leaf22
docker rm l3leaf22
l3leaf22pid=$(docker inspect --format '{{.State.Pid}}' l3leaf22-net)
sudo ln -sf /proc/${l3leaf22pid}/ns/net /var/run/netns/l3leaf22
sudo ip link set l3leaf22et1 netns l3leaf22 name et1 up
sudo ip link set l3leaf22et2 netns l3leaf22 name et2 up
sudo ip link set l3leaf22et3 netns l3leaf22 name et3 up
sudo ip link set l3leaf22et4 netns l3leaf22 name et4 up
sudo ip link add l3leaf22-eth0 type veth peer name l3leaf22-mgmt
sudo brctl addif vmgmt l3leaf22-mgmt
sudo ip link set l3leaf22-eth0 netns l3leaf22 name eth0 up
sudo ip link set l3leaf22-mgmt up
sleep 1
docker run -d --name=l3leaf22 --log-opt max-size=1m --net=container:l3leaf22-net --ip 192.168.50.36 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/leaf22:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3leaf31-net
docker stop l3leaf31
docker rm l3leaf31
l3leaf31pid=$(docker inspect --format '{{.State.Pid}}' l3leaf31-net)
sudo ln -sf /proc/${l3leaf31pid}/ns/net /var/run/netns/l3leaf31
sudo ip link set l3leaf31et1 netns l3leaf31 name et1 up
sudo ip link set l3leaf31et2 netns l3leaf31 name et2 up
sudo ip link set l3leaf31et3 netns l3leaf31 name et3 up
sudo ip link set l3leaf31et4 netns l3leaf31 name et4 up
sudo ip link set l3leaf31et5 netns l3leaf31 name et5 up
sudo ip link add l3leaf31-eth0 type veth peer name l3leaf31-mgmt
sudo brctl addif vmgmt l3leaf31-mgmt
sudo ip link set l3leaf31-eth0 netns l3leaf31 name eth0 up
sudo ip link set l3leaf31-mgmt up
sleep 1
docker run -d --name=l3leaf31 --log-opt max-size=1m --net=container:l3leaf31-net --ip 192.168.50.37 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/leaf31:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3leaf32-net
docker stop l3leaf32
docker rm l3leaf32
l3leaf32pid=$(docker inspect --format '{{.State.Pid}}' l3leaf32-net)
sudo ln -sf /proc/${l3leaf32pid}/ns/net /var/run/netns/l3leaf32
sudo ip link set l3leaf32et1 netns l3leaf32 name et1 up
sudo ip link set l3leaf32et2 netns l3leaf32 name et2 up
sudo ip link set l3leaf32et3 netns l3leaf32 name et3 up
sudo ip link add l3leaf32-eth0 type veth peer name l3leaf32-mgmt
sudo brctl addif vmgmt l3leaf32-mgmt
sudo ip link set l3leaf32-eth0 netns l3leaf32 name eth0 up
sudo ip link set l3leaf32-mgmt up
sleep 1
docker run -d --name=l3leaf32 --log-opt max-size=1m --net=container:l3leaf32-net --ip 192.168.50.38 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/leaf32:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3brdr1-net
docker stop l3brdr1
docker rm l3brdr1
l3brdr1pid=$(docker inspect --format '{{.State.Pid}}' l3brdr1-net)
sudo ln -sf /proc/${l3brdr1pid}/ns/net /var/run/netns/l3brdr1
sudo ip link set l3brdr1et1 netns l3brdr1 name et1 up
sudo ip link set l3brdr1et2 netns l3brdr1 name et2 up
sudo ip link set l3brdr1et3 netns l3brdr1 name et3 up
sudo ip link add l3brdr1-eth0 type veth peer name l3brdr1-mgmt
sudo brctl addif vmgmt l3brdr1-mgmt
sudo ip link set l3brdr1-eth0 netns l3brdr1 name eth0 up
sudo ip link set l3brdr1-mgmt up
sleep 1
docker run -d --name=l3brdr1 --log-opt max-size=1m --net=container:l3brdr1-net --ip 192.168.50.39 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/brdr1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3brdr2-net
docker stop l3brdr2
docker rm l3brdr2
l3brdr2pid=$(docker inspect --format '{{.State.Pid}}' l3brdr2-net)
sudo ln -sf /proc/${l3brdr2pid}/ns/net /var/run/netns/l3brdr2
sudo ip link set l3brdr2et1 netns l3brdr2 name et1 up
sudo ip link set l3brdr2et2 netns l3brdr2 name et2 up
sudo ip link set l3brdr2et3 netns l3brdr2 name et3 up
sudo ip link add l3brdr2-eth0 type veth peer name l3brdr2-mgmt
sudo brctl addif vmgmt l3brdr2-mgmt
sudo ip link set l3brdr2-eth0 netns l3brdr2 name eth0 up
sudo ip link set l3brdr2-mgmt up
sleep 1
docker run -d --name=l3brdr2 --log-opt max-size=1m --net=container:l3brdr2-net --ip 192.168.50.40 --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /home/rmartin/rLab-eos/configs/L3/brdr2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.26.1F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start l3host11-net
docker stop l3host11
docker rm l3host11
l3host11pid=$(docker inspect --format '{{.State.Pid}}' l3host11-net)
sudo ln -sf /proc/${l3host11pid}/ns/net /var/run/netns/l3host11
sudo ip link set l3host11et0 netns l3host11 name et0 up
sleep 1
docker run -d --name=l3host11 --privileged --log-opt max-size=1m --net=container:l3host11-net -e HOSTNAME=l3host11 -e HOST_IP=192.168.12.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.12.1 chost:1.0 ipnet
docker start l3host12-net
docker stop l3host12
docker rm l3host12
l3host12pid=$(docker inspect --format '{{.State.Pid}}' l3host12-net)
sudo ln -sf /proc/${l3host12pid}/ns/net /var/run/netns/l3host12
sudo ip link set l3host12et0 netns l3host12 name et0 up
sleep 1
docker run -d --name=l3host12 --privileged --log-opt max-size=1m --net=container:l3host12-net -e HOSTNAME=l3host12 -e HOST_IP=192.168.13.11 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.13.1 chost:1.0 ipnet
docker start l3host21-net
docker stop l3host21
docker rm l3host21
l3host21pid=$(docker inspect --format '{{.State.Pid}}' l3host21-net)
sudo ln -sf /proc/${l3host21pid}/ns/net /var/run/netns/l3host21
sudo ip link set l3host21et0 netns l3host21 name et0 up
sleep 1
docker run -d --name=l3host21 --privileged --log-opt max-size=1m --net=container:l3host21-net -e HOSTNAME=l3host21 -e HOST_IP=192.168.12.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.12.1 chost:1.0 ipnet
docker start l3host22-net
docker stop l3host22
docker rm l3host22
l3host22pid=$(docker inspect --format '{{.State.Pid}}' l3host22-net)
sudo ln -sf /proc/${l3host22pid}/ns/net /var/run/netns/l3host22
sudo ip link set l3host22et0 netns l3host22 name et0 up
sleep 1
docker run -d --name=l3host22 --privileged --log-opt max-size=1m --net=container:l3host22-net -e HOSTNAME=l3host22 -e HOST_IP=192.168.13.21 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.13.1 chost:1.0 ipnet
docker start l3host31-net
docker stop l3host31
docker rm l3host31
l3host31pid=$(docker inspect --format '{{.State.Pid}}' l3host31-net)
sudo ln -sf /proc/${l3host31pid}/ns/net /var/run/netns/l3host31
sudo ip link set l3host31et0 netns l3host31 name et0 up
sleep 1
docker run -d --name=l3host31 --privileged --log-opt max-size=1m --net=container:l3host31-net -e HOSTNAME=l3host31 -e HOST_IP=192.168.12.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.12.1 chost:1.0 ipnet
docker start l3host32-net
docker stop l3host32
docker rm l3host32
l3host32pid=$(docker inspect --format '{{.State.Pid}}' l3host32-net)
sudo ln -sf /proc/${l3host32pid}/ns/net /var/run/netns/l3host32
sudo ip link set l3host32et0 netns l3host32 name et0 up
sleep 1
docker run -d --name=l3host32 --privileged --log-opt max-size=1m --net=container:l3host32-net -e HOSTNAME=l3host32 -e HOST_IP=192.168.13.31 -e HOST_MASK=255.255.255.0 -e HOST_GW=192.168.13.1 chost:1.0 ipnet
docker exec -d l3host11 iperf3 -s -p 5010
docker exec -d l3host12 iperf3 -s -p 5010
docker exec -d l3host31 iperf3 -s -p 5010
docker exec -d l3host21 iperf3client 192.168.12.11 5010 1000000
docker exec -d l3host32 iperf3client 192.168.13.11 5010 1000000
docker exec -d l3host22 iperf3client 192.168.12.31 5010 1000000
