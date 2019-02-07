#!/bin/bash

LOCAL_USER=$(whoami)

declare -r KUBE_HOME=/home/$LOCAL_USER/.kube

echo "Initializing kubeadm..."

kubeadm init --feature-gates Auditing=true

echo "[INFO] Configuring kubectl config file..."

mkdir -p ${KUBE_HOME}

cp -i /etc/kubernetes/admin.conf ${KUBE_HOME}/config

chown ${LOCAL_USER}:${LOCAL_USER} ${KUBE_HOME}/config

echo "Installing Weave Net Add-On..."

KUBE_VERSION=$(kubectl version | base64 | tr -d '\n')

echo "[INFO] Using Kubernetes version: ${KUBE_VERSION}"

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=${KUBE_VERSION}"

echo "Done!"








