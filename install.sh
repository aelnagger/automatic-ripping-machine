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
sudo su && \
add-apt-repository -y ppa:heyarje/makemkv-beta && \
add-apt-repository -y ppa:stebbins/handbrake-releases && \
add-apt-repository -y ppa:mc3man/xerus-media && \
apt update && \
apt install -y makemkv-bin makemkv-oss && \
apt install -y handbrake-cli libavcodec-extra && \
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'No configuration'" && \
apt install -y abcde flac imagemagick glyrc cdparanoia && \
apt install -y at && \
apt install -y python3 python3-pip && \
apt-get install -y libdvd-pkg && \
dpkg-reconfigure libdvd-pkg && \
su && \
pip3 install -r requirements.txt && \
ln -s /opt/arm/51-automedia.rules /lib/udev/rules.d/ && \
ln -s /opt/arm/.abcde.conf /root/ && \
cp /opt/arm/arm@.service /etc/systemd/system/ && \
cp config.sample config
