#!/bin/bash

while true;
do
iperf3 -c $1 -p $2 -b $3 ;
done
