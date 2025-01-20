#!/bin/sh
docker buildx build -f duc.Dockerfile -t entec/duc-client:latest --platform linux/amd64 . \
  && docker push entec/duc-client:latest

# docker buildx build -f duc.Dockerfile -t entec/duc-client:latest --platform linux/amd64 .