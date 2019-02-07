#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo "[ERROR] You need to have root privileges."
  exit 0
fi

echo "[INFO] Disabling swap..."

swapoff -a

echo "[INFO] Installing Kubernetes..."

apt-get update 

apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl  \ 
  software-properties-common

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update

apt-get install -y kubelet kubeadm kubectl

KUBE_VERSION=$(kubectl version | base64 | tr -d '\n')

echo "[INFO] Done! Kubernetes ${KUBE_VERSION} has been installed. Have fun!"
