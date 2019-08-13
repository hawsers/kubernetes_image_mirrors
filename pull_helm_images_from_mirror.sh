#!/bin/bash

set -e

# Check version in https://github.com/helm/helm/releases
HELM_VERSION=v2.12.2

GCR_URL=gcr.io
MIRROR_URL=hawsers

images=(kubernetes-helm.tiller:${HELM_VERSION})


for imageName in ${images[@]} ; do
  docker pull $MIRROR_URL/$imageName
  docker tag  $MIRROR_URL/$imageName $GCR_URL/kubernetes-helm/tiller:${HELM_VERSION}
  docker rmi $MIRROR_URL/$imageName
done

docker images