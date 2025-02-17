#!/bin/bash

# Paper 文件夹
TARGET_DIRS=("game1" "game2" "game3" "game4")
# Paper 版本号
PAPER_VERSION="1.21.3"
# 临时文件夹
TEMP_DIR=$(dirname "$0")/tmp

source $(dirname "$0")/shared-functions.sh

# 下载一次 JAR 文件
download_server_jar "paper" "$PAPER_VERSION" "$TEMP_DIR"

# 复制到多个目标目录
for dir in "${TARGET_DIRS[@]}"; do
    mkdir -p "$dir"
    copy_server_jar "paper" "$dir" "$TEMP_DIR"
done

# 删除临时文件夹
rm -rf "$TEMP_DIR"
