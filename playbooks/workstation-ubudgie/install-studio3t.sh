#!/usr/bin/env bash

curl -o studio-3t.tar.gz https://download.studio3t.com/studio-3t/linux/2024.4.0/studio-3t-linux-x64.tar.gz
tar -xvf ./studio-3t.tar.gz
./studio-3t-linux-x64.sh
# opens a GUI to run the installer
# -> install to /home/tim/bin/studio3t
rm ./studio-3t.tar.gz ./studio-3t-linux-x64.sh