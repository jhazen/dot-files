#!/bin/bash

BIN="$HOME/.bin"

function printhelp() {
    echo "Compile/build/assemble and run file from vim."
    echo "Usage $0 <filetype> <filename>"
    echo
    echo "Example: $0 asm64 test.asm"
    exit 1
}

function shfile() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g'`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    cp $ORIG $BIN/
    chmod +x $BIN/$FILE
    time $BIN/$FILE
}

function pyfile() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g'`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    cp $ORIG $BIN/
    chmod +x $BIN/$FILE
    time python3 $BIN/$FILE
}

function gofile() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g'`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    cp $ORIG $BIN/
    chmod +x $BIN/$FILE
    time go run $BIN/$FILE
}

function javafile() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g'`
    FILEC="`echo $1 | sed 's/^.*\///g' | cut -d"." -f1`.class"
    EXE=`echo "$1" | sed 's/^.*\///g' | cut -d"." -f1`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    cp $ORIG $BIN/
    javac $BIN/$FILE
    java -cp $BIN/ $EXE
}

function cfile() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g' | cut -d"." -f1`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    gcc $ORIG -o $BIN/$FILE
    chmod +x $BIN/$FILE
    time $BIN/$FILE
}

function cppfile() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g' | cut -d"." -f1`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    g++ -std=c++11 $ORIG -o $BIN/$FILE
    chmod +x $BIN/$FILE
    time $BIN/$FILE
}

function asmfile() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g' | cut -d"." -f1`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    nasm -f elf64 $ORIG -o $ORIG.o
    ld -m elf_x86_64 $ORIG.o -o $BIN/$FILE
    chmod +x $BIN/$FILE
    time $BIN/$FILE
}

function asm32file() {
    ORIG=`echo "$1"`
    FILE=`echo "$1" | sed 's/^.*\///g' | cut -d"." -f1`
    if [ -f $BIN/$FILE ]; then
        rm -f $BIN/$FILE
    fi
    nasm -f elf32 $ORIG -o $ORIG.o
    ld -m elf_i386 $ORIG.o -o $BIN/$FILE
    chmod +x $BIN/$FILE
    time $BIN/$FILE
}

if [ $# -ne 2 ]; then
    printhelp
fi

case "$1" in
    "sh") shfile $2;;
    "py") pyfile $2;;
    "go") gofile $2;;
    "c") cfile $2;;
    "cpp") cppfile $2;;
    "asm") asmfile $2;;
    "asm32") asm32file $2;;
    "java") javafile $2;;
    *) printhelp;;
esac

