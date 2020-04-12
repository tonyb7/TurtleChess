#!/bin/bash

cd Winter
./build.sh

cd ..
./push_to_prod.sh

python3 lichess-bot.py

