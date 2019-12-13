#!/bin/bash
docker exec -it ratdspine1 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_SPINE1 ignore-errors" > /dev/null 2>&1
docker exec -it ratdspine2 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_SPINE2 ignore-errors" > /dev/null 2>&1
docker exec -it ratdleaf1 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_LEAF1 ignore-errors" > /dev/null 2>&1
docker exec -it ratdleaf2 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_LEAF2 ignore-errors" > /dev/null 2>&1
docker exec -it ratdleaf3 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_LEAF3 ignore-errors" > /dev/null 2>&1
docker exec -it ratdleaf4 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_LEAF4 ignore-errors" > /dev/null 2>&1
docker exec -it ratdhost1 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_HOST1 ignore-errors" > /dev/null 2>&1
docker exec -it ratdhost2 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN_HOST2 ignore-errors" > /dev/null 2>&1
