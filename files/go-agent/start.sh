#!/bin/bash

CWD=`dirname "$0"`
AGENT_DIR=`(cd "$CWD" && pwd)`

USER=goagent
USER_DIR=/opt/$USER
USER_LOG_DIR=/var/log/$USER

AGENT_MEM="128m"
AGENT_MAX_MEM="256m"
GO_SERVER="127.0.0.1"
GO_SERVER_PORT="8153"
JVM_DEBUG_PORT="5006"
VNC="N"

#If this script is launched to start testing agent by production agent while running twist test, the variable
# AGENT_WORK_DIR is already set by the production agent. But testing agent should not use that.

if [ "$PRODUCTION_MODE" == "Y" ]; then
    AGENT_WORK_DIR=${AGENT_WORK_DIR:-"$AGENT_DIR"}
else
    AGENT_WORK_DIR=$AGENT_DIR
fi

LOG_DIR=$USER_LOG_DIR
LOG_FILE=$LOG_DIR/go-agent-bootstrapper.log
PID_FILE="$AGENT_WORK_DIR/go-agent.pid"

if [ "$VNC" == "Y" ]; then
    echo "[`date`] Starting up VNC on :3"
    /usr/bin/vncserver :3
    DISPLAY=:3
    export DISPLAY
fi

AGENT_STARTUP_ARGS="-Dcruise.console.publish.interval=10 -Xms$AGENT_MEM -Xmx$AGENT_MAX_MEM"

export AGENT_STARTUP_ARGS
export LOG_DIR
export LOG_FILE

CMD="$JAVA_HOME/bin/java -jar \"$AGENT_DIR/agent-bootstrapper.jar\" $GO_SERVER $GO_SERVER_PORT"

echo "[`date`] Starting Go Agent Bootstrapper with command: $CMD" >>$LOG_FILE
echo "[`date`] Starting Go Agent Bootstrapper in directory: $AGENT_WORK_DIR" >>$LOG_FILE
echo "[`date`] AGENT_STARTUP_ARGS=$AGENT_STARTUP_ARGS" >>$LOG_FILE
cd "$AGENT_WORK_DIR"

if [ "$JAVA_HOME" == "" ]; then
    echo "Please set JAVA_HOME to proceed."
    exit 1
fi

eval "nohup $CMD >>$LOG_FILE &"
echo $! >$PID_FILE

echo "Started"

