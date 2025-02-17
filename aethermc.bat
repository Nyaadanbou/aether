@echo off

REM 检查 Docker 是否正在运行
docker info >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Docker is not running. Please start Docker and try again.
    exit /b 1
)

REM 检查容器是否存在
docker ps -q -f name=aether-mc >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Container 'aether-mc' is not running. Please start the container and try again.
    exit /b 1
)

REM 进入容器的 Bash
docker exec -it aether-mc /bin/bash