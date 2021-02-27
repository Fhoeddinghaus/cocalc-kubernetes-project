#!/bin/bash
set -e
date -Ins



# X11: to run QT based apps like octave
export QT_QPA_PLATFORM=xcb

# X11: let XDG_RUNTIME_DIR point to some tmp directory and set perms right
export XDG_RUNTIME_DIR="/tmp/xdg-runtime-user"
mkdir -p "$XDG_RUNTIME_DIR"
chmod -R 700 "$XDG_RUNTIME_DIR"

echo $(date -Ins) "Configured whitelisted environment"
env | sort

# A global self-imposed limit number on open files to maybe prevent really
# dumb disasters...
export COCALC_ULIMIT_OPEN_FILES=10000
# And limit how many files they can open at once.
ulimit -n $COCALC_ULIMIT_OPEN_FILES

# Copy bashrc into place if there isn't one already
if [ ! -f $HOME/.bashrc ]; then
    cp /cocalc/init/bashrc $HOME/.bashrc
fi

# Linux bash_profile to bashrc if it doesn't exist.
if [ ! -f $HOME/.bash_profile ]; then
    rm -f $HOME/.bash_profile  # it may be a broken symlink!
    ln -s $HOME/.bashrc $HOME/.bash_profile
fi

# Make the ephemeral directory where status, temporary config, and log
# files about the local hub and other daemons are stored.
rm -rf "$SMC" && mkdir "$SMC"

# Create .julia folder
mkdir "$HOME/.julia" || true

# Install Julia and all dependencies
julia /cocalc/init/julia_init.jl

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


