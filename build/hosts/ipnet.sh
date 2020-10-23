#!/bin/bash

ifconfig eth0 $HOST_IP netmask $HOST_MASK

route add default gw $HOST_GW eth0

tail -f /dev/null
