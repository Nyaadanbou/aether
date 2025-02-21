#!/bin/bash

# 检查 Docker 是否正在运行
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    exit 1
fi

CONTAINER_NAME_OR_ID="aether-minecraft-1"

# 检查容器是否启动成功
if ! docker ps -q -f name=$CONTAINER_NAME_OR_ID > /dev/null; then
    echo "Failed to start the Minecraft container. Please check the Docker Compose configuration."
    exit 1
fi

# https://stackoverflow.com/a/75578470
code --folder-uri vscode-remote://attached-container+$(printf "$CONTAINER_NAME_OR_ID" | xxd -p)/minecraft
