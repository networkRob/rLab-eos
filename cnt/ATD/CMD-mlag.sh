#!/bin/bash
docker exec -it atdspine1 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-spine1 ignore-errors" > /dev/null 2>&1
docker exec -it atdspine2 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-spine2 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf1 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-leaf1 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf2 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-leaf2 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf3 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-leaf3 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf4 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-leaf4 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost1 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-host1 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost2 Cli -p 15 -c "configure replace flash:/cfgs/MLAG-host2 ignore-errors" > /dev/null 2>&1
