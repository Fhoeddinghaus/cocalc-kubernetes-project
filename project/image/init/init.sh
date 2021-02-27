#!/bin/bash
set -e
date -Ins

bash /cocalc/kucalc-start-sshd.sh < /dev/null > /dev/stdout 2> /dev/stderr &
disown

if [[ -s "$HOME/project_init.sh" ]]; then
  bash "$HOME/project_init.sh" < /dev/null > /dev/stdout 2> /dev/stderr &
  disown
fi

# nvm: use node 10 + packages for the local hub (the setup prepends something to the PATH, that's all)
# and exec replaces the current process
# the local hub then cleans up some paths from the environment, such that subprocesses aren't affected
date -Ins
#. /cocalc/nvm/nvm.sh --no-use
# 10 below is to select node version 10
#nvm use --delete-prefix 10
#date -Ins
exec node /cocalc/src/smc-project/local_hub.js --tcp_port 6000 --raw_port 6001


