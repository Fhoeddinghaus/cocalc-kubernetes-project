#!/bin/bash
set -e
date -Ins

# Setup the environment.  This is EVERYTHING that the user sees, because we run init.sh
# with the optionenv -i.  We do this to have a clear whitelist of the user's environment,
# since Kubernetes very annoyingly puts a ton of potentially sensitive invormation
# in the environment.
#
# Some comments about the vars below:
#
# SMC                 = where project server stores its temp files
# SMC_ROOT            = where cocalc source code is located
# NODE_PATH           = load path for project server code
# COCALC_USERNAME     = username that project runs as (TODO: do NOT change).
# PATH                = load path for code
# PYTHONPATH          = do not set it, because it mixes up libraries between python2 and 3
#                       instead, use a *.pth file, see k8s_build.py!
# $1                  = the project's UUID

PROJECT_ID=$1

# Note: do not use the comment '#' sign *inside* any values! (assumed by cimage.py)
export COCALC_SSH_PORT="2222"
export COCALC_PROJECT_ID=$PROJECT_ID
export COCALC_USERNAME="user"
export COCALC_LOCAL_HUB_PORT=6000
export COCALC_HTTP_PORT=6001
export COCALC_JUPYTER_LAB_PORT=6002
export DISPLAY=:0    # default Xpra server in the container will be here (if you start it).
export EXT="/ext"
export HOME=/home/user
export HOSTNAME=project-$1
export USER=user
export SMC=$HOME/.smc
export SMC_ROOT=/cocalc/src
export NODE_PATH=/cocalc/src:/cocalc/src/node_modules/smc-util:/cocalc/src/node_modules:/cocalc/src/smc-project/node_modules:/cocalc/src/smc-project/
export COCALC_USERNAME=user
# xrpa and ghc must come before /usr*
PATH_COCALC="/cocalc/bin:/cocalc/src/smc-project/bin:$HOME/bin:$HOME/.local/bin"
export PATH=$PATH_COCALC:$EXT/bin:/usr/lib/xpra:/opt/ghc/bin:/usr/local/bin:/usr/bin:/bin:$EXT/data/homer/bin:$EXT/data/weblogo:$EXT/intellij/idea/bin:$EXT/pycharm/pycharm/bin
export LC_ALL="C.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export _JAVA_OPTIONS="-Djava.io.tmpdir=$HOME/tmp -Xms64m"
export NLTK_DATA="$EXT/data/nltk_data"
export ISOCHRONES="$EXT/data/isochrones"
export JUPYTER_PATH="/usr/bin/jupyter"
export JULIA_DEPOT_PATH="$HOME/.julia:$EXT/julia/depot/"
export ANACONDA3="$EXT/anaconda3"
export ANACONDA5="$EXT/anaconda5"
export NODE_ENV=production
export SCREENDIR="/tmp/screen"
export TERM="xterm-256color"
export MKL_THREADING_LAYER="GNU"    # mainly for theano, inside of pymc3

(echo "env_pre_init.sh finished." || true)
