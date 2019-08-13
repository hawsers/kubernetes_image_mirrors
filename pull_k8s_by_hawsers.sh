#!/bin/bash

set -e

kubernetes_version=""
GCR_PREFIX=k8s.gcr.io
MIRROR_PREFIX=hawsers

while getopts v:g option
do
    case "${option}"
    in
    v) kubernetes_version="${OPTARG}";;
    g) MIRROR_PREFIX=mirrorgooglecontainers;;
    esac
done

# default is the latest version
if [ -z "${kubernetes_version}" ]; then
    kubernetes_version=`curl -sL https://api.github.com/repos/kubernetes/kubernetes/releases/latest | jq -r '.tag_name '`
    # | @sh
fi

if [ -z "${kubernetes_version}" ]; then
    { echo "please set kubernetes_version!"; exit 1; }
fi

# printf "GCR_PREFIX: ${GCR_PREFIX}\n"
# printf "MIRROR_PREFIX: ${MIRROR_PREFIX}\n\n"

# Check version in https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
# Search "Running kubeadm without an internet connection"
# For running kubeadm without an internet connection you have to pre-pull the required master images for the version of choice:
# KUBE_VERSION=v1.14.3
# KUBE_PAUSE_VERSION=3.1
# ETCD_VERSION=3.3.10
# DNS_VERSION=1.3.1
# DASHBOARD_VERSION=v1.10.1


# ex: jq -c '[ .kubernetes[] | select( .version | contains("v1.10.9-beta.0")) .images[] ]' kubernetes_image_versions.json
# images=(
# kube-proxy:${KUBE_VERSION}
# kube-scheduler:${KUBE_VERSION}
# kube-controller-manager:${KUBE_VERSION}
# kube-apiserver:${KUBE_VERSION}
# pause:${KUBE_PAUSE_VERSION}
# etcd:${ETCD_VERSION}
# coredns:${DNS_VERSION}
# # k8s-dns-sidecar-amd64:${DNS_VERSION}
# # k8s-dns-kube-dns-amd64:${DNS_VERSION}
# # k8s-dns-dnsmasq-nanny-amd64:${DNS_VERSION}
# kubernetes-dashboard-amd64:${DASHBOARD_VERSION}
# )

# Get from kubernetes_image_versions.json
printf "Kubernetes Version: ${kubernetes_version}\n\n"

images=(`curl -sL https://raw.githubusercontent.com/hawsers/kubernetes_image_mirrors/master/kubernetes_image_versions.json | jq -rc "[ .kubernetes[] | select( .version==\"${kubernetes_version}\") .images[] ] | @sh"`)

for image in ${images[@]} ; do

  mirror_image=${image/$GCR_PREFIX/$MIRROR_PREFIX}

  echo ${mirror_image//\'}

  # docker pull $mirror_image
  # docker tag $mirror_image $image
  # docker rmi $mirror_image
done

printf "Pulling Kubernetes Images was Done!!\n\n"

docker images "${GCR_PREFIX}/*"