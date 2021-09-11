#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <full path to file> <filetype> <-b|-r|-br"
    echo "Example: $0 /home/jesse/Workspace/pokered/main.s asm -b"
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
    if [[ $3 = "-b" || $3 = "-br" ]]; then
        BLDCMD=`cat ~/.build.conf | grep $DIRPATH | cut -d ',' -f2`
        $BLDCMD
    fi
    if [[ $3 = "-r" || $3 = "-br" ]]; then
        RUNCMD=`cat ~/.build.conf | grep $DIRPATH | cut -d ',' -f3`
        $RUNCMD
    fi
else
    cd $DIRPATH
    WILLBRK=0
    while [ 1 ]; do
        if [ $2 = "asm" ]; then
            if [[ $3 = "-b" || $3 = "-br" ]]; then
                ls -l | grep -i make > /dev/null
                if [ $? -eq 0 ]; then
                    make
                    WILLBRK=1
                fi
            fi
            if [[ $3 = "-r" || $3 = "-br" ]]; then
                ROM=`ls -l *.gbc | grep -v debug | awk '{print $9}' | head -n 1`
                bgb64 $ROM &
                WILLBRK=1
            fi
        elif [ $2 = "c" ]; then
            if [[ $3 = "-b" || $3 = "-br" ]]; then
                ls | grep -i make > /dev/null
                if [ $? -eq 0 ]; then
                    make
                    WILLBRK=1
                else
                    ls -l | grep -i `basename $1` > /dev/null
                    if [ $? -eq 0 ]; then
                        BIN=`basename $1 | sed 's/\.c//g'`
                        gcc -o $BIN `basename $1`
                        WILLBRK=1
                    fi
                fi
            fi
            if [[ $3 = "-r" || $3 = "-br" ]]; then
                EXE=`echo $1 | sed 's/\.c//g'`
                chmod +x $EXE
                $EXE
                WILLBRK=1
            fi
        elif [ $2 = "sh" ]; then
            echo "No need to build."
            break
            WILLBRK=1
        elif [ $2 = "py" ]; then
            echo "No need to build."
            break
            WILLBRK=1
        fi
        if [[ `echo $(basename $PWD)` != "Workspace" ]]; then
            cd ..
        else
            WILLBRK=1
        fi
        if [ $WILLBRK = 1 ]; then
            break
        fi
    done
fi

