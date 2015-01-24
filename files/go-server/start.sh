#!/bin/bash

CWD=`dirname "$0"`
SERVER_DIR=`(cd "$CWD" && pwd)`

USER=goserver
USER_DIR=/opt/$USER
USER_LOG_DIR=/var/log/$USER

SERVER_MEM="512m"
SERVER_MAX_MEM="1024m"
SERVER_MAX_PERM_GEN="256m"
SERVER_MIN_PERM_GEN="128m"
GO_SERVER_PORT="8153"
GO_SERVER_SSL_PORT="8154"
SERVER_WORK_DIR="$SERVER_DIR"

LOG_FILE=$USER_LOG_DIR/server.log
PID_FILE=$SERVER_DIR/go-server.pid

GO_CONFIG_DIR=$SERVER_DIR/config

SERVER_STARTUP_ARGS+=("-server")
SERVER_STARTUP_ARGS+=("-Xms$SERVER_MEM -Xmx$SERVER_MAX_MEM -XX:PermSize=$SERVER_MIN_PERM_GEN -XX:MaxPermSize=$SERVER_MAX_PERM_GEN")
SERVER_STARTUP_ARGS+=("-Duser.language=en -Dorg.mortbay.jetty.Request.maxFormContentSize=30000000 -Djruby.rack.request.size.threshold.bytes=30000000")
SERVER_STARTUP_ARGS+=("-Duser.country=US -Dcruise.config.dir=$GO_CONFIG_DIR -Dcruise.config.file=$GO_CONFIG_DIR/cruise-config.xml")
SERVER_STARTUP_ARGS+=("-Dcruise.server.port=$GO_SERVER_PORT -Dcruise.server.ssl.port=$GO_SERVER_SSL_PORT")

CMD="$JAVA_HOME/bin/java ${SERVER_STARTUP_ARGS[@]} -jar $SERVER_DIR/go.jar"

echo "Starting Go Server with command: $CMD" >>$LOG_FILE
echo "Starting Go Server in directory: $GO_WORK_DIR" >>$LOG_FILE

cd "$SERVER_WORK_DIR"

if [ "$JAVA_HOME" == "" ]; then
    echo "Please set JAVA_HOME to proceed."
    exit 1
fi

eval "nohup $CMD >>$LOG_FILE &"
echo $! >$PID_FILE

echo "Started on http://localhost:$GO_SERVER_PORT"
 

