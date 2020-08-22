#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <pause|next|prev>"
    exit 1
fi

if [ $1 = "pause" ]; then
        playerctl --player spotify play-pause
elif [ $1 = "next" ]; then
        playerctl --player spotify next
elif [ $1 = "prev" ]; then
        playerctl --player spotify previous
fi
