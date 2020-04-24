#!/bin/bash

if [ -z ${SHOTS_DIR+x} ]; then
    SHOTS_DIR=~/vimwiki/screenshots
fi

cd $SHOTS_DIR &> /dev/null
F=`date +'%F_%k%M%S_%N'`
import $F.png
echo "[[File:$SHOTS_DIR/$F.png]]" | xclip
cd - &> /dev/null
