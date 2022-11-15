#!/bin/bash
 
echo "Install and Configuring mariadb..."
read -p "If not done, You should install Maria DB Server. Should we install?? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    sudo apt install mariadb-server
    sudo apt-get install libmariadbclient-dev
    sudo mysql_secure_installation
fi

echo "Creating plantcar database and tables, create DB-User plantcare"
sudo mysql -e "CREATE DATABASE IF NOT EXISTS plantcare"
sudo mysql -e "CREATE USER IF NOT EXISTS 'plantcare'@'%' identified by 'plantcare'"
sudo mysql -e "GRANT ALL PRIVILEGES ON plantcare.* to 'plantcare'@'%' identified by 'plantcare'"

sudo mysql -e "use plantcare;CREATE TABLE IF NOT EXISTS Sensors ( \
    ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, \
    SensorName varchar(255) NOT NULL, \
    Humidity int(11) DEFAULT NULL, \
    SensorDry int(11) DEFAULT NULL, \
    SensorWet int(11) DEFAULT NULL)" \

sudo mysql -e "use plantcare;CREATE TABLE IF NOT EXISTS Data ( \
    id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, \
    humidity float DEFAULT NULL, \
    date date DEFAULT NULL, \
    time datetime DEFAULT NULL,
    Sensor varchar(255) NOT NULL)" \

sudo mysql -e "USE plantcare;SHOW tables;"
echo "Table Sensors and Data created."
# Make our changes take effect
sudo mysql -e "FLUSH PRIVILEGES"
echo "Configure mariadb bind-address and Port (0.0.0.0  port=3306)..."
read -p "If not done, we open nano /mariadb.conf.d/50-server.cnf (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
    sudo systemctl restart mariadb
    echo "---------------> listen should be:  0 0.0.0.0:3306 "
    netstat -ant | grep 3306
fi


