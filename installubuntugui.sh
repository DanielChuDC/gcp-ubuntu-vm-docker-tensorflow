#!/bin/bash
export username="cleversoft"
export password="my-very-strong-password"
echo '==== This script will enable Graphical User Interface on your Ubuntu Server ===='
echo '==== and creates a user account that you can use with Remote Desktop Connections ===='
echo '==== Username: ' $username 
echo '==== Password: ' $password

echo ''

echo '==== Upgrade system ===='
sudo apt-get update
sudo apt-get upgrade -y

echo '==== Install packages ===='
sudo apt-get install -y gnome-shell
sudo apt-get install -y ubuntu-gnome-desktop
sudo apt-get install -y autocutsel
sudo apt install -y xrdp
sudo systemctl enable xrdp
sudo apt-get install -y gnome-core
sudo apt-get install -y gnome-panel
sudo apt-get install -y synaptic

touch ~/.Xresources

sudo adduser  --disabled-password --gecos "GUI User" $username
echo "$username:$password" | sudo chpasswd

sudo usermod -aG sudo $username


echo "Installing start up script"
# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

sudo usermod -aG docker $username

echo "prerequisite for catkin >> "
sudo apt-get update && sudo apt-get install build-essential
