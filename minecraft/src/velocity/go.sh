#!/bin/bash

# 修改这里的名字!
SERVER=unnamed

tmux has-session -t $SERVER 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SERVER -n "main" "java @jvmargs.txt -jar velocity.jar"
else
    tmux attach-session -t $SERVER
fi
