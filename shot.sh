#!/bin/bash

. ~/.aliases

F=`date +'%F_%H%M%S_%N'`
import ~/vimwiki/screenshots/$F.png

#get shotval from $SHOTMAP
SHOTVAL=`cat $SHOTMAP`
# wiki format
#echo "[[File:$SHOTS_DIR/$F.png]]" | xclip
# markdown format
echo -ne "![](./vimwiki/screenshots/$F.png)\n*Figure $SHOTVAL - *" | xclip
shotmap_iterate
