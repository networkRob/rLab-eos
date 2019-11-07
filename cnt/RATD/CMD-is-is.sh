#!/bin/bash
docker exec -it ratdeos1 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos1)/cfgs/IS-IS_EOS1)"
docker exec -it ratdeos2 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos2)/cfgs/IS-IS_EOS2)"
docker exec -it ratdeos3 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos3)/cfgs/IS-IS_EOS3)"
docker exec -it ratdeos4 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos4)/cfgs/IS-IS_EOS4)"
docker exec -it ratdeos5 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos5)/cfgs/IS-IS_EOS5)"
docker exec -it ratdeos6 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos6)/cfgs/IS-IS_EOS6)"
docker exec -it ratdeos7 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos7)/cfgs/IS-IS_EOS7)"
docker exec -it ratdeos8 Cli -c "$(sudo cat $(docker volume inspect --format '{{ .Mountpoint }}' ratdeos8)/cfgs/IS-IS_EOS8)"
