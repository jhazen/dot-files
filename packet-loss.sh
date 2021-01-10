#!/bin/bash

if [ ! -f /tmp/packet_loss ]; then
    echo "%0 packet loss" > /tmp/packet_loss
fi

while [ 1 ]; do
    PL=`ping -c 5 8.8.8.8 2> /dev/null | grep "packet loss" | sed 's/^.*received, //g' | sed 's/, time.*//g' | sed 's/.* errors, //g'`
    echo $PL > /tmp/packet_loss
done
