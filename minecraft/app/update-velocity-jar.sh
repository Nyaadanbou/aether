#!/bin/bash

# Velocity 文件夹
TARGET_DIRS=("proxy" "router")
# Velocity 版本号
VELOCITY_VERSION="3.4.0-SNAPSHOT"
# 临时文件夹
TEMP_DIR=/minecraft/tmp

source /minecraft/shared-functions.sh

# 下载一次 JAR 文件
download_server_jar "velocity" "$VELOCITY_VERSION" "$TEMP_DIR"

# 复制到多个目标目录
for dir in "${TARGET_DIRS[@]}"; do
    mkdir -p "$dir"
    copy_server_jar "velocity" "$dir" "$TEMP_DIR"
done

# 删除临时文件夹
rm -rf "$TEMP_DIR"
