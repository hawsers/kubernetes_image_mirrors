# Kubernetes Images Mirror


## How to use

### determine your kubernetes version
For example, If you need to use kubernetes in docker, check kubernetes version in "About Docker Desktop"

### Download Images From Mirror by script:
To pull the latest version images:
```
./pull_k8s_by_hawsers.sh
```
To pull specific version images:
```
./pull_k8s_by_hawsers.sh -v=<kubernetes_version>
```
required images will be downloaded & retagged automatically:

### Launch Kubernetes by any supported ways
* Enable Kubernetes Support in Docker
* MiniKube
* ... 

**ENJOY Kubernetes!!!**

## Supported Kubernetes Versions 
v1.10.0+

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

*dashboard*
- kubernetes-dashboard-amd64

*Helm*
- kubernetes-helm.tiller


## Version List
* In [kubernetes_image_versions.json](https://raw.githubusercontent.com/hawsers/kubernetes_image_mirrors/master/kubernetes_image_versions.json)
* [All kubernetes version](https://github.com/kubernetes/sig-release/tree/master/releases/)
* [All dashboard version](https://github.com/kubernetes/dashboard/releases)

## Image Name Break Changes
refer to: https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#running-kubeadm-without-an-internet-connection

```In Kubernetes 1.12 and later, the k8s.gcr.io/kube-*, k8s.gcr.io/etcd and k8s.gcr.io/pause images don’t require an -${ARCH} suffix.```



