#!/bin/bash

SERVER=game3

XMS="-Xms2G"
XMX="-Xmx2G"
PORT="--port 20002"
WORLD_DIR="--world-dir worlds"
LEVEL_NAME="--level-name world"
SERVER_CFG="--config server.properties"
BUKKIT_CFG="--bukkit-settings bukkit.yml"
SPIGOT_CFG="--spigot-settings spigot.yml"
CMDS_CFG="--commands-settings commands.yml"
MAX_PLAYER="--max-players 5"

DEBUG_PORT="11007"
DEBUG="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:$DEBUG_PORT"
HOTSWAP="-XX:NonProfiledCodeHeapSize=128M \
-XX:+AllowEnhancedClassRedefinition \
-Xlog:redefine+class*=info"

DISABLE_WATCHDOG="true"
PLAYERCONNECTION_KEEPALIVE=86400000

SERVER_MARK="-DminecraftServer=$SERVER"
PREFER_IPV4="-Djava.net.preferIPv4Stack=true"
AIKAR_FLAGS="-XX:+UseG1GC \
-XX:+ParallelRefProcEnabled \
-XX:MaxGCPauseMillis=200 \
-XX:+UnlockExperimentalVMOptions \
-XX:+DisableExplicitGC \
-XX:+AlwaysPreTouch \
-XX:G1HeapWastePercent=5 \
-XX:G1MixedGCCountTarget=4 \
-XX:G1MixedGCLiveThresholdPercent=90 \
-XX:G1RSetUpdatingPauseTimePercent=5 \
-XX:SurvivorRatio=32 \
-XX:+PerfDisableSharedMem \
-XX:MaxTenuringThreshold=1 \
-Dusing.aikars.flags=https://mcflags.emc.gs \
-Daikars.new.flags=true \
-XX:G1NewSizePercent=30 \
-XX:G1MaxNewSizePercent=40 \
-XX:G1HeapRegionSize=8M \
-XX:G1ReservePercent=20 \
-XX:InitiatingHeapOccupancyPercent=15"
EXTRA_OPENS="--add-opens java.base/java.lang=ALL-UNNAMED \
--add-opens java.base/java.lang.reflect=ALL-UNNAMED \
--add-opens java.base/java.util=ALL-UNNAMED \
--add-opens java.base/jdk.internal.misc=ALL-UNNAMED \
--add-opens java.base/jdk.internal.reflect=ALL-UNNAMED"
IGNITE="-Dignite.locator=paper \
-Dignite.paper.jar=./paper.jar"

# JVM 参数
JVM_PARAMS="$XMS $XMX $SERVER_MARK $PREFER_IPV4 $AIKAR_FLAGS $DEBUG $HOTSWAP $EXTRA_OPENS $IGNITE -Ddisable.watchdog=$DISABLE_WATCHDOG -Dpaper.playerconnection.keepalive=$PLAYERCONNECTION_KEEPALIVE"

# 应用程序参数
APP_PARAMS="--nogui $PORT $SERVER_CFG $BUKKIT_CFG $SPIGOT_CFG $CMDS_CFG $WORLD_DIR $LEVEL_NAME $MAX_PLAYER"
