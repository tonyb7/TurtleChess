#!/bin/bash
# Run this script to configure and run the engine on a new computer

set -Eeuo pipefail
set -x

echo "Did you remember you change config.yml to have the correct API token?"
echo "Does config.yml's engine field say Winter-prod?"

mv lichess-bot/engines/Winter-prod lichess-bot/engines/Winter-prod-old

cd Winter
./build.sh

cd ../lichess-bot
rm -rf env
python3 -m venv env
source env/bin/activate

python lichess-bot.py

