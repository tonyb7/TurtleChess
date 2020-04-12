#!/bin/bash

set -Eeuo pipefail
set -x

rm -rf src
cp -r ../WinterTurtle/WinterTurtle src

make clean 
make

# cp Winter ../lichess-bot/engines/Winter-beta
cp Winter ../engines/Winter-beta
