#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <full path to file> <filetype> <-b|-r|-br"
    echo "Example: $0 /home/jesse/Workspace/pokered/main.s asm -b"
    exit 1
fi

cd ~/Workspace

DIRPATH=`dirname $1 | sed 's/^.*Workspace\///g'`
DIRPATH_ORIG=$DIRPATH

if [ $2 = "md" ]; then
    source ~/.aliases; pandoc_wiki $1
    exit 0
fi

cat ~/.build.conf | grep $DIRPATH > /dev/null
if [[ $? -eq 0 ]]; then
    if [[ $3 = "-b" || $3 = "-br" ]]; then
        BLDCMD=`cat ~/.build.conf | grep $DIRPATH | cut -d ',' -f2`
        echo $BLDCMD
        `$BLDCMD`
    fi
    if [[ $3 = "-r" || $3 = "-br" ]]; then
        RUNCMD=`cat ~/.build.conf | grep $DIRPATH | cut -d ',' -f3`
        echo $RUNCMD
        `$RUNCMD`
    fi
else
    echo $DIRPATH
    cd $DIRPATH
    WILLBRK=0
    while [ 1 ]; do
        if [ $2 = "asm" ]; then
            if [[ $3 = "-b" || $3 = "-br" ]]; then
                ls -l | grep -i make > /dev/null
                if [ $? -eq 0 ]; then
                    make
                    WILLBRK=1
                elif [ -f "assemble.sh" ]; then
                    bash assemble.sh
                elif [ -f "build.sh" ]; then
                    bash build.sh
                elif [ -f "make.sh" ]; then
                    bash make.sh
                fi
            fi
            if [[ $3 = "-r" || $3 = "-br" ]]; then
                cd - &> /dev/null
                echo "Trying GB first..."
                while [ 1 ]; do
                    echo $DIRPATH
                    ROM=`find $DIRPATH -type f -name "*.gb*" -not -name "debug"`
                    if [[ $ROM = "" ]]; then
                        DIRPATH=`dirname $DIRPATH`
                        if [[ $DIRPATH = "." ]]; then
                            echo "Couldnt find ROM. Trying SNES..."
                            break
                        fi
                    else
                        FOUND=1
                        break
                    fi
                done
                DIRPATH=$DIRPATH_ORIG
                while [ 1 ]; do
                    if [[ $FOUND -eq 1 ]]; then
                        break
                    fi
                    echo $DIRPATH
                    ROM=`find $DIRPATH -type f -name "*.sfc*" -not -name "debug"`
                    if [[ $ROM = "" ]]; then
                        DIRPATH=`dirname $DIRPATH`
                        if [[ $DIRPATH = "." ]]; then
                            echo "Couldnt find ROM. Trying NES..."
                            break
                        fi
                    else
                        FOUND=1
                        break
                    fi
                done
                DIRPATH=$DIRPATH_ORIG
                while [ 1 ]; do
                    if [[ $FOUND -eq 1 ]]; then
                        break
                    fi
                    echo $DIRPATH
                    ROM=`find $DIRPATH -type f -name "*.nes" -not -name "debug"`
                    if [[ $ROM = "" ]]; then
                        DIRPATH=`dirname $DIRPATH`
                        if [[ $DIRPATH = "." ]]; then
                            echo "Couldnt find ROM"
                            exit 1
                        fi
                    else
                        break
                    fi
                done
                echo $ROM
                if [[ `echo $ROM | grep "gb"` ]]; then
                    bgb64 $ROM &
                elif [[ `echo $ROM | grep sfc` ]]; then
                    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=bsnes dev.bsnes.bsnes $ROM &
                elif [[ `echo $ROM | grep nes` ]]; then
                    mesen $ROM &
                else
                    echo "No ROM"
                fi
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

