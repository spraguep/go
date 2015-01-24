#!/bin/bash -xe

sudo ./setup-jdk8.sh
sudo ./setup-account.sh goserver
sudo ./setup-account.sh goagent
sudo -i -u goserver `pwd`/setup-go-server.sh
sudo -i -u goagent `pwd`/setup-go-agent.sh

