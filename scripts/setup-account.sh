#!/bin/bash -xe

if [ "`whoami`" != "root" ]; then
	echo "Run this script as root." >&2
	exit 1
fi

if [ -z $1 ]; then
	echo "Usage: $0 <username>"
	exit 1
fi

USER=$1
USER_DIR=/opt/$USER
USER_LOG_DIR=/var/log/$USER

mkdir -p $USER_DIR
mkdir -p $USER_LOG_DIR

echo 'export JAVA_HOME=/opt/jdk/jdk8' > $USER_DIR/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> $USER_DIR/.bashrc

echo '[[ -r ~/.bashrc ]] && . ~/.bashrc' > $USER_DIR/.bash_profile

useradd --home $USER_DIR --shell /bin/bash $USER

chown $USER $USER_DIR
chown $USER $USER_LOG_DIR



