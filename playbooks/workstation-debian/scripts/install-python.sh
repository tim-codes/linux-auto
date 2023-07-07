#!/usr/bin/env bash

wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz
tar -xf Python-3.10.*.tgz
cd Python-3.10.*/
./configure --prefix=/usr/local --enable-optimizations --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make -j $(nproc)
sudo make altinstall
python3.10 --version
cd .. && rm Python*.tgz -rf Python-3.10.*/
pip3.10 install --user --upgrade pip
