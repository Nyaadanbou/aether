#!/bin/bash

# 检查 Docker 是否正在运行
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    exit 1
fi

# 检查容器是否存在
if ! docker ps -q -f name=aether-mc > /dev/null; then
    echo "Container 'aether-mc' is not running. Please start the container and try again."
    exit 1
fi

# 进入容器的 Bash
docker exec -it aether-mc /bin/bash