切换到[中文](https://github.com/hawsers/kubernetes_image_mirrors/blob/master/README.md)

# Kubernetes Images Mirror

A Kubernetes Images Mirror project for people who can't  access google's registry directly.
This project will automatically mirror kubernetes images(include Dashboard & Helm) from official registry.
A bash script is provided for quickly and simply pull the images to local.

## Why use hawsers?
There were a lot of mirror repositories already, event docker provide parameter for using mirror repository, but each kubernetes version has different image versions dependency, it always a tedious task every time upgrade/install a new version of kubernetes. 

## How to use

### Determine your kubernetes version

For example, If you need to use kubernetes in docker, check kubernetes version in "About Docker Desktop".

### Pull Kubernetes images

To pull the latest version images:
```
./pull_by_hawsers.sh
```

To pull specific version images:
```
./pull_by_hawsers.sh -v=<specific_kubernetes_version>
```

To use mirrorgooglecontainers
```
./pull_by_hawsers.sh -g|--mirrorgooglecontainers
```

dependent images will be downloaded & retagged automatically

### On Windows

Please use git bash to launch this script.
jq for windows is required, you could use chocolatey in cmd(admin) to install:
```
choco install jq
```

### Supported Kubernetes Versions 

v1.10.0+

### Launch Kubernetes by any supported ways

* Enable Kubernetes Support in Docker
* MiniKube
* ... 

**ENJOY Kubernetes!!!**

### Pull Dashboard image

To pull the latest dashboard by:
```
./pull_by_hawsers.sh -d|--dashboard
```
To pull specific version of dashboard image:
```
./pull_by_hawsers.sh -d|--dashboard -v=<specific_kubernetes_version>
```

You could check your dashboard deployment version in yaml.

*Currently support versions below 2.0*

### Pull HELM tiller server image

To pull the latest by:
```
./pull_by_hawsers.sh -h|--helm
```
To pull specific version of helm tiller image:
```
 ./pull_by_hawsers.sh -h|--helm -v=<specific_kubernetes_version>
```
To check your tiller version by helm client:
```
helm version
```


## Mirror Image List

*version 1.12+*
- etcd
- pause
- kube-proxy
- kube-scheduler
- kube-apiserver
- kube-controller-manager
- k8s-dns-sidecar
- k8s-dns-kube-dns
- k8s-dns-dnsmasq-nanny
- coredns

*version 1.12-*
- etcd-amd64
- pause-amd64
- kube-proxy-amd64
- kube-scheduler-amd64
- kube-apiserver-amd64
- kube-controller-manager-amd64
- k8s-dns-dnsmasq-nanny-amd64
- k8s-dns-kube-dns-amd64
- k8s-dns-sidecar-amd64

*Dashboard*
- kubernetes-dashboard-amd64

*Helm*
- kubernetes-helm.tiller


## Kubernetes Dashboard Quick Reference

### Install & Run Dashboard 

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
```

### Check Dashboard Version

open above url and find "image:", you could get the image and its version. for example, in https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml,
you would find below images:
```
image: kubernetesui/dashboard:v2.0.0-beta1
```
and
```
image: kubernetesui/metrics-scraper:v1.0.0
```

### Run Proxy for Dashboard

You can access Dashboard using the kubectl command-line tool by running the following command:

```
kubectl proxy
```

### Check bearer token for Dashboard Authentication

```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```

### Open Dashboard URL in Browser

```
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```
or
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

## HELM Quick Reference

### Check Helm Version

After install your helm client, type:
```
helm version
```
check your helm client version,the tiller server version should be same as your client.

### To install tiller

install tiller server command:
```
helm init --tiller-image hawsers/kubernetes-helm.tiller:<tag>
```
To upgrade tiller server:
```
helm init --upgrade --tiller-image hawsers/kubernetes-helm.tiller:<tag>
```

## Other Reference

### Version List

* In [kubernetes_image_versions.json](https://raw.githubusercontent.com/hawsers/kubernetes_image_mirrors/master/kubernetes_image_versions.json)
* [All kubernetes version](https://github.com/kubernetes/sig-release/tree/master/releases/)
* [All dashboard version](https://github.com/kubernetes/dashboard/releases)

### Image Name Break Changes

refer to: https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#running-kubeadm-without-an-internet-connection

```In Kubernetes 1.12 and later, the k8s.gcr.io/kube-*, k8s.gcr.io/etcd and k8s.gcr.io/pause images don’t require an -${ARCH} suffix.```


