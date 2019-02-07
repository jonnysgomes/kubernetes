# Introduction

This documentation is intended to guide you in how to create a Kubernetes cluster in local machines using the scripts which are in this repository. 

>NOTE: The following steps were tested on `Ubuntu 18.04` VMs.

## Prerequisites

Since we want to setting up a Kubernetes cluster, we need at least two machines:

- Master
  - 2 GB RAM
  - 2 CPU Cores
- Node
  - 1 GB RAM
  - 1 CPU Core

## Installing Docker

Run the script `docker/install-docker.sh` on each machine that will be part of the cluster.

```
cd scripts/docker
$ sudo ./install-docker.sh
```

## Installing Kubernetes

Run the script `kubernetes/install-k8s.sh` on each machine that will be part of the cluster.

That will install the last [Kubernetes](https://github.com/kubernetes/kubernetes/releases) release. The following componetes will be installed:

- kubelet
- kubectl
- kubeadm

Just execute the script `install-k8s.sh` on each machine.

```
$ sudo ./install-k8s.sh
```

>NOTE: You need to run the script with root privileges.

## Update the Hostnames [Optinal]

To change the hostname, open the file `/etc/hostname` and rename the Master machine to `k8s-master` and the Node machine to `k8s-node`. If you will have more than one Node, consider to use an enumeration for the hostnames, like `k8s-node-1`, `k8s-node-2`, etc.

## Update the Host file with the IPs of Master and Node [Optinal]

Verify the IP address of each machine:

```
$ ip addr
```

The IP address that we are looking for is under `enp0s8`. Take a note that value.

Go to the `/etc/hosts` file on both the master and node and add an entry specifying their respective IP address along with their name `k8s-master` and `k8s-node`. This is used for referencing them in the cluster. It should look like the below snippet on both the machines.

```
127.0.0.1    localhost
<master_IP>  k8s-master
<node_1_IP>  k8s-node-1
<node_2_IP>  k8s-node-2
```

## Setting static IP addresses [Optinal]

Since the IP address of our machines can be eventually modified, it's a good practice setting up a static IP for each machine of the cluster. To do that, go to the `/etc/network/interfaces` file and add the following lines:

```
auto enp0s8
iface enp0s8 inet static
address <IP_address>
```

Do that for each machine.

## Initializing Kubernetes Master

Just run the script `kubernetes/init-k8s-master` script.

```
$ sudo ./init-k8s-master.sh
```

>NOTE: You need to run the script with root privileges.

## Testing the cluster

To make sure everything is OK, run the command bellow from any cluster machine:

```
kubectl get pods --all-namespaces
```

## Kubernetes Dashboard

To install the Dashboard, run the following command:

```
$ kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
```

By default dashboard will not be visible on the Master VM. Run the following command in the command line:

```
$ kubectl proxy
```

To view the dashboard in the browser, navigate to the following address in the browser of your Master VM: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
