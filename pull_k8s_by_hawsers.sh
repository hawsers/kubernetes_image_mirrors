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

printf "Kubernetes Version: ${kubernetes_version}\n\n"

# Get from kubernetes_image_versions.json
images=(`curl -sL https://raw.githubusercontent.com/hawsers/kubernetes_image_mirrors/master/kubernetes_image_versions.json | jq -rc "[ .kubernetes[] | select( .version==\"${kubernetes_version}\") .images[] ] | @sh"`)

for image in ${images[@]} ; do

  mirror_image=${image/$GCR_PREFIX/$MIRROR_PREFIX}

  echo ${mirror_image//\'}

  docker pull $mirror_image
  docker tag $mirror_image $image
  docker rmi $mirror_image
done

printf "Pulling Kubernetes Images was Done!!\n\n"

docker images "${GCR_PREFIX}/*"