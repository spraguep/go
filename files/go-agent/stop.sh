#!/bin/bash

CWD=`dirname "$0"`
AGENT_DIR=`(cd "$CWD" && pwd)`

PID_FILE="$AGENT_DIR/go-agent.pid"

cat $PID_FILE | xargs kill -15

echo "Stopped"

