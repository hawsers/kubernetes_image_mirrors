#!/bin/bash

set -e

specific_version=""
MIRROR_PREFIX=hawsers

# k-k8s;d-dashboard;h-helm;
product_flag="k"

# Arguments
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -v|--version)
    specific_version="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--mirrorgooglecontainers)
    MIRROR_PREFIX=mirrorgooglecontainers
    shift # past argument
    ;;
    -h|--helm)
    product_flag="h"
    shift # past argument
    ;;
    -d|--dashboard)
    product_flag="d"
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# TEST
# printf "MIRROR_PREFIX: ${MIRROR_PREFIX}\n"
# printf "specific_version: ${specific_version}\n"

case $product_flag in
    k)
    GCR_PREFIX=k8s.gcr.io

    # default is the latest version
    if [ -z "${specific_version}" ]; then
        specific_version=`curl -sL https://api.github.com/repos/kubernetes/kubernetes/releases/latest | jq -r '.tag_name '`
        # | @sh
    fi

    if [ -z "${specific_version}" ]; then
        { echo "please set specific_version!"; exit 1; }
    fi

    printf "Kubernetes Version: ${specific_version}\n\n"

    # Get from kubernetes_image_versions.json
    images=(`curl -sL https://raw.githubusercontent.com/hawsers/kubernetes_image_mirrors/master/kubernetes_image_versions.json | jq -rc "[ .kubernetes[] | select( .version==\"${specific_version}\") .images[] ] | @sh"`)

    for image in ${images[@]} ; do
        mirror_image=${image/$GCR_PREFIX/$MIRROR_PREFIX}

        # echo $image
        # echo ${mirror_image//\'}
        # echo ${mirror_image}

          docker pull ${mirror_image//\'}
          docker tag ${mirror_image//\'} $image
          docker rmi ${mirror_image//\'}
    done
    ;;
    h)
    
    # default is the latest version
    if [ -z "${specific_version}" ]; then
        specific_version=`curl -sL https://api.github.com/repos/helm/helm/releases/latest | jq -r '.tag_name '`
        # | @sh
    fi

    printf "Helm Tiller Version: ${specific_version}\n\n"

    GCR_PREFIX=gcr.io
    image="${GCR_PREFIX}/kubernetes-helm/tiller:${specific_version}"    
    mirror_image="${MIRROR_PREFIX}/kubernetes-helm.tiller:${specific_version}"
    
    
    # echo $image
    # echo ${mirror_image//\'}
    # echo ${mirror_image}

      docker pull $mirror_image
      docker tag $mirror_image $image
      docker rmi $mirror_image
    ;;
    d)
    
    # default is the latest version
    if [ -z "${specific_version}" ]; then
        specific_version=`curl -sL https://api.github.com/repos/kubernetes/dashboard/releases/latest | jq -r '.tag_name '`
        # | @sh
    fi

    printf "Dashboard Version: ${specific_version}\n\n"

    # TODO:Dashboard support not complete
    # < v2.0.0
    GCR_PREFIX=k8s.gcr.io
    image="${GCR_PREFIX}/kubernetes-dashboard-amd64:${specific_version}"    
    mirror_image="${MIRROR_PREFIX}/kubernetes-dashboard-amd64:${specific_version}"
    
    # echo $image
    # echo ${mirror_image//\'}
    # echo ${mirror_image}

      docker pull $mirror_image
      docker tag $mirror_image $image
      docker rmi $mirror_image

    # TODO: >= v2.0.0
    # GCR_PREFIX=kubernetesui
    #images=("kubernetesui/dashboard:${specific_version}" "kubernetesui/metrics-scraper:v1.0.0")

    ;;

esac


printf "Pulling Images was Done!!\n\n"

docker images "${GCR_PREFIX}/*"