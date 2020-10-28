#!/bin/bash
ip link delete atdspine1et1 type veth peer name atdspine2et1
ip link delete atdspine1et2 type veth peer name atdleaf1et2
ip link delete atdspine1et3 type veth peer name atdleaf2et2
ip link delete atdspine1et4 type veth peer name atdleaf3et2
ip link delete atdspine1et5 type veth peer name atdleaf4et2
ip link delete atdspine1et6 type veth peer name atdspine2et6
ip link delete atdspine2et2 type veth peer name atdleaf1et3
ip link delete atdspine2et3 type veth peer name atdleaf2et3
ip link delete atdspine2et4 type veth peer name atdleaf3et3
ip link delete atdspine2et5 type veth peer name atdleaf4et3
ip link delete atdleaf1et1 type veth peer name atdleaf2et1
ip link delete atdleaf1et4 type veth peer name atdhost1et1
ip link delete atdleaf1et5 type veth peer name atdhost1et3
ip link delete atdleaf1et6 type veth peer name atdleaf2et6
ip link delete atdleaf2et4 type veth peer name atdhost1et2
ip link delete atdleaf2et5 type veth peer name atdhost1et4
ip link delete atdleaf3et1 type veth peer name atdleaf4et1
ip link delete atdleaf3et4 type veth peer name atdhost2et1
ip link delete atdleaf3et5 type veth peer name atdhost2et3
ip link delete atdleaf3et6 type veth peer name atdleaf4et6
ip link delete atdleaf4et4 type veth peer name atdhost2et2
ip link delete atdleaf4et5 type veth peer name atdhost2et4
docker stop atdspine1
docker stop atdspine1-net
docker rm atdspine1
docker rm atdspine1-net
docker stop atdspine2
docker stop atdspine2-net
docker rm atdspine2
docker rm atdspine2-net
docker stop atdleaf1
docker stop atdleaf1-net
docker rm atdleaf1
docker rm atdleaf1-net
docker stop atdleaf2
docker stop atdleaf2-net
docker rm atdleaf2
docker rm atdleaf2-net
docker stop atdleaf3
docker stop atdleaf3-net
docker rm atdleaf3
docker rm atdleaf3-net
docker stop atdleaf4
docker stop atdleaf4-net
docker rm atdleaf4
docker rm atdleaf4-net
docker stop atdhost1
docker stop atdhost1-net
docker rm atdhost1
docker rm atdhost1-net
docker stop atdhost2
docker stop atdhost2-net
docker rm atdhost2
docker rm atdhost2-net
ip netns delete ATD
rm -rf /var/run/netns/atdspine1
rm -rf /var/run/netns/atdspine2
rm -rf /var/run/netns/atdleaf1
rm -rf /var/run/netns/atdleaf2
rm -rf /var/run/netns/atdleaf3
rm -rf /var/run/netns/atdleaf4
rm -rf /var/run/netns/atdhost1
rm -rf /var/run/netns/atdhost2
