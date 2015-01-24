#!/bin/bash -xe

# http://www.go.cd/documentation/user/current/installation/installing_go_server.html

CWD=`dirname "$0"`
WORKING_DIR=`(cd "$CWD" && pwd)`

VERSION="14.4.0"

USER=goserver
USER_DIR=/opt/$USER

DOWNLOAD_VERSION="$VERSION-1356"
DOWNLOAD_DIR=$USER_DIR/downloads

if [ "`whoami`" != "$USER" ]; then
	echo "Run this script as user [$USER]." >&2
	exit 1
fi

mkdir -p $DOWNLOAD_DIR
chown $USER $DOWNLOAD_DIR

test ! -f $DOWNLOAD_DIR/go-server-$DOWNLOAD_VERSION.zip && wget "http://download.go.cd/gocd/go-server-$DOWNLOAD_VERSION.zip" -O $DOWNLOAD_DIR/go-server-$DOWNLOAD_VERSION.zip

test ! -d $USER_DIR/go-server-$VERSION && unzip $DOWNLOAD_DIR/go-server-$DOWNLOAD_VERSION.zip -d $USER_DIR

test -f $USER_DIR/go-server-$VERSION/start-server.bat && rm $USER_DIR/go-server-$VERSION/start-server.bat
test -f $USER_DIR/go-server-$VERSION/stop-server.bat && rm $USER_DIR/go-server-$VERSION/stop-server.bat
test -f $USER_DIR/go-server-$VERSION/server.sh && rm $USER_DIR/go-server-$VERSION/server.sh
test -f $USER_DIR/go-server-$VERSION/stop-server.sh && rm $USER_DIR/go-server-$VERSION/stop-server.sh
test -f $USER_DIR/go-server-$VERSION/server.cmd && rm $USER_DIR/go-server-$VERSION/server.cmd

test -f $USER_DIR/go-server-$VERSION/start.sh && rm $USER_DIR/go-server-$VERSION/start.sh
test -f $USER_DIR/go-server-$VERSION/stop.sh && rm $USER_DIR/go-server-$VERSION/stop.sh
cp -v $WORKING_DIR/../files/go-server/*.sh $USER_DIR/go-server-$VERSION/




