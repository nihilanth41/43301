#!/bin/bash

set -e 

# Check for filename number as script argument.
if [[ $# -lt 1 ]]; then
	number=0
else 
	number="$1"
fi

CWD=$(pwd)
cd /tmp

# Left snapshot
puma2_save_left &
sleep 0.5
killall puma2_save_left
mv -i -v mvid_save00000.ppm "$CWD/left${number}.ppm"
rm /tmp/*.ppm

# Right snapshot
puma2_save_right & 
sleep 0.5
killall puma2_save_right
mv -i -v mvid_save00000.ppm "$CWD/right${number}.ppm"
rm /tmp/*.ppm

echo "DONE"

