#!/bin/bash

#
# Initialize minikube
#

MINIKUBE_RELEASE="0.25.2"
KUBECTL_RELEASE=$( curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt )

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Downloading \"kubectl\" ..."

curl -s -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_RELEASE/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/

echo "Downloading \"minikube\" ..."

curl -s -Lo minikube https://storage.googleapis.com/minikube/releases/v$MINIKUBE_RELEASE/minikube-linux-amd64
chmod +x ./minikube
sudo mv ./minikube /usr/local/bin/

sudo minikube start --vm-driver=none --extra-config=apiserver.ServiceNodePortRange=1000-10000

sudo chown -R $( id -u ):$( id -g ) $HOME/.kube
sudo chown -R $( id -u ):$( id -g ) $HOME/.minikube

echo -e "\nCluster IP:"
minikube ip

echo

kubectl create -f $DIR/service.yml
