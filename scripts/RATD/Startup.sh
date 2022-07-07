#!/bin/bash

sudo sh -c 'echo "fs.inotify.max_user_instances = 50000" > /etc/sysctl.d/99-zceos.conf'
sudo sysctl -w fs.inotify.max_user_instances=50000
sudo ip netns add RATD
sudo ip link add 04a3et1 type veth peer name 68adet5
sudo ip link add 04a3et2 type veth peer name a5a3et3
sudo ip link add 04a3et3 type veth peer name c82aet1
sudo ip link add 04a3et4 type veth peer name ff8eet4
sudo ip link add 04a3et5 type veth peer name 6e3fet4
sudo ip link add 04a3et6 type veth peer name 6fbfet1
sudo ip link add 68adet1 type veth peer name aa4aet3
sudo ip link add 68adet2 type veth peer name 31cfet4
sudo ip link add 68adet3 type veth peer name 6e3fet3
sudo ip link add 68adet4 type veth peer name ff8eet5
sudo ip link add aa4aet1 type veth peer name 2111et2
sudo ip link add aa4aet2 type veth peer name a5a3et1
sudo ip link add aa4aet4 type veth peer name 6e3fet2
sudo ip link add aa4aet5 type veth peer name 31cfet5
sudo ip link add aa4aet6 type veth peer name 7c47et1
sudo ip link add 31cfet1 type veth peer name 2111et1
sudo ip link add 31cfet2 type veth peer name 4952et1
sudo ip link add 31cfet3 type veth peer name 6e3fet1
sudo ip link add 31cfet6 type veth peer name 45c5et1
sudo ip link add 6e3fet6 type veth peer name ff8eet1
sudo ip link add ff8eet2 type veth peer name 4952et3
sudo ip link add ff8eet3 type veth peer name d3f1et1
sudo ip link add ff8eet6 type veth peer name f22aet2
sudo ip link add a5a3et2 type veth peer name b3f9et1
sudo ip link add a5a3et4 type veth peer name e430et1
sudo ip link add 4952et2 type veth peer name 3480et1
sudo ip link add 4952et4 type veth peer name f22aet1
sudo ip link add 4952et5 type veth peer name 4e83et1
sudo ip link add c82aet2 type veth peer name 7791et2
sudo ip link add c82aet3 type veth peer name d3f1et3
sudo ip link add 7791et1 type veth peer name d3f1et2
docker start ratdeos1-net
docker stop ratdeos1
docker rm ratdeos1
ratdeos1pid=$(docker inspect --format '{{.State.Pid}}' ratdeos1-net)
sudo ln -sf /proc/${ratdeos1pid}/ns/net /var/run/netns/ratdeos1
sudo ip link set 04a3et1 netns ratdeos1 name et1 up
sudo ip link set 04a3et2 netns ratdeos1 name et2 up
sudo ip link set 04a3et3 netns ratdeos1 name et3 up
sudo ip link set 04a3et4 netns ratdeos1 name et4 up
sudo ip link set 04a3et5 netns ratdeos1 name et5 up
sudo ip link set 04a3et6 netns ratdeos1 name et6 up
sudo ip link add ratdeos1-eth0 type veth peer name ratdeos1-mgmt
sudo ip link set ratdeos1-eth0 netns ratdeos1 name eth0 up
sudo ip netns exec ratdeos1 ip link set dev eth0 down
sudo ip netns exec ratdeos1 ip link set dev eth0 address 00:1c:73:d0:c6:01
sudo ip netns exec ratdeos1 ip link set dev eth0 up
sudo ip link set ratdeos1-mgmt up
sleep 1
docker run -d --name=ratdeos1 --log-opt max-size=1m --net=container:ratdeos1-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos1:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos2-net
docker stop ratdeos2
docker rm ratdeos2
ratdeos2pid=$(docker inspect --format '{{.State.Pid}}' ratdeos2-net)
sudo ln -sf /proc/${ratdeos2pid}/ns/net /var/run/netns/ratdeos2
sudo ip link set 68adet5 netns ratdeos2 name et5 up
sudo ip link set 68adet1 netns ratdeos2 name et1 up
sudo ip link set 68adet2 netns ratdeos2 name et2 up
sudo ip link set 68adet3 netns ratdeos2 name et3 up
sudo ip link set 68adet4 netns ratdeos2 name et4 up
sudo ip link add ratdeos2-eth0 type veth peer name ratdeos2-mgmt
sudo ip link set ratdeos2-eth0 netns ratdeos2 name eth0 up
sudo ip netns exec ratdeos2 ip link set dev eth0 down
sudo ip netns exec ratdeos2 ip link set dev eth0 address 00:1c:73:d1:c6:01
sudo ip netns exec ratdeos2 ip link set dev eth0 up
sudo ip link set ratdeos2-mgmt up
sleep 1
docker run -d --name=ratdeos2 --log-opt max-size=1m --net=container:ratdeos2-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos2:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos3-net
docker stop ratdeos3
docker rm ratdeos3
ratdeos3pid=$(docker inspect --format '{{.State.Pid}}' ratdeos3-net)
sudo ln -sf /proc/${ratdeos3pid}/ns/net /var/run/netns/ratdeos3
sudo ip link set aa4aet3 netns ratdeos3 name et3 up
sudo ip link set aa4aet1 netns ratdeos3 name et1 up
sudo ip link set aa4aet2 netns ratdeos3 name et2 up
sudo ip link set aa4aet4 netns ratdeos3 name et4 up
sudo ip link set aa4aet5 netns ratdeos3 name et5 up
sudo ip link set aa4aet6 netns ratdeos3 name et6 up
sudo ip link add ratdeos3-eth0 type veth peer name ratdeos3-mgmt
sudo ip link set ratdeos3-eth0 netns ratdeos3 name eth0 up
sudo ip netns exec ratdeos3 ip link set dev eth0 down
sudo ip netns exec ratdeos3 ip link set dev eth0 address 00:1c:73:d2:c6:01
sudo ip netns exec ratdeos3 ip link set dev eth0 up
sudo ip link set ratdeos3-mgmt up
sleep 1
docker run -d --name=ratdeos3 --log-opt max-size=1m --net=container:ratdeos3-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos3:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos4-net
docker stop ratdeos4
docker rm ratdeos4
ratdeos4pid=$(docker inspect --format '{{.State.Pid}}' ratdeos4-net)
sudo ln -sf /proc/${ratdeos4pid}/ns/net /var/run/netns/ratdeos4
sudo ip link set 31cfet4 netns ratdeos4 name et4 up
sudo ip link set 31cfet5 netns ratdeos4 name et5 up
sudo ip link set 31cfet1 netns ratdeos4 name et1 up
sudo ip link set 31cfet2 netns ratdeos4 name et2 up
sudo ip link set 31cfet3 netns ratdeos4 name et3 up
sudo ip link set 31cfet6 netns ratdeos4 name et6 up
sudo ip link add ratdeos4-eth0 type veth peer name ratdeos4-mgmt
sudo ip link set ratdeos4-eth0 netns ratdeos4 name eth0 up
sudo ip netns exec ratdeos4 ip link set dev eth0 down
sudo ip netns exec ratdeos4 ip link set dev eth0 address 00:1c:73:d3:c6:01
sudo ip netns exec ratdeos4 ip link set dev eth0 up
sudo ip link set ratdeos4-mgmt up
sleep 1
docker run -d --name=ratdeos4 --log-opt max-size=1m --net=container:ratdeos4-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos4:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos5-net
docker stop ratdeos5
docker rm ratdeos5
ratdeos5pid=$(docker inspect --format '{{.State.Pid}}' ratdeos5-net)
sudo ln -sf /proc/${ratdeos5pid}/ns/net /var/run/netns/ratdeos5
sudo ip link set 6e3fet4 netns ratdeos5 name et4 up
sudo ip link set 6e3fet3 netns ratdeos5 name et3 up
sudo ip link set 6e3fet2 netns ratdeos5 name et2 up
sudo ip link set 6e3fet1 netns ratdeos5 name et1 up
sudo ip link set 6e3fet6 netns ratdeos5 name et6 up
sudo ip link add ratdeos5-eth0 type veth peer name ratdeos5-mgmt
sudo ip link set ratdeos5-eth0 netns ratdeos5 name eth0 up
sudo ip netns exec ratdeos5 ip link set dev eth0 down
sudo ip netns exec ratdeos5 ip link set dev eth0 address 00:1c:73:d4:c6:01
sudo ip netns exec ratdeos5 ip link set dev eth0 up
sudo ip link set ratdeos5-mgmt up
sleep 1
docker run -d --name=ratdeos5 --log-opt max-size=1m --net=container:ratdeos5-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos5:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos6-net
docker stop ratdeos6
docker rm ratdeos6
ratdeos6pid=$(docker inspect --format '{{.State.Pid}}' ratdeos6-net)
sudo ln -sf /proc/${ratdeos6pid}/ns/net /var/run/netns/ratdeos6
sudo ip link set ff8eet4 netns ratdeos6 name et4 up
sudo ip link set ff8eet5 netns ratdeos6 name et5 up
sudo ip link set ff8eet1 netns ratdeos6 name et1 up
sudo ip link set ff8eet2 netns ratdeos6 name et2 up
sudo ip link set ff8eet3 netns ratdeos6 name et3 up
sudo ip link set ff8eet6 netns ratdeos6 name et6 up
sudo ip link add ratdeos6-eth0 type veth peer name ratdeos6-mgmt
sudo ip link set ratdeos6-eth0 netns ratdeos6 name eth0 up
sudo ip netns exec ratdeos6 ip link set dev eth0 down
sudo ip netns exec ratdeos6 ip link set dev eth0 address 00:1c:73:d5:c6:01
sudo ip netns exec ratdeos6 ip link set dev eth0 up
sudo ip link set ratdeos6-mgmt up
sleep 1
docker run -d --name=ratdeos6 --log-opt max-size=1m --net=container:ratdeos6-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos6:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos7-net
docker stop ratdeos7
docker rm ratdeos7
ratdeos7pid=$(docker inspect --format '{{.State.Pid}}' ratdeos7-net)
sudo ln -sf /proc/${ratdeos7pid}/ns/net /var/run/netns/ratdeos7
sudo ip link set a5a3et3 netns ratdeos7 name et3 up
sudo ip link set a5a3et1 netns ratdeos7 name et1 up
sudo ip link set a5a3et2 netns ratdeos7 name et2 up
sudo ip link set a5a3et4 netns ratdeos7 name et4 up
sudo ip link add ratdeos7-eth0 type veth peer name ratdeos7-mgmt
sudo ip link set ratdeos7-eth0 netns ratdeos7 name eth0 up
sudo ip netns exec ratdeos7 ip link set dev eth0 down
sudo ip netns exec ratdeos7 ip link set dev eth0 address 00:1c:73:d6:c6:01
sudo ip netns exec ratdeos7 ip link set dev eth0 up
sudo ip link set ratdeos7-mgmt up
sleep 1
docker run -d --name=ratdeos7 --log-opt max-size=1m --net=container:ratdeos7-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos7:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos8-net
docker stop ratdeos8
docker rm ratdeos8
ratdeos8pid=$(docker inspect --format '{{.State.Pid}}' ratdeos8-net)
sudo ln -sf /proc/${ratdeos8pid}/ns/net /var/run/netns/ratdeos8
sudo ip link set 4952et1 netns ratdeos8 name et1 up
sudo ip link set 4952et3 netns ratdeos8 name et3 up
sudo ip link set 4952et2 netns ratdeos8 name et2 up
sudo ip link set 4952et4 netns ratdeos8 name et4 up
sudo ip link set 4952et5 netns ratdeos8 name et5 up
sudo ip link add ratdeos8-eth0 type veth peer name ratdeos8-mgmt
sudo ip link set ratdeos8-eth0 netns ratdeos8 name eth0 up
sudo ip netns exec ratdeos8 ip link set dev eth0 down
sudo ip netns exec ratdeos8 ip link set dev eth0 address 00:1c:73:d7:c6:01
sudo ip netns exec ratdeos8 ip link set dev eth0 up
sudo ip link set ratdeos8-mgmt up
sleep 1
docker run -d --name=ratdeos8 --log-opt max-size=1m --net=container:ratdeos8-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos8:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos9-net
docker stop ratdeos9
docker rm ratdeos9
ratdeos9pid=$(docker inspect --format '{{.State.Pid}}' ratdeos9-net)
sudo ln -sf /proc/${ratdeos9pid}/ns/net /var/run/netns/ratdeos9
sudo ip link set 2111et2 netns ratdeos9 name et2 up
sudo ip link set 2111et1 netns ratdeos9 name et1 up
sudo ip link add ratdeos9-eth0 type veth peer name ratdeos9-mgmt
sudo ip link set ratdeos9-eth0 netns ratdeos9 name eth0 up
sudo ip netns exec ratdeos9 ip link set dev eth0 down
sudo ip netns exec ratdeos9 ip link set dev eth0 address 00:1c:73:d8:c6:01
sudo ip netns exec ratdeos9 ip link set dev eth0 up
sudo ip link set ratdeos9-mgmt up
sleep 1
docker run -d --name=ratdeos9 --log-opt max-size=1m --net=container:ratdeos9-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos9:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos10-net
docker stop ratdeos10
docker rm ratdeos10
ratdeos10pid=$(docker inspect --format '{{.State.Pid}}' ratdeos10-net)
sudo ln -sf /proc/${ratdeos10pid}/ns/net /var/run/netns/ratdeos10
sudo ip link set b3f9et1 netns ratdeos10 name et1 up
sudo ip link add ratdeos10-eth0 type veth peer name ratdeos10-mgmt
sudo ip link set ratdeos10-eth0 netns ratdeos10 name eth0 up
sudo ip netns exec ratdeos10 ip link set dev eth0 down
sudo ip netns exec ratdeos10 ip link set dev eth0 address 00:1c:73:d9:c6:01
sudo ip netns exec ratdeos10 ip link set dev eth0 up
sudo ip link set ratdeos10-mgmt up
sleep 1
docker run -d --name=ratdeos10 --log-opt max-size=1m --net=container:ratdeos10-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos10:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos11-net
docker stop ratdeos11
docker rm ratdeos11
ratdeos11pid=$(docker inspect --format '{{.State.Pid}}' ratdeos11-net)
sudo ln -sf /proc/${ratdeos11pid}/ns/net /var/run/netns/ratdeos11
sudo ip link set c82aet1 netns ratdeos11 name et1 up
sudo ip link set c82aet2 netns ratdeos11 name et2 up
sudo ip link set c82aet3 netns ratdeos11 name et3 up
sudo ip link add ratdeos11-eth0 type veth peer name ratdeos11-mgmt
sudo ip link set ratdeos11-eth0 netns ratdeos11 name eth0 up
sudo ip netns exec ratdeos11 ip link set dev eth0 down
sudo ip netns exec ratdeos11 ip link set dev eth0 address 00:1c:73:e0:c6:01
sudo ip netns exec ratdeos11 ip link set dev eth0 up
sudo ip link set ratdeos11-mgmt up
sleep 1
docker run -d --name=ratdeos11 --log-opt max-size=1m --net=container:ratdeos11-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos11:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos12-net
docker stop ratdeos12
docker rm ratdeos12
ratdeos12pid=$(docker inspect --format '{{.State.Pid}}' ratdeos12-net)
sudo ln -sf /proc/${ratdeos12pid}/ns/net /var/run/netns/ratdeos12
sudo ip link set 7791et2 netns ratdeos12 name et2 up
sudo ip link set 7791et1 netns ratdeos12 name et1 up
sudo ip link add ratdeos12-eth0 type veth peer name ratdeos12-mgmt
sudo ip link set ratdeos12-eth0 netns ratdeos12 name eth0 up
sudo ip netns exec ratdeos12 ip link set dev eth0 down
sudo ip netns exec ratdeos12 ip link set dev eth0 address 00:1c:73:e1:c6:01
sudo ip netns exec ratdeos12 ip link set dev eth0 up
sudo ip link set ratdeos12-mgmt up
sleep 1
docker run -d --name=ratdeos12 --log-opt max-size=1m --net=container:ratdeos12-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos12:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos13-net
docker stop ratdeos13
docker rm ratdeos13
ratdeos13pid=$(docker inspect --format '{{.State.Pid}}' ratdeos13-net)
sudo ln -sf /proc/${ratdeos13pid}/ns/net /var/run/netns/ratdeos13
sudo ip link set d3f1et1 netns ratdeos13 name et1 up
sudo ip link set d3f1et3 netns ratdeos13 name et3 up
sudo ip link set d3f1et2 netns ratdeos13 name et2 up
sudo ip link add ratdeos13-eth0 type veth peer name ratdeos13-mgmt
sudo ip link set ratdeos13-eth0 netns ratdeos13 name eth0 up
sudo ip netns exec ratdeos13 ip link set dev eth0 down
sudo ip netns exec ratdeos13 ip link set dev eth0 address 00:1c:73:e2:c6:01
sudo ip netns exec ratdeos13 ip link set dev eth0 up
sudo ip link set ratdeos13-mgmt up
sleep 1
docker run -d --name=ratdeos13 --log-opt max-size=1m --net=container:ratdeos13-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos13:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos14-net
docker stop ratdeos14
docker rm ratdeos14
ratdeos14pid=$(docker inspect --format '{{.State.Pid}}' ratdeos14-net)
sudo ln -sf /proc/${ratdeos14pid}/ns/net /var/run/netns/ratdeos14
sudo ip link set f22aet2 netns ratdeos14 name et2 up
sudo ip link set f22aet1 netns ratdeos14 name et1 up
sudo ip link add ratdeos14-eth0 type veth peer name ratdeos14-mgmt
sudo ip link set ratdeos14-eth0 netns ratdeos14 name eth0 up
sudo ip netns exec ratdeos14 ip link set dev eth0 down
sudo ip netns exec ratdeos14 ip link set dev eth0 address 00:1c:73:e3:c6:01
sudo ip netns exec ratdeos14 ip link set dev eth0 up
sudo ip link set ratdeos14-mgmt up
sleep 1
docker run -d --name=ratdeos14 --log-opt max-size=1m --net=container:ratdeos14-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos14:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos15-net
docker stop ratdeos15
docker rm ratdeos15
ratdeos15pid=$(docker inspect --format '{{.State.Pid}}' ratdeos15-net)
sudo ln -sf /proc/${ratdeos15pid}/ns/net /var/run/netns/ratdeos15
sudo ip link set 3480et1 netns ratdeos15 name et1 up
sudo ip link add ratdeos15-eth0 type veth peer name ratdeos15-mgmt
sudo ip link set ratdeos15-eth0 netns ratdeos15 name eth0 up
sudo ip netns exec ratdeos15 ip link set dev eth0 down
sudo ip netns exec ratdeos15 ip link set dev eth0 address 00:1c:73:e4:c6:01
sudo ip netns exec ratdeos15 ip link set dev eth0 up
sudo ip link set ratdeos15-mgmt up
sleep 1
docker run -d --name=ratdeos15 --log-opt max-size=1m --net=container:ratdeos15-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos15:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos16-net
docker stop ratdeos16
docker rm ratdeos16
ratdeos16pid=$(docker inspect --format '{{.State.Pid}}' ratdeos16-net)
sudo ln -sf /proc/${ratdeos16pid}/ns/net /var/run/netns/ratdeos16
sudo ip link set 45c5et1 netns ratdeos16 name et1 up
sudo ip link add ratdeos16-eth0 type veth peer name ratdeos16-mgmt
sudo ip link set ratdeos16-eth0 netns ratdeos16 name eth0 up
sudo ip netns exec ratdeos16 ip link set dev eth0 down
sudo ip netns exec ratdeos16 ip link set dev eth0 address 00:1c:73:d5:c6:01
sudo ip netns exec ratdeos16 ip link set dev eth0 up
sudo ip link set ratdeos16-mgmt up
sleep 1
docker run -d --name=ratdeos16 --log-opt max-size=1m --net=container:ratdeos16-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos16:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos17-net
docker stop ratdeos17
docker rm ratdeos17
ratdeos17pid=$(docker inspect --format '{{.State.Pid}}' ratdeos17-net)
sudo ln -sf /proc/${ratdeos17pid}/ns/net /var/run/netns/ratdeos17
sudo ip link set 6fbfet1 netns ratdeos17 name et1 up
sudo ip link add ratdeos17-eth0 type veth peer name ratdeos17-mgmt
sudo ip link set ratdeos17-eth0 netns ratdeos17 name eth0 up
sudo ip netns exec ratdeos17 ip link set dev eth0 down
sudo ip netns exec ratdeos17 ip link set dev eth0 address 00:1c:73:e6:c6:01
sudo ip netns exec ratdeos17 ip link set dev eth0 up
sudo ip link set ratdeos17-mgmt up
sleep 1
docker run -d --name=ratdeos17 --log-opt max-size=1m --net=container:ratdeos17-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos17:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos18-net
docker stop ratdeos18
docker rm ratdeos18
ratdeos18pid=$(docker inspect --format '{{.State.Pid}}' ratdeos18-net)
sudo ln -sf /proc/${ratdeos18pid}/ns/net /var/run/netns/ratdeos18
sudo ip link set 4e83et1 netns ratdeos18 name et1 up
sudo ip link add ratdeos18-eth0 type veth peer name ratdeos18-mgmt
sudo ip link set ratdeos18-eth0 netns ratdeos18 name eth0 up
sudo ip netns exec ratdeos18 ip link set dev eth0 down
sudo ip netns exec ratdeos18 ip link set dev eth0 address 00:1c:73:e7:c6:01
sudo ip netns exec ratdeos18 ip link set dev eth0 up
sudo ip link set ratdeos18-mgmt up
sleep 1
docker run -d --name=ratdeos18 --log-opt max-size=1m --net=container:ratdeos18-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos18:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos19-net
docker stop ratdeos19
docker rm ratdeos19
ratdeos19pid=$(docker inspect --format '{{.State.Pid}}' ratdeos19-net)
sudo ln -sf /proc/${ratdeos19pid}/ns/net /var/run/netns/ratdeos19
sudo ip link set e430et1 netns ratdeos19 name et1 up
sudo ip link add ratdeos19-eth0 type veth peer name ratdeos19-mgmt
sudo ip link set ratdeos19-eth0 netns ratdeos19 name eth0 up
sudo ip netns exec ratdeos19 ip link set dev eth0 down
sudo ip netns exec ratdeos19 ip link set dev eth0 address 00:1c:73:e8:c6:01
sudo ip netns exec ratdeos19 ip link set dev eth0 up
sudo ip link set ratdeos19-mgmt up
sleep 1
docker run -d --name=ratdeos19 --log-opt max-size=1m --net=container:ratdeos19-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos19:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker start ratdeos20-net
docker stop ratdeos20
docker rm ratdeos20
ratdeos20pid=$(docker inspect --format '{{.State.Pid}}' ratdeos20-net)
sudo ln -sf /proc/${ratdeos20pid}/ns/net /var/run/netns/ratdeos20
sudo ip link set 7c47et1 netns ratdeos20 name et1 up
sudo ip link add ratdeos20-eth0 type veth peer name ratdeos20-mgmt
sudo ip link set ratdeos20-eth0 netns ratdeos20 name eth0 up
sudo ip netns exec ratdeos20 ip link set dev eth0 down
sudo ip netns exec ratdeos20 ip link set dev eth0 address 00:1c:73:e9:c6:01
sudo ip netns exec ratdeos20 ip link set dev eth0 up
sudo ip link set ratdeos20-mgmt up
sleep 1
docker run -d --name=ratdeos20 --log-opt max-size=1m --net=container:ratdeos20-net --privileged -v /etc/sysctl.d/99-zceos.conf:/etc/sysctl.d/99-zceos.conf:ro -v /workspaces/rLab-eos/configs/RATD/eos20:/mnt/flash:Z -e INTFTYPE=et -e MGMT_INTF=eth0 -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage:4.28.0F /sbin/init systemd.setenv=INTFTYPE=et systemd.setenv=MGMT_INTF=eth0 systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
