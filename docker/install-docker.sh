#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo "[ERROR] You need to have root privileges."
fi

echo " >>> Installing dependences..."

apt-get update
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-proporties-common

echo " >>> Add Dockers official GPG key..."

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

apt-get update

echo ">>> Installing docker-ce last official release..."

apt-get install -y docker-ce docker-ce-cli containerd.io

echo ">>> Docker-ce has been installed with success!"

USER=$(whoami)

echo ">>> Adding the user $USER to the docker group in oder to you can use docker as a non-root user..."

sudo usermod -aG docker $USER

echo ">>> Done! Happy Docker!"

echo ">>> If you want to see more info regarding Docker, access https://docs.docker.com/install/linux/docker-ce/ubuntu/"
