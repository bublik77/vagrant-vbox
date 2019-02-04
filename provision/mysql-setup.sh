#!/usr/bin/env bash

GLOBAL_PATH="/home/vagrant"

if [[ ! -f $(find /usr/bin -type f -name wget) ]]
then
	yum -y install wget
fi

cd $GLOBAL_PATH && wget https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm

yum -y install $GLOBAL_PATH/mysql80-community-release-el7-2.noarch.rpm

if [[ $? -eq 0 ]]
then
	yum -y install mysql-server
	systemctl start mysqld
	grep 'temporary password' /var/log/mysqld.log | cut -d ':' -f 4 | tr -d " " > sql_passwd.txt
	echo -e "\033[0;31mYou TEMPORARY MySQL password save in sql_passwd.txt in your home directory, please do not forget cange it\033[0m\n"
else 
	echo -e "\033[0;31mSomething went wrong....\033[0m\n"
fi


