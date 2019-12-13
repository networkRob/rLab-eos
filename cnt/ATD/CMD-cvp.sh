#!/bin/bash
docker exec -it atdspine1 Cli -p 15 -c "configure replace flash:/cfgs/CVP-spine1 ignore-errors" > /dev/null 2>&1
docker exec -it atdspine2 Cli -p 15 -c "configure replace flash:/cfgs/CVP-spine2 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf1 Cli -p 15 -c "configure replace flash:/cfgs/CVP-leaf1 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf2 Cli -p 15 -c "configure replace flash:/cfgs/CVP-leaf2 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf3 Cli -p 15 -c "configure replace flash:/cfgs/CVP-leaf3 ignore-errors" > /dev/null 2>&1
docker exec -it atdleaf4 Cli -p 15 -c "configure replace flash:/cfgs/CVP-leaf4 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost1 Cli -p 15 -c "configure replace flash:/cfgs/CVP-host1 ignore-errors" > /dev/null 2>&1
docker exec -it atdhost2 Cli -p 15 -c "configure replace flash:/cfgs/CVP-host2 ignore-errors" > /dev/null 2>&1
