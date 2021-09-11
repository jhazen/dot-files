#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <full path to file> <filetype>"
    echo "Example: $0 /home/jesse/Workspace/pokered/main.s asm"
    exit 1
fi

cd ~/Workspace

DIRPATH=`dirname $1 | sed 's/^.*Workspace\///g'`

if [ $2 = "md" ]; then
    source ~/.aliases; pandoc_wiki $1
    exit 0
fi

cat ~/.build.conf | grep $DIRPATH > /dev/null
if [[ $? -eq 0 ]]; then
    BLDCMD=`cat ~/.build.conf | grep $DIRPATH | cut -d ',' -f2`
    $BLDCMD
else
    cd $DIRPATH
    while [ 1 ]; do
        if [ $2 = "asm" ]; then
            ls | grep -i make > /dev/null
            if [ $? -eq 0 ]; then
                make
                ROM=`ls -l *.gbc | grep -v debug | awk '{print $9}' | head -n 1`
                bgb64 $ROM
                break
            fi
        elif [ $2 = "c" ]; then
            ls | grep -i make > /dev/null
            if [ $? -eq 0 ]; then
                make
                break
            fi
        elif [ $2 = "sh" ]; then
            echo "No need to build."
            break
        elif [ $2 = "py" ]; then
            echo "No need to build."
            break
        fi
        if [[ `echo $(basename $PWD)` != "Workspace" ]]; then
            cd ..
        else
            break
        fi
    done
fi

