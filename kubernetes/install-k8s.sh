#!/bin/bash

echo "[INFO] Disabling swap..."

swapoff -a

echo "[INFO] Updating packages..."

apt-get update 

echo "[INFO] Installing Kubernetes..."

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

echo "[INFO] Done! Kubernetes has been installed."
echo "[INFO] Try out 'kubectl version' command to test the installation."
