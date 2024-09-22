#!/bin/bash

echo "Resetting last boot..."
sed -i 's/"last_boot": ".*"/"last_boot": ""/' /data/config.json 2> /dev/null

echo "Disabling auto update..."
python3 -m supervisor -- options --auto-update=false
echo "Starting hassio..."
python3 -m supervisor
