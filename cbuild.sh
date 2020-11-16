#!/bin/sh
as --32 "$1".asm -o "$1".o
gcc -m32 "$1".o -o "$1"

