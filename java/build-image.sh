#!/bin/bash

docker build -t nailm/aether-java:21 \
  --build-arg JDK_AMD64_URL=https://cache-redirector.jetbrains.com/intellij-jbr/jbrsdk-21.0.6-linux-x64-b872.85.tar.gz \
  --build-arg JDK_ARM64_URL=https://cache-redirector.jetbrains.com/intellij-jbr/jbrsdk-21.0.6-linux-aarch64-b872.85.tar.gz \
  .
