#!/bin/bash

set -e

# Check version in https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
# Search "Running kubeadm without an internet connection"
# For running kubeadm without an internet connection you have to pre-pull the required master images for the version of choice:
KUBE_VERSION=v1.10.11
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.1.12
DNS_VERSION=1.14.8
DASHBOARD_VERSION=v1.10.1

GCR_URL=k8s.gcr.io
MIRROR_URL=hawsers

images=(kube-proxy-amd64:${KUBE_VERSION}
kube-scheduler-amd64:${KUBE_VERSION}
kube-controller-manager-amd64:${KUBE_VERSION}
kube-apiserver-amd64:${KUBE_VERSION}
pause-amd64:${KUBE_PAUSE_VERSION}
etcd-amd64:${ETCD_VERSION}
k8s-dns-sidecar-amd64:${DNS_VERSION}
k8s-dns-kube-dns-amd64:${DNS_VERSION}
k8s-dns-dnsmasq-nanny-amd64:${DNS_VERSION}
kubernetes-dashboard-amd64:${DASHBOARD_VERSION})


for imageName in ${images[@]} ; do
  docker pull $MIRROR_URL/$imageName
  docker tag  $MIRROR_URL/$imageName $GCR_URL/$imageName
  docker rmi $MIRROR_URL/$imageName
done

docker images
