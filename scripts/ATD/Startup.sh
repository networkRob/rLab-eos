#!/bin/bash

sudo sh -c 'echo "fs.inotify.max_user_instances = 50000" > /etc/sysctl.d/99-zceos.conf'
sudo sysctl -w fs.inotify.max_user_instances=50000
sudo ip netns add ATD
sudo ip link add 657cet1 type veth peer name 8f30et1
sudo ip link add 657cet2 type veth peer name 0aafet2
sudo ip link add 657cet3 type veth peer name 7b82et2
sudo ip link add 657cet4 type veth peer name 0369et2
sudo ip link add 657cet5 type veth peer name 3226et2
sudo ip link add 657cet6 type veth peer name 8f30et6
sudo ip link add 8f30et2 type veth peer name 0aafet3
sudo ip link add 8f30et3 type veth peer name 7b82et3
sudo ip link add 8f30et4 type veth peer name 0369et3
sudo ip link add 8f30et5 type veth peer name 3226et3
sudo ip link add 0aafet1 type veth peer name 7b82et1
sudo ip link add 0aafet4 type veth peer name 57e1et1
sudo ip link add 0aafet5 type veth peer name 57e1et3
sudo ip link add 0aafet6 type veth peer name 7b82et6
sudo ip link add 7b82et4 type veth peer name 57e1et2
sudo ip link add 7b82et5 type veth peer name 57e1et4
sudo ip link add 7b82et6 type veth peer name 57e1et6
sudo ip link add 0369et1 type veth peer name 3226et1
sudo ip link add 0369et4 type veth peer name a49det1
sudo ip link add 0369et5 type veth peer name a49det3
sudo ip link add 0369et6 type veth peer name 3226et6
sudo ip link add 3226et4 type veth peer name a49det2
sudo ip link add 3226et5 type veth peer name a49det4
sudo ip link add 3226et6 type veth peer name a49det6
docker start atdspine1-net
docker stop atdspine1
docker rm atdspine1
atdspine1pid=$(docker inspect --format '{{.State.Pid}}' atdspine1-net)
sudo ln -sf /proc/${atdspine1pid}/ns/net /var/run/netns/atdspine1
sudo ip link set 657cet1 netns atdspine1 name et1 up
sudo ip link set 657cet2 netns atdspine1 name et2 up
sudo ip link set 657cet3 netns atdspine1 name et3 up
sudo ip link set 657cet4 netns atdspine1 name et4 up
sudo ip link set 657cet5 netns atdspine1 name et5 up
sudo ip link set 657cet6 netns atdspine1 name et6 up
sudo ip link add atdspine1-eth0 type veth peer name atdspine1-mgmt
sudo ip link set atdspine1-eth0 netns atdspine1 name eth0 up
sudo ip netns exec atdspine1 ip link set dev eth0 down
sudo ip netns exec atdspine1 ip link set dev eth0 address 00:1c:73:f0:c6:01
sudo ip netns exec atdspine1 ip link set dev eth0 up
sudo ip link set atdspine1-mgmt up
sleep 1
docker run -d --name=atdspine1 --log-opt max-size=1m --net=container:atdspine1-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/spine1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdspine2-net
docker stop atdspine2
docker rm atdspine2
atdspine2pid=$(docker inspect --format '{{.State.Pid}}' atdspine2-net)
sudo ln -sf /proc/${atdspine2pid}/ns/net /var/run/netns/atdspine2
sudo ip link set 8f30et1 netns atdspine2 name et1 up
sudo ip link set 8f30et6 netns atdspine2 name et6 up
sudo ip link set 8f30et2 netns atdspine2 name et2 up
sudo ip link set 8f30et3 netns atdspine2 name et3 up
sudo ip link set 8f30et4 netns atdspine2 name et4 up
sudo ip link set 8f30et5 netns atdspine2 name et5 up
sudo ip link add atdspine2-eth0 type veth peer name atdspine2-mgmt
sudo ip link set atdspine2-eth0 netns atdspine2 name eth0 up
sudo ip netns exec atdspine2 ip link set dev eth0 down
sudo ip netns exec atdspine2 ip link set dev eth0 address 00:1c:73:f1:c6:01
sudo ip netns exec atdspine2 ip link set dev eth0 up
sudo ip link set atdspine2-mgmt up
sleep 1
docker run -d --name=atdspine2 --log-opt max-size=1m --net=container:atdspine2-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/spine2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf1-net
docker stop atdleaf1
docker rm atdleaf1
atdleaf1pid=$(docker inspect --format '{{.State.Pid}}' atdleaf1-net)
sudo ln -sf /proc/${atdleaf1pid}/ns/net /var/run/netns/atdleaf1
sudo ip link set 0aafet2 netns atdleaf1 name et2 up
sudo ip link set 0aafet3 netns atdleaf1 name et3 up
sudo ip link set 0aafet1 netns atdleaf1 name et1 up
sudo ip link set 0aafet4 netns atdleaf1 name et4 up
sudo ip link set 0aafet5 netns atdleaf1 name et5 up
sudo ip link set 0aafet6 netns atdleaf1 name et6 up
sudo ip link add atdleaf1-eth0 type veth peer name atdleaf1-mgmt
sudo ip link set atdleaf1-eth0 netns atdleaf1 name eth0 up
sudo ip netns exec atdleaf1 ip link set dev eth0 down
sudo ip netns exec atdleaf1 ip link set dev eth0 address 00:1c:73:f2:c6:01
sudo ip netns exec atdleaf1 ip link set dev eth0 up
sudo ip link set atdleaf1-mgmt up
sleep 1
docker run -d --name=atdleaf1 --log-opt max-size=1m --net=container:atdleaf1-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/leaf1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf2-net
docker stop atdleaf2
docker rm atdleaf2
atdleaf2pid=$(docker inspect --format '{{.State.Pid}}' atdleaf2-net)
sudo ln -sf /proc/${atdleaf2pid}/ns/net /var/run/netns/atdleaf2
sudo ip link set 7b82et2 netns atdleaf2 name et2 up
sudo ip link set 7b82et3 netns atdleaf2 name et3 up
sudo ip link set 7b82et1 netns atdleaf2 name et1 up
sudo ip link set 7b82et6 netns atdleaf2 name et6 up
sudo ip link set 7b82et4 netns atdleaf2 name et4 up
sudo ip link set 7b82et5 netns atdleaf2 name et5 up
sudo ip link add atdleaf2-eth0 type veth peer name atdleaf2-mgmt
sudo ip link set atdleaf2-eth0 netns atdleaf2 name eth0 up
sudo ip netns exec atdleaf2 ip link set dev eth0 down
sudo ip netns exec atdleaf2 ip link set dev eth0 address 00:1c:73:f3:c6:01
sudo ip netns exec atdleaf2 ip link set dev eth0 up
sudo ip link set atdleaf2-mgmt up
sleep 1
docker run -d --name=atdleaf2 --log-opt max-size=1m --net=container:atdleaf2-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/leaf2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf3-net
docker stop atdleaf3
docker rm atdleaf3
atdleaf3pid=$(docker inspect --format '{{.State.Pid}}' atdleaf3-net)
sudo ln -sf /proc/${atdleaf3pid}/ns/net /var/run/netns/atdleaf3
sudo ip link set 0369et2 netns atdleaf3 name et2 up
sudo ip link set 0369et3 netns atdleaf3 name et3 up
sudo ip link set 0369et1 netns atdleaf3 name et1 up
sudo ip link set 0369et4 netns atdleaf3 name et4 up
sudo ip link set 0369et5 netns atdleaf3 name et5 up
sudo ip link set 0369et6 netns atdleaf3 name et6 up
sudo ip link add atdleaf3-eth0 type veth peer name atdleaf3-mgmt
sudo ip link set atdleaf3-eth0 netns atdleaf3 name eth0 up
sudo ip netns exec atdleaf3 ip link set dev eth0 down
sudo ip netns exec atdleaf3 ip link set dev eth0 address 00:1c:73:f4:c6:01
sudo ip netns exec atdleaf3 ip link set dev eth0 up
sudo ip link set atdleaf3-mgmt up
sleep 1
docker run -d --name=atdleaf3 --log-opt max-size=1m --net=container:atdleaf3-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/leaf3:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdleaf4-net
docker stop atdleaf4
docker rm atdleaf4
atdleaf4pid=$(docker inspect --format '{{.State.Pid}}' atdleaf4-net)
sudo ln -sf /proc/${atdleaf4pid}/ns/net /var/run/netns/atdleaf4
sudo ip link set 3226et2 netns atdleaf4 name et2 up
sudo ip link set 3226et3 netns atdleaf4 name et3 up
sudo ip link set 3226et1 netns atdleaf4 name et1 up
sudo ip link set 3226et6 netns atdleaf4 name et6 up
sudo ip link set 3226et4 netns atdleaf4 name et4 up
sudo ip link set 3226et5 netns atdleaf4 name et5 up
sudo ip link add atdleaf4-eth0 type veth peer name atdleaf4-mgmt
sudo ip link set atdleaf4-eth0 netns atdleaf4 name eth0 up
sudo ip netns exec atdleaf4 ip link set dev eth0 down
sudo ip netns exec atdleaf4 ip link set dev eth0 address 00:1c:73:f5:c6:01
sudo ip netns exec atdleaf4 ip link set dev eth0 up
sudo ip link set atdleaf4-mgmt up
sleep 1
docker run -d --name=atdleaf4 --log-opt max-size=1m --net=container:atdleaf4-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/leaf4:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdhost1-net
docker stop atdhost1
docker rm atdhost1
atdhost1pid=$(docker inspect --format '{{.State.Pid}}' atdhost1-net)
sudo ln -sf /proc/${atdhost1pid}/ns/net /var/run/netns/atdhost1
sudo ip link set 57e1et1 netns atdhost1 name et1 up
sudo ip link set 57e1et3 netns atdhost1 name et3 up
sudo ip link set 57e1et2 netns atdhost1 name et2 up
sudo ip link set 57e1et4 netns atdhost1 name et4 up
sudo ip link set 57e1et6 netns atdhost1 name et6 up
sudo ip link add atdhost1-eth0 type veth peer name atdhost1-mgmt
sudo ip link set atdhost1-eth0 netns atdhost1 name eth0 up
sudo ip netns exec atdhost1 ip link set dev eth0 down
sudo ip netns exec atdhost1 ip link set dev eth0 address 00:1c:73:f7:c6:01
sudo ip netns exec atdhost1 ip link set dev eth0 up
sudo ip link set atdhost1-mgmt up
sleep 1
docker run -d --name=atdhost1 --log-opt max-size=1m --net=container:atdhost1-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/host1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start atdhost2-net
docker stop atdhost2
docker rm atdhost2
atdhost2pid=$(docker inspect --format '{{.State.Pid}}' atdhost2-net)
sudo ln -sf /proc/${atdhost2pid}/ns/net /var/run/netns/atdhost2
sudo ip link set a49det1 netns atdhost2 name et1 up
sudo ip link set a49det3 netns atdhost2 name et3 up
sudo ip link set a49det2 netns atdhost2 name et2 up
sudo ip link set a49det4 netns atdhost2 name et4 up
sudo ip link set a49det6 netns atdhost2 name et6 up
sudo ip link add atdhost2-eth0 type veth peer name atdhost2-mgmt
sudo ip link set atdhost2-eth0 netns atdhost2 name eth0 up
sudo ip netns exec atdhost2 ip link set dev eth0 down
sudo ip netns exec atdhost2 ip link set dev eth0 address 00:1c:73:f8:c6:01
sudo ip netns exec atdhost2 ip link set dev eth0 up
sudo ip link set atdhost2-mgmt up
sleep 1
docker run -d --name=atdhost2 --log-opt max-size=1m --net=container:atdhost2-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/ATD/host2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
