#!/bin/bash

echo "PS1=\"\u@$HOSTNAME# \"" >> ~/.bashrc

ifconfig et0 $HOST_IP netmask $HOST_MASK

route add default gw $HOST_GW et0

tail -f /dev/null
