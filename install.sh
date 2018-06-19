#!/bin/bash

# Installer script. Execute this for an automated installation.
# Note that this will move the current directory to /opt/arm.

startDir=$( pwd )
if [ $startDir != /opt/arm ]
then
  echo Moving repository to /opt/arm
  cd /opt && \
  sudo mv $startDir arm && \
  sudo chown -R root:root arm
  cd arm
fi

echo Installing dependencies
export DEBIAN_FRONTEND=noninteractive && \
sudo add-apt-repository -y ppa:heyarje/makemkv-beta && \
sudo add-apt-repository -y ppa:stebbins/handbrake-releases && \
sudo add-apt-repository -y ppa:mc3man/xerus-media && \
sudo apt update && \
sudo apt install -y makemkv-bin makemkv-oss && \
sudo apt install -y handbrake-cli libavcodec-extra && \
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'No configuration'" && \
sudo apt install -y abcde flac imagemagick glyrc cdparanoia && \
sudo apt install -y at && \
sudo apt install -y python3 python3-pip && \
sudo apt-get install -y libdvd-pkg && \
sudo dpkg-reconfigure libdvd-pkg && \
sudo pip3 install -r requirements.txt

echo Installing rules ad services
sudo ln -s /opt/arm/51-automedia.rules /lib/udev/rules.d/ && \
sudo ln -s /opt/arm/.abcde.conf /root/ && \
sudo cp /opt/arm/arm@.service /etc/systemd/system/

echo Copying sample config
cp config.sample config
