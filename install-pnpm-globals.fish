#!/usr/bin/env fish

set packages (string split \n "
opencommit
typescript
ts-node
diff-so-fancy
")

pnpm i -g $packages
