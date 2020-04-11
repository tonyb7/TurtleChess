#!/bin/bash
# Run this script to configure the engine on a new computer

set -Eeuo pipefail
set -x

echo "Did you remember you change config.yml to have the correct API token?"
echo "Does config.yml's engine field say Winter-prod?"

cd Winter
./build.sh

cd ../lichess-bot
rm -rf env
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
deactivate

mv lichess-bot/engines/Winter-prod lichess-bot/engines/Winter-prod-old
./push_to_prod.sh
cd ..

echo "Engine successfully configured on your machine!"
echo "To run bot, go to lichess-bot folder, activate a python virtual environment, and run lichess-bot.py!"

# cd lichess-bot
# python lichess-bot.py

