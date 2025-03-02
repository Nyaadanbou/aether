#!/bin/bash

# 创建并使用 buildx 构建器
docker buildx create --use

# 构建多平台镜像并推送到 Docker Hub
docker buildx build --platform linux/amd64,linux/arm64 -t nailm/aether-java:21 \
  --build-arg JDK_AMD64_URL=https://cache-redirector.jetbrains.com/intellij-jbr/jbrsdk_jcef-21.0.6-linux-x64-b895.91.tar.gz \
  --build-arg JDK_ARM64_URL=https://cache-redirector.jetbrains.com/intellij-jbr/jbrsdk_jcef-21.0.6-linux-aarch64-b895.91.tar.gz \
  --push
  .
