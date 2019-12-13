#!/bin/bash
docker exec -it atdspine1 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-spine1 ignore-errors" > /dev/null 2>&1
docker exec -it atdspine1 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdspine1 bash -c 'pkill -9 Sysdb'
docker exec -it atdspine2 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-spine2 ignore-errors" > /dev/null 2>&1
docker exec -it atdspine2 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdspine2 bash -c 'pkill -9 Sysdb'
docker exec -it atdleaf1 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-leaf1 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf1 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdleaf1 bash -c 'pkill -9 Sysdb'
docker exec -it atdleaf2 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-leaf2 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf2 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdleaf2 bash -c 'pkill -9 Sysdb'
docker exec -it atdleaf3 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-leaf3 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf3 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdleaf3 bash -c 'pkill -9 Sysdb'
docker exec -it atdleaf4 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-leaf4 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf4 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdleaf4 bash -c 'pkill -9 Sysdb'
docker exec -it atdhost1 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-host1 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost1 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdhost1 bash -c 'pkill -9 Sysdb'
docker exec -it atdhost2 Cli -p 15 -c "configure replace flash:/cfgs/VXLAN-host2 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost2 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it atdhost2 bash -c 'pkill -9 Sysdb'
