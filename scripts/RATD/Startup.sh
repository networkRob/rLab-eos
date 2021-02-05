#!/bin/bash

sudo echo "fs.inotify.max_user_instances = 50000" > /etc/sysctl.d/99-zceos.conf
sudo sysctl -w fs.inotify.max_user_instances=50000
sudo ip netns add RATD
sudo ip link add ratdeos1et1 type veth peer name ratdeos2et5
sudo ip link add ratdeos1et2 type veth peer name ratdeos7et3
sudo ip link add ratdeos1et3 type veth peer name ratdeos11et1
sudo ip link add ratdeos1et4 type veth peer name ratdeos6et4
sudo ip link add ratdeos1et5 type veth peer name ratdeos5et4
sudo ip link add ratdeos1et6 type veth peer name ratdeos17et1
sudo ip link add ratdeos2et1 type veth peer name ratdeos3et3
sudo ip link add ratdeos2et2 type veth peer name ratdeos4et4
sudo ip link add ratdeos2et3 type veth peer name ratdeos5et3
sudo ip link add ratdeos2et4 type veth peer name ratdeos6et5
sudo ip link add ratdeos3et1 type veth peer name ratdeos9et2
sudo ip link add ratdeos3et2 type veth peer name ratdeos7et1
sudo ip link add ratdeos3et4 type veth peer name ratdeos5et2
sudo ip link add ratdeos3et5 type veth peer name ratdeos4et5
sudo ip link add ratdeos3et6 type veth peer name ratdeos20et1
sudo ip link add ratdeos4et1 type veth peer name ratdeos9et1
sudo ip link add ratdeos4et2 type veth peer name ratdeos8et1
sudo ip link add ratdeos4et3 type veth peer name ratdeos5et1
sudo ip link add ratdeos4et6 type veth peer name ratdeos16et1
sudo ip link add ratdeos5et5 type veth peer name ratdeos6et1
sudo ip link add ratdeos6et2 type veth peer name ratdeos8et3
sudo ip link add ratdeos6et3 type veth peer name ratdeos13et1
sudo ip link add ratdeos6et6 type veth peer name ratdeos14et2
sudo ip link add ratdeos7et2 type veth peer name ratdeos10et1
sudo ip link add ratdeos7et4 type veth peer name ratdeos19et1
sudo ip link add ratdeos8et2 type veth peer name ratdeos15et1
sudo ip link add ratdeos8et4 type veth peer name ratdeos14et1
sudo ip link add ratdeos8et5 type veth peer name ratdeos18et1
sudo ip link add ratdeos11et2 type veth peer name ratdeos12et2
sudo ip link add ratdeos11et3 type veth peer name ratdeos13et3
sudo ip link add ratdeos12et1 type veth peer name ratdeos13et2
docker start ratdeos1-net
docker stop ratdeos1
docker rm ratdeos1
ratdeos1pid=$(docker inspect --format '{{.State.Pid}}' ratdeos1-net)
sudo ln -sf /proc/${ratdeos1pid}/ns/net /var/run/netns/ratdeos1
sudo ip link set ratdeos1et1 netns ratdeos1 name et1 up
sudo ip link set ratdeos1et2 netns ratdeos1 name et2 up
sudo ip link set ratdeos1et3 netns ratdeos1 name et3 up
sudo ip link set ratdeos1et4 netns ratdeos1 name et4 up
sudo ip link set ratdeos1et5 netns ratdeos1 name et5 up
sudo ip link set ratdeos1et6 netns ratdeos1 name et6 up
sleep 1
docker run -d --name=ratdeos1 --log-opt max-size=1m --net=container:ratdeos1-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos2-net
docker stop ratdeos2
docker rm ratdeos2
ratdeos2pid=$(docker inspect --format '{{.State.Pid}}' ratdeos2-net)
sudo ln -sf /proc/${ratdeos2pid}/ns/net /var/run/netns/ratdeos2
sudo ip link set ratdeos2et1 netns ratdeos2 name et1 up
sudo ip link set ratdeos2et2 netns ratdeos2 name et2 up
sudo ip link set ratdeos2et3 netns ratdeos2 name et3 up
sudo ip link set ratdeos2et4 netns ratdeos2 name et4 up
sudo ip link set ratdeos2et5 netns ratdeos2 name et5 up
sleep 1
docker run -d --name=ratdeos2 --log-opt max-size=1m --net=container:ratdeos2-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos3-net
docker stop ratdeos3
docker rm ratdeos3
ratdeos3pid=$(docker inspect --format '{{.State.Pid}}' ratdeos3-net)
sudo ln -sf /proc/${ratdeos3pid}/ns/net /var/run/netns/ratdeos3
sudo ip link set ratdeos3et1 netns ratdeos3 name et1 up
sudo ip link set ratdeos3et2 netns ratdeos3 name et2 up
sudo ip link set ratdeos3et3 netns ratdeos3 name et3 up
sudo ip link set ratdeos3et4 netns ratdeos3 name et4 up
sudo ip link set ratdeos3et5 netns ratdeos3 name et5 up
sudo ip link set ratdeos3et6 netns ratdeos3 name et6 up
sleep 1
docker run -d --name=ratdeos3 --log-opt max-size=1m --net=container:ratdeos3-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos3:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos4-net
docker stop ratdeos4
docker rm ratdeos4
ratdeos4pid=$(docker inspect --format '{{.State.Pid}}' ratdeos4-net)
sudo ln -sf /proc/${ratdeos4pid}/ns/net /var/run/netns/ratdeos4
sudo ip link set ratdeos4et1 netns ratdeos4 name et1 up
sudo ip link set ratdeos4et2 netns ratdeos4 name et2 up
sudo ip link set ratdeos4et3 netns ratdeos4 name et3 up
sudo ip link set ratdeos4et4 netns ratdeos4 name et4 up
sudo ip link set ratdeos4et5 netns ratdeos4 name et5 up
sudo ip link set ratdeos4et6 netns ratdeos4 name et6 up
sleep 1
docker run -d --name=ratdeos4 --log-opt max-size=1m --net=container:ratdeos4-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos4:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos5-net
docker stop ratdeos5
docker rm ratdeos5
ratdeos5pid=$(docker inspect --format '{{.State.Pid}}' ratdeos5-net)
sudo ln -sf /proc/${ratdeos5pid}/ns/net /var/run/netns/ratdeos5
sudo ip link set ratdeos5et1 netns ratdeos5 name et1 up
sudo ip link set ratdeos5et2 netns ratdeos5 name et2 up
sudo ip link set ratdeos5et3 netns ratdeos5 name et3 up
sudo ip link set ratdeos5et4 netns ratdeos5 name et4 up
sudo ip link set ratdeos5et5 netns ratdeos5 name et5 up
sleep 1
docker run -d --name=ratdeos5 --log-opt max-size=1m --net=container:ratdeos5-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos5:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos6-net
docker stop ratdeos6
docker rm ratdeos6
ratdeos6pid=$(docker inspect --format '{{.State.Pid}}' ratdeos6-net)
sudo ln -sf /proc/${ratdeos6pid}/ns/net /var/run/netns/ratdeos6
sudo ip link set ratdeos6et1 netns ratdeos6 name et1 up
sudo ip link set ratdeos6et2 netns ratdeos6 name et2 up
sudo ip link set ratdeos6et3 netns ratdeos6 name et3 up
sudo ip link set ratdeos6et4 netns ratdeos6 name et4 up
sudo ip link set ratdeos6et5 netns ratdeos6 name et5 up
sudo ip link set ratdeos6et6 netns ratdeos6 name et6 up
sleep 1
docker run -d --name=ratdeos6 --log-opt max-size=1m --net=container:ratdeos6-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos6:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos7-net
docker stop ratdeos7
docker rm ratdeos7
ratdeos7pid=$(docker inspect --format '{{.State.Pid}}' ratdeos7-net)
sudo ln -sf /proc/${ratdeos7pid}/ns/net /var/run/netns/ratdeos7
sudo ip link set ratdeos7et1 netns ratdeos7 name et1 up
sudo ip link set ratdeos7et2 netns ratdeos7 name et2 up
sudo ip link set ratdeos7et3 netns ratdeos7 name et3 up
sudo ip link set ratdeos7et4 netns ratdeos7 name et4 up
sleep 1
docker run -d --name=ratdeos7 --log-opt max-size=1m --net=container:ratdeos7-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos7:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos8-net
docker stop ratdeos8
docker rm ratdeos8
ratdeos8pid=$(docker inspect --format '{{.State.Pid}}' ratdeos8-net)
sudo ln -sf /proc/${ratdeos8pid}/ns/net /var/run/netns/ratdeos8
sudo ip link set ratdeos8et1 netns ratdeos8 name et1 up
sudo ip link set ratdeos8et2 netns ratdeos8 name et2 up
sudo ip link set ratdeos8et3 netns ratdeos8 name et3 up
sudo ip link set ratdeos8et4 netns ratdeos8 name et4 up
sudo ip link set ratdeos8et5 netns ratdeos8 name et5 up
sleep 1
docker run -d --name=ratdeos8 --log-opt max-size=1m --net=container:ratdeos8-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos8:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos9-net
docker stop ratdeos9
docker rm ratdeos9
ratdeos9pid=$(docker inspect --format '{{.State.Pid}}' ratdeos9-net)
sudo ln -sf /proc/${ratdeos9pid}/ns/net /var/run/netns/ratdeos9
sudo ip link set ratdeos9et1 netns ratdeos9 name et1 up
sudo ip link set ratdeos9et2 netns ratdeos9 name et2 up
sleep 1
docker run -d --name=ratdeos9 --log-opt max-size=1m --net=container:ratdeos9-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos9:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos10-net
docker stop ratdeos10
docker rm ratdeos10
ratdeos10pid=$(docker inspect --format '{{.State.Pid}}' ratdeos10-net)
sudo ln -sf /proc/${ratdeos10pid}/ns/net /var/run/netns/ratdeos10
sudo ip link set ratdeos10et1 netns ratdeos10 name et1 up
sleep 1
docker run -d --name=ratdeos10 --log-opt max-size=1m --net=container:ratdeos10-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos10:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos11-net
docker stop ratdeos11
docker rm ratdeos11
ratdeos11pid=$(docker inspect --format '{{.State.Pid}}' ratdeos11-net)
sudo ln -sf /proc/${ratdeos11pid}/ns/net /var/run/netns/ratdeos11
sudo ip link set ratdeos11et1 netns ratdeos11 name et1 up
sudo ip link set ratdeos11et2 netns ratdeos11 name et2 up
sudo ip link set ratdeos11et3 netns ratdeos11 name et3 up
sleep 1
docker run -d --name=ratdeos11 --log-opt max-size=1m --net=container:ratdeos11-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos11:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos12-net
docker stop ratdeos12
docker rm ratdeos12
ratdeos12pid=$(docker inspect --format '{{.State.Pid}}' ratdeos12-net)
sudo ln -sf /proc/${ratdeos12pid}/ns/net /var/run/netns/ratdeos12
sudo ip link set ratdeos12et1 netns ratdeos12 name et1 up
sudo ip link set ratdeos12et2 netns ratdeos12 name et2 up
sleep 1
docker run -d --name=ratdeos12 --log-opt max-size=1m --net=container:ratdeos12-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos12:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos13-net
docker stop ratdeos13
docker rm ratdeos13
ratdeos13pid=$(docker inspect --format '{{.State.Pid}}' ratdeos13-net)
sudo ln -sf /proc/${ratdeos13pid}/ns/net /var/run/netns/ratdeos13
sudo ip link set ratdeos13et1 netns ratdeos13 name et1 up
sudo ip link set ratdeos13et2 netns ratdeos13 name et2 up
sudo ip link set ratdeos13et3 netns ratdeos13 name et3 up
sleep 1
docker run -d --name=ratdeos13 --log-opt max-size=1m --net=container:ratdeos13-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos13:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos14-net
docker stop ratdeos14
docker rm ratdeos14
ratdeos14pid=$(docker inspect --format '{{.State.Pid}}' ratdeos14-net)
sudo ln -sf /proc/${ratdeos14pid}/ns/net /var/run/netns/ratdeos14
sudo ip link set ratdeos14et1 netns ratdeos14 name et1 up
sudo ip link set ratdeos14et2 netns ratdeos14 name et2 up
sleep 1
docker run -d --name=ratdeos14 --log-opt max-size=1m --net=container:ratdeos14-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos14:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos15-net
docker stop ratdeos15
docker rm ratdeos15
ratdeos15pid=$(docker inspect --format '{{.State.Pid}}' ratdeos15-net)
sudo ln -sf /proc/${ratdeos15pid}/ns/net /var/run/netns/ratdeos15
sudo ip link set ratdeos15et1 netns ratdeos15 name et1 up
sleep 1
docker run -d --name=ratdeos15 --log-opt max-size=1m --net=container:ratdeos15-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos15:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos16-net
docker stop ratdeos16
docker rm ratdeos16
ratdeos16pid=$(docker inspect --format '{{.State.Pid}}' ratdeos16-net)
sudo ln -sf /proc/${ratdeos16pid}/ns/net /var/run/netns/ratdeos16
sudo ip link set ratdeos16et1 netns ratdeos16 name et1 up
sleep 1
docker run -d --name=ratdeos16 --log-opt max-size=1m --net=container:ratdeos16-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos16:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos17-net
docker stop ratdeos17
docker rm ratdeos17
ratdeos17pid=$(docker inspect --format '{{.State.Pid}}' ratdeos17-net)
sudo ln -sf /proc/${ratdeos17pid}/ns/net /var/run/netns/ratdeos17
sudo ip link set ratdeos17et1 netns ratdeos17 name et1 up
sleep 1
docker run -d --name=ratdeos17 --log-opt max-size=1m --net=container:ratdeos17-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos17:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos18-net
docker stop ratdeos18
docker rm ratdeos18
ratdeos18pid=$(docker inspect --format '{{.State.Pid}}' ratdeos18-net)
sudo ln -sf /proc/${ratdeos18pid}/ns/net /var/run/netns/ratdeos18
sudo ip link set ratdeos18et1 netns ratdeos18 name et1 up
sleep 1
docker run -d --name=ratdeos18 --log-opt max-size=1m --net=container:ratdeos18-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos18:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos19-net
docker stop ratdeos19
docker rm ratdeos19
ratdeos19pid=$(docker inspect --format '{{.State.Pid}}' ratdeos19-net)
sudo ln -sf /proc/${ratdeos19pid}/ns/net /var/run/netns/ratdeos19
sudo ip link set ratdeos19et1 netns ratdeos19 name et1 up
sleep 1
docker run -d --name=ratdeos19 --log-opt max-size=1m --net=container:ratdeos19-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos19:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos20-net
docker stop ratdeos20
docker rm ratdeos20
ratdeos20pid=$(docker inspect --format '{{.State.Pid}}' ratdeos20-net)
sudo ln -sf /proc/${ratdeos20pid}/ns/net /var/run/netns/ratdeos20
sudo ip link set ratdeos20et1 netns ratdeos20 name et1 up
sleep 1
docker run -d --name=ratdeos20 --log-opt max-size=1m --net=container:ratdeos20-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos20:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.25.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
