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
	sudo apt-get install readline-dev  
	cd /home/pi/Plant_Care
        mkdir temp
        cd temp
        wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
        tar xfz Python-3.8.6.tgz
        cd Python-3.8.6
        ./configure --prefix=/home/pi/Plant_Care/Python-3.8.6
        make -j4
        make install
    fi
    cd /home/pi/Plant_Care/Python-3.8.6
    cd bin
    ./python3 -m pip install --upgrade pip
    ./python3 -m venv ~/Plant_Care/Zope
    cd /home/pi/Plant_Care/Zope
    #svn checkout https://scm.porscheinformatik.com/hdlint/svn/plone-buildout-py3 .
    bin/pip install zc.buildout
    bin/pip install wheel
    
    #cd ..
    #bin/pip3 install -r requirements.txt
    #bin/buildout
    exec bash
elsesvn up
    echo "cancel install Python / Plone"
fi  
