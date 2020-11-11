#!/bin/bash

echo "PS1=\"\u@$HOSTNAME# \"" >> ~/.bashrc

hostname -b $HOSTNAME

ifconfig et0 $HOST_IP netmask $HOST_MASK

route add default gw $HOST_GW et0

echo "Starting lldp service"
lldpad -d 

for i in `ls /sys/class/net/ | grep et` ;
      do echo "enabling lldp for interface: $i" ;
      lldptool set-lldp -i $i adminStatus=rxtx  ;
      lldptool -T -i $i -V  sysName enableTx=yes;
      lldptool -T -i $i -V  portDesc enableTx=yes ;
      lldptool -T -i $i -V  sysDesc enableTx=yes;
      lldptool -T -i $i -V sysCap enableTx=yes;
      lldptool -T -i $i -V mngAddr enableTx=yes;
done
tail -f /dev/null
