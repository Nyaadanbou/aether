#!/bin/bash

set -e

# 检查依赖
command -v curl >/dev/null 2>&1 || { echo >&2 "curl is required but it's not installed. Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "jq is required but it's not installed. Aborting."; exit 1; }

# 指定 JDK 大版本，例如 17 或 21
JDK_VERSION=${1:-21}

echo "JDK_VERSION is set to $JDK_VERSION"

# 从 .githubtoken 文件中读取 GitHub 个人访问令牌
GITHUB_TOKEN=$(cat "$(dirname "$0")/githubtoken" 2>/dev/null || true)
if [ -z "$GITHUB_TOKEN" ]; then
    echo "GitHub token not found. Please ensure the .githubtoken file exists and contains your token."
    exit 1
fi

# 获取 GitHub API 返回的 releases 信息
RESPONSE=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/JetBrains/JetBrainsRuntime/releases)
if [ -z "$RESPONSE" ]; then
    echo "Failed to fetch releases from GitHub API."
    exit 1
fi

# 过滤出 tag 包含 "jbr-release-$JDK_VERSION" 的 release，按创建时间排序，取最新一个
LATEST_RELEASE=$(echo "$RESPONSE" | jq -r --arg ver "jbr-release-$JDK_VERSION" \
    '[.[] | select(.tag_name | contains($ver))] | sort_by(.created_at) | last')
if [ -z "$LATEST_RELEASE" ] || [ "$LATEST_RELEASE" == "null" ]; then
    echo "No releases found for version containing jbr-release-$JDK_VERSION"
    exit 1
fi

# 提取 tag 和 body（包含 Markdown 格式下载链接）
TAG_NAME=$(echo "$LATEST_RELEASE" | jq -r '.tag_name')
BODY=$(echo "$LATEST_RELEASE" | jq -r '.body')

if [ -z "$TAG_NAME" ] || [ "$TAG_NAME" == "null" ]; then
    echo "Invalid tag name in the latest release."
    exit 1
fi

echo "Latest release found: $TAG_NAME"
# 可选：输出部分 body 用于调试
# echo "$BODY" | head -n 10

# 定义函数，从 release 的 body 中提取针对指定架构的 JBRSDK 下载链接
get_download_url() {
    local arch="$1"
    # 过滤包含 "JBRSDK" 和 "linux-<arch>" 的行，然后用 sed 提取 Markdown 链接中的 URL
    local url
    url=$(echo "$BODY" | grep -i "JBRSDK" | grep "linux-$arch" | sed -n 's/.*(\(http[^)]*\.tar\.gz\)).*/\1/p' | head -n 1)
    echo "$url"
}

# 定义下载函数
download_jdk() {
    local arch="$1"
    local url
    url=$(get_download_url "$arch")
    if [ -z "$url" ]; then
        echo "No download URL found for linux-$arch in release body."
        exit 1
    fi
    local file
    file=$(basename "$url")
    echo "Downloading $file for linux-$arch from:"
    echo "$url"
    curl -L -o "$file" "$url"
}

# 下载 linux-x64 和 linux-aarch64 版本
download_jdk "x64"
download_jdk "aarch64"

echo "JDK $JDK_VERSION downloaded successfully."
