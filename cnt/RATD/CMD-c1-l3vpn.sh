#!/bin/bash
docker exec -it ratdeos1 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS1 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos1 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos2 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS2 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos2 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos3 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS3 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos3 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos4 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS4 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos4 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos5 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS5 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos5 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos6 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS6 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos6 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos7 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS7 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos7 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos8 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS8 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos8 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos9 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS9 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos9 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos10 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS10 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos10 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos11 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS11 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos11 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos12 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS12 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos12 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos13 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS13 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos13 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos14 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS14 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos14 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos15 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS15 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos15 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos16 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS16 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos16 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos17 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS17 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos17 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos18 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS18 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos18 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos19 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS19 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos19 Cli -p 15 -c "write" > /dev/null 2>&1
docker exec -it ratdeos20 Cli -p 15 -c "configure replace flash:/cfgs/C1_L3VPN_EOS20 ignore-errors" > /dev/null 2>&1
docker exec -it ratdeos20 Cli -p 15 -c "write" > /dev/null 2>&1
