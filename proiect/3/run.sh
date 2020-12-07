#!/bin/sh
./cbuild.sh main

cp ./main.asm ./sourcesx86

./main < ./input.txt

