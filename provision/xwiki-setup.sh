#!/usr/bin/env bash

GLOBAL_PATH="/home/vagrant"

if [[ ! -f $(find /usr/bin -type f -name wget) ]]
then
	apt-get -y update && apt-get -y install wget
fi

wget -q "https://maven.xwiki.org/public.gpg" -O- | sudo apt-key add -
wget "https://maven.xwiki.org/stable/xwiki-stable.list" -P /etc/apt/sources.list.d/ &>/dev/null
apt-get -y update

cd $GLOBAL_PATH && wget -q https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java_8.0.15-1ubuntu18.04_all.deb
apt install $GLOBAL_PATH/mysql-connector-java_8.0.15-1ubuntu18.04_all.deb

DEBIAN_FRONTEND=noninteractive  apt-get -y install xwiki-tomcat8-mysql


sed -i 's/"-Djava.awt.headless=true -XX:+UseConcMarkSweepGC"/"-Djava.awt.headless=true -Xmx1024m"/g' /etc/default/tomcat8
sed -i 's/localhost/172\.16\.0\.20/g' /etc/xwiki/hibernate.cfg.xml
sed -i 's/<property name="connection.username">.*/<property name="connection.username">xwiki<\/property>/g' /etc/xwiki/hibernate.cfg.xml
sed -i 's/<property name="connection.password">.*/<property name="connection.password">xwiki<\/property>/g' /etc/xwiki/hibernate.cfg.xml


systemctl restart tomcat8.service
