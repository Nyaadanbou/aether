#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 创建并使用 buildx 构建器
docker buildx create --use

# 构建多平台镜像并推送到 Docker Hub
docker buildx build --platform linux/amd64,linux/arm64 -t nailm/aether-java:25 \
  --build-arg JDK_AMD64_URL=https://cache-redirector.jetbrains.com/intellij-jbr/jbrsdk_jcef-25.0.2-linux-x64-b329.72.tar.gz \
  --build-arg JDK_ARM64_URL=https://cache-redirector.jetbrains.com/intellij-jbr/jbrsdk_jcef-25.0.2-linux-aarch64-b329.72.tar.gz \
  --push \
  -f "${SCRIPT_DIR}/dockerfile" \
  "${SCRIPT_DIR}"
