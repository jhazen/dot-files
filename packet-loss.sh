#!/bin/bash

while [ 1 ]; do
    PL=`ping -c 5 8.8.8.8 2> /dev/null | grep "packet loss" | sed 's/^.*received, //g' | sed 's/, time.*//g' | sed 's/.* errors, //g'`
    echo $PL > ~/.packet_loss
done
