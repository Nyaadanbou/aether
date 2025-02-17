#!/bin/bash

source $(dirname "$0")/go.conf.sh
source /minecraft/shared-functions.sh
start_paper_server $SERVER "$JVM_PARAMS" "$APP_PARAMS"
