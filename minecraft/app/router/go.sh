#!/bin/bash

source $(dirname "$0")/go.conf.sh

tmux has-session -t $SERVER 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SERVER -n "main" "java $DEBUG $XMS $XMX $SERVER_MARK $PREFER_IPV4 $G1GC_FLAGS $DISABLE_SVE -jar velocity*.jar"
else
    tmux attach-session -t $SERVER
fi
