#!/bin/bash -xe

if [ "`whoami`" != "root" ]; then
	echo "Run this script as root." >&2
	exit 1
fi

JDK_DIR=/opt/jdk
JDK_INSTALL_DIR="/opt/jdk/jdk1.8.0_31"
JDK_DOWNLOAD_DIR=/opt/jdk/download
JDK_DOWNLOAD_FILE="$JDK_DOWNLOAD_DIR/jdk-8u31-linux-x64.tar.gz"
JDK_DOWNLOAD_URL="http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.tar.gz"

mkdir -p $JDK_DIR
mkdir -p $JDK_DOWNLOAD_DIR

test ! -f $JDK_DOWNLOAD_FILE && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "$JDK_DOWNLOAD_URL" -O $JDK_DOWNLOAD_FILE

if [ ! -d $JDK_INSTALL_DIR ]; then
	cd $JDK_DIR
	tar -xzf $JDK_DOWNLOAD_FILE
	chown -R root:root $JDK_INSTALL_DIR
	ln -s $JDK_INSTALL_DIR $JDK_DIR/jdk8
fi

