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
echo '
<hibernate-configuration>
			<session-factory>
			<property name="connection.url">jdbc:mysql://172.16.0.20:3306/xwiki</property>
			<property name="connection.username">xwiki</property>
			<property name="connection.password">xwiki</property>
			<property name="connection.driver_class">com.mysql.jdbc.Driver</property>
			<property name="dialect">org.hibernate.dialect.MySQL5InnoDBDialect</property>
			<property name="dbcp.poolPreparedStatements">true</property>
			<property name="dbcp.maxOpenPreparedStatements">20</property>
			<property name="hibernate.connection.charSet">UTF-8</property>
			<property name="hibernate.connection.useUnicode">true</property>
			<property name="hibernate.connection.characterEncoding">utf8</property>
			<mapping resource="xwiki.hbm.xml"/>
			<mapping resource="feeds.hbm.xml"/>
			<mapping resource="$mapping"/>
			</session-factory>
</hibernate-configuration>
' >> /etc/xwiki/hibernate.cfg.xml

sed -i 's/"-Djava.awt.headless=true -XX:+UseConcMarkSweepGC"/"-Djava.awt.headless=true -Xmx1024m"/g' /etc/default/tomcat8

systemctl restart tomcat8.service
