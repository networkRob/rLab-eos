#!/bin/bash
docker exec -it atdspine1 Cli -p 15 -c "configure replace flash:/cfgs/BASE-spine1 ignore-errors" > /dev/null 2>&1
docker exec -it atdspine2 Cli -p 15 -c "configure replace flash:/cfgs/BASE-spine2 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf1 Cli -p 15 -c "configure replace flash:/cfgs/BASE-leaf1 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf2 Cli -p 15 -c "configure replace flash:/cfgs/BASE-leaf2 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf3 Cli -p 15 -c "configure replace flash:/cfgs/BASE-leaf3 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf4 Cli -p 15 -c "configure replace flash:/cfgs/BASE-leaf4 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost1 Cli -p 15 -c "configure replace flash:/cfgs/BASE-host1 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost2 Cli -p 15 -c "configure replace flash:/cfgs/BASE-host2 ignore-errors" > /dev/null 2>&1
