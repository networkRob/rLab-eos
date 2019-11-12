#!/bin/bash
mkdir -p logs/RATD
docker exec -it ratdeos1 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS1 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos2 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS2 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos3 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS3 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos4 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS4 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos5 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS5 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos6 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS6 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos7 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS7 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos8 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS8 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos9 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS9 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos10 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS10 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos11 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS11 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos12 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS12 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos13 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS13 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos14 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS14 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos15 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS15 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos16 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS16 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos17 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS17 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos18 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS18 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos19 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS19 ignore-errors" >> logs/ratd/centsvc.log
docker exec -it ratdeos20 Cli -p 15 -c "configure replace flash:/CENTSVC_EOS20 ignore-errors" >> logs/ratd/centsvc.log
