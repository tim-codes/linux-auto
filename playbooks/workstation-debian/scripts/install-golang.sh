#!/usr/bin/env sh
VERSION=1.20.7

curl -L -O "https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go${VERSION}.linux-amd64.tar.gz"
rm "go${VERSION}.linux-amd64.tar.gz"
go version
