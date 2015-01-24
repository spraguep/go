#!/bin/bash

CWD=`dirname "$0"`
SERVER_DIR=`(cd "$CWD" && pwd)`

PID_FILE=$SERVER_DIR/go-server.pid

cat $PID_FILE | xargs kill -15

echo "Stopped"
