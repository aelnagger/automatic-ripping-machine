#!/bin/bash

# Installer script. Execute this for an automated installation.

sudo add-apt-repository -y ppa:heyarje/makemkv-beta && \
sudo add-apt-repository -y ppa:stebbins/handbrake-releases && \
sudo add-apt-repository -y ppa:mc3man/xerus-media && \
sudo apt update && \
sudo apt install -y makemkv-bin makemkv-oss && \
sudo apt install -y handbrake-cli libavcodec-extra && \
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'No configuration'" && \
sudo apt install -y abcde flac imagemagick glyrc cdparanoia && \
sudo apt install -y at && \
sudo apt install -y python3 python3-pip && \
sudo apt-get install -y libdvd-pkg && \
sudo dpkg-reconfigure libdvd-pkg && \
sudo su && \
cd /opt && \
git clone https://github.com/automatic-ripping-machine/automatic-ripping-machine.git arm && \
cd arm && \
pip3 install -r requirements.txt && \
ln -s /opt/arm/51-automedia.rules /lib/udev/rules.d/ && \
ln -s /opt/arm/.abcde.conf /root/ && \
cp /opt/arm/arm@.service /etc/systemd/system/ && \
cp config.sample config
