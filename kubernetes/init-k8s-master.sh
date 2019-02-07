#!/bin/bash

if [ "$1" == "" ]; then
  echo "You must to pass the user name or you can just run 'sudo ./init-k8s-master.sh $(whoami)'."
  exit 0
fi

declare -r LOCAL_USER=$1

declare -r KUBE_HOME=/home/$LOCAL_USER/.kube

echo "Initializing kubeadm..."

kubeadm init --feature-gates Auditing=true

echo "[INFO] Configuring kubectl config file..."

mkdir -p ${KUBE_HOME}

cp -i /etc/kubernetes/admin.conf ${KUBE_HOME}/config

chown ${LOCAL_USER}:${LOCAL_USER} ${KUBE_HOME}/config

echo "Installing Weave Net Add-On..."

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

echo "Done!"








