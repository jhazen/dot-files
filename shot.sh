#!/bin/bash

F=`date +'%F_%H%M%S_%N'`
import ~/vimwiki/screenshots/$F.png
# wiki format
#echo "[[File:$SHOTS_DIR/$F.png]]" | xclip
# markdown format
echo "![](./vimwiki/screenshots/$F.png)" | xclip
