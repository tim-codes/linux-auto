#!/usr/bin/env fish

set packages (string split \n "
opencommit
typescript
ts-node
")

pnpm i -g $packages
