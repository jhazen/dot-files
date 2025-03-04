#!/bin/bash

. ~/.aliases

F=`date +'%F_%H%M%S_%N'`
import ~/vimwiki/screenshots/$F.png

# wiki format
#echo "[[File:$SHOTS_DIR/$F.png]]" | xclip
# markdown format
#echo -ne "![](./vimwiki/screenshots/$F.png)\n*Figure  - *" | xclip -selection clipboard
echo -ne "![](/data/screenshots/$F.png)\n*Figure  - *" | xclip -selection clipboard
