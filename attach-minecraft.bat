@echo off

docker info >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Docker is not running. Please start Docker and try again.
    exit /b 1
)

set CONTAINER_NAME_OR_ID=aether-minecraft-1

docker ps -q -f name=%CONTAINER_NAME_OR_ID% >nul
if %ERRORLEVEL% NEQ 0 (
    echo Failed to start the Minecraft container. Please check the Docker Compose configuration.
    exit /b 1
)

for /f "delims=" %%i in ('echo %CONTAINER_NAME_OR_ID% ^| xxd -p') do set HEX_CONTAINER_NAME=%%i
code --folder-uri vscode-remote://attached-container+%HEX_CONTAINER_NAME%/minecraft
