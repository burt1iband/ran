#!/bin/bash
## This script installs rn on Arch=Linux and Ubuntu or Ubuntu based systems.
## You may need to install encoders/decoders to enhance sox functionality
## and work with some audio formats.

## Set the username since this installer is probablyl being run with sudo
WHO="$(logname)"

## Set update and install commands
if [ -f /usr/bin/pacman ]; then
UPC="pacman -Syq"
INC="pacman -Sq --noconfirm" 
elif [ -f /usr/bin/apt-get ]; then
UPC="apt-get update -q"
INC="apt-get install --install-suggests -qy"
     else
echo "You do not appear to have a supported package manager on this system.
  SOX is required by RAN. If sox is not installed on this system please do so."
     fi

## Install sox if it is not already on the system.
if ! [ -f /usr/bin/sox ] && ! [ -f /usr/local/bin/sox ]; then
sudo "$UPC" && sudo "$INC" sox 
     fi

## Copy ran files in to place
sudo install -m 755 ./ran /usr/bin/
sudo install -m 644 ./completions/ran /usr/share/bash-completion/completions/
sudo install -m 644 ./ran.1.gz /usr/share/man/man1/

## Create fluxable dirs and install comfig files as needed 
if ! [ -d /etc/fluxable ]; then
sudo mkdir -p /etc/fluxable
sudo install -m 644 ./fluxable.conf.org /etc/fluxable/fluxable.conf
sudo install -m 644 ./fluxable.conf.org /etc/fluxable/fluxable.conf.org
else
if [ -f /etc/fluxable/fluxable.conf ]; then
sudo install -m 644 ./fluxable.conf.org /etc/fluxable/uxable.conf.org
     else
sudo install -m 644 ./fluxable.conf.org /etc/fluxable/fluxable.conf
     fi
     fi

sudo mkdir -p /usr/share/doc/ran
sudo install -m 644 ./change.log /usr/share/doc/ran/ 

if ! [ -d $HOME/.fluxable ]; then
mkdir -p $HOME/.fluxable
sudo chown $WHO ~/.fluxable
     fi

if ! [ -f $HOME/.fluxable/fluxable.conf ]; then
cp ./fluxable.conf $HOME/.fluxable/fluxable.conf
sudo chown -R $WHO ~/.fluxable
     fi

echo "Open a terminal or tty console, type ran, or ran some-filename,
and recording will start. The file's extension will be added by ran.
Control cstops the recording. Recordings live in ~/Audio/au_notes.
To see a help message type ran -h, or 
man ran for more detailed information."
   exit=0
