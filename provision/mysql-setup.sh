#!/usr/bin/env bash

GLOBAL_PATH="/home/vagrant"
#PASSWD=$(date +%s | sha256sum | base64 | head -c 32 ; echo)
#yum -y update

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
	#echo $PASSWD > $GLOBAL_PATH/sql_passwd.txt
	#echo -e "\033[0;32mYou MySQL password save in sql_passwd.txt in your home directory\033[0m\n"
	#mysqladmin -u root password $PASSWD
	grep 'temporary password' /var/log/mysqld.log | cut -d ':' -f 4 | tr -d " " > sql_passwd.txt
	echo -e "\033[0;32mYou TEMPORARY MySQL password save in sql_passwd.txt in your home directory, please do not forget cange it\033[0m\n"
else 
	echo -e "\033[0;31mSomething went wrong....\033[0m\n"
fi


