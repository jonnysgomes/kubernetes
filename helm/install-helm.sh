#!/bin/bash

if [ "$1" == "" ]; then
  echo "You must to pass the Helm version as a parameter."
  echo "For instance: sudo ./install-helm.sh 2.12.3"
  echo "You can consult the release versions at https://github.com/helm/helm/releases"
  exit 0
fi

declare -r HELM_VERSION=$1

echo "Downloading Helm version $HELM_VERSION..."

curl https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz --output helm-v${HELM_VERSION}-linux-amd64.tar.gz

tar xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz

sudo mv linux-amd64/helm /usr/local/bin/helm

echo "Done! Test Helm isntallation by running 'helm version'."
echo "If you still don't have Helm Tiller running, execute to following command to do it:"
echo "helm init"