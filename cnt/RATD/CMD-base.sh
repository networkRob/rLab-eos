#!/bin/bash
docker exec -it ratdeos1 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS1 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos1 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos2 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS2 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos2 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos3 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS3 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos3 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos4 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS4 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos4 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos5 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS5 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos5 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos6 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS6 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos6 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos7 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS7 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos7 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos8 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS8 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos8 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos9 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS9 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos9 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos10 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS10 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos10 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos11 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS11 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos11 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos12 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS12 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos12 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos13 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS13 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos13 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos14 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS14 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos14 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos15 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS15 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos15 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos16 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS16 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos16 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos17 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS17 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos17 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos18 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS18 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos18 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos19 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS19 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos19 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos20 Cli -p 15 -c "configure replace flash:/cfgs/BaseIPv4_EOS20 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos20 Cli -p 15 -c "write" > /dev/null 2>&1
