#!/bin/bash
echo "Python 3.8 Install Folder is: /home/pi/Plant_Care/Python-3.8.6"
echo "Zope 5.2 Install Folder is: home/pi/Plant_Care/Zope"
Python38="/home/pi/Plant_Care/Python-3.8.6"
read -p "You want to install Python 3.8 and Zope 5.2.2 (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    if [ -d "$Python38" ]; then
        # Control will enter here if $DIRECTORY exists.
        echo "$Python38 already installed"
        # exit
    else
	sudo apt-get install python-dev
	sudo apt-get install openssl
	sudo apt-get install libssl-dev
	sudo apt-get install libbz2-dev
	sudo apt-get install libreadline-dev  
	sudo apt-get install libffi-dev
	sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev
    	sudo mysql_secure_installation
  	sudo apt install mosquitto mosquitto-clients
	sudo apt install mariadb-server
	sudo apt-get install libmariadbclient-dev
	cd ~/Plant_Care
        mkdir temp
        cd temp
        wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
        tar xfz Python-3.8.6.tgz
        cd Python-3.8.6
        ./configure --prefix=~/Plant_Care/Python-3.8.6
        make -j4
        make install
    fi
    cd ~/Plant_Care/Python-3.8.6
    cd bin
    ./python3 -m pip install --upgrade pip
    ./python3 -m venv ~/Plant_Care/Zope
    cd ~/Plant_Care/Zope
    bin/pip install zc.buildout
    bin/pip install wheel
    bin/pip3 install adafruit-circuitpython-mcp3xxx
    bin/pip3 install RPi.gpio
    bin/pip3 install mysql-connector-python==8.0.29
    bin/pip3 install paho-mqtt
    cp ~/Plant_Care/buildout.cfg ~/Plant_Care/Zope
    mkdir src
    cd src
    git clone https://github.com/peter91v/PlantCare.git .
   
    cd ..
    bin/buildout
    exec bash
elsesvn up
    echo "cancel install Python / Plone"
fi  
