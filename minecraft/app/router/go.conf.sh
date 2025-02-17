#!/bin/bash

SERVER="router"
DEBUG_PORT="10005"
DEBUG="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:$DEBUG_PORT"
XMS="-Xms64M"
XMX="-Xmx64M"
SERVER_MARK="-DminecraftServer=$SERVER"
PREFER_IPV4="-Djava.net.preferIPv4Stack=true"
G1GC_FLAGS="-XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15"
DISABLE_SVE="-XX:UseSVE=0"
