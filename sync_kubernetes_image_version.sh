#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# API_TOKEN
# TARGET_VERSION - If this env var is not set, will be sync to the latest version

# Kubeadm available version:
# curl -s https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages | grep Version | awk '{print $2}'
# install specific version of kubeadm: apt-get install -qy kubeadm=<version>

set -ex

target_version="${TARGET_VERSION}"

while getopts v: option
do
    case "${option}"
    in
    v) target_version="${OPTARG}";;
    esac
done


stored_versions=(`curl -sL https://raw.githubusercontent.com/hawsers/kubernetes_image_mirrors/master/kubernetes_image_versions.json | jq -r '.kubernetes[].version | @sh'`)
# For Local Debug
# stored_versions=(`cat ./kubernetes_image_versions.json | jq -r '.kubernetes[].version | @sh'`)

if [ -z "$target_version" ]; then
    # Get the latest version from github
    latest_version=`curl -sL https://api.github.com/repos/kubernetes/kubernetes/releases/latest | jq -r '.tag_name | @sh'`

    if [ -n "${latest_version}" -a "${latest_version}"!="null"]; then
        for i in "${stored_versions[@]}"; do
            if [[ $i == ${latest_version} ]]; then
                # Exit the whole script
                exit 0
            fi
        done
    else
        exit 0
    fi

    target_version=${latest_version}

fi

target_version_images=(`kubeadm config images list --kubernetes-version=${target_version//\'}`)

for i in "${target_version_images[@]}"; do
    json_string+=",\"${i}\""
done

# remove the first ","
json_string=${json_string#","}

# Git setup
# reAttach for Travis-CI
git remote rm origin
git remote add origin https://hawsers:${API_TOKEN}@github.com/hawsers/kubernetes_image_mirrors.git
git remote -v

git checkout master

echo `jq ".kubernetes += [{"version": \"${target_version}\","images": [${json_string}]}]" kubernetes_image_versions.json` > kubernetes_image_versions.json

git commit -a -m ${target_version//\'}

# Push commits
git push -v -f origin master
