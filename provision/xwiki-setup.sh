#!/usr/bin/env bash

GLOBAL_PATH="/home/vagrant"

if [[ ! -f $(find /usr/bin -type f -name wget) ]]
then
	apt-get -y update && apt-get -y install wget
fi

wget -q "https://maven.xwiki.org/public.gpg" -O- | sudo apt-key add -
wget "https://maven.xwiki.org/stable/xwiki-stable.list" -P /etc/apt/sources.list.d/ &>/dev/null
apt-get -y update


apt-get -y install xwiki-tomcat8-common


