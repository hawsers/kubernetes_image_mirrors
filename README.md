Change to [English](https://github.com/hawsers/kubernetes_image_mirrors/blob/master/README_EN.md)

# Kubernetes Images 镜像

这是个Kubernetes自动镜像项目。利用Docker Hub作为官方镜像的中转站，目的是为了让想学习Kubernetes又无法直接访问Google镜像仓库的人可以快速拉取所需的本地依赖镜像。
项目提供了一个脚本可以直简单直接地拉取所需的镜像。

## 为什么要使用hawsers?

虽然现在已经有很多个不同的镜像仓库，docker也支持mirror仓库作为参数，但是kubernetes每个版本的依赖镜像版本都会有差异，每次去查询这些镜像版本依赖也是一个很繁琐的操作。

## 如何使用

### 确定 kubernetes 版本号

举个例子，如果你使用 docker 内嵌的 kubernetes，可用在 "About Docker Desktop" 里面查看kubernetes的具体版本号。

### 拉取 kubernetes 镜像

拉取最新版本的镜像:
```
./pull_by_hawsers.sh
```

拉取特定版本的镜像:
```
./pull_by_hawsers.sh -v=<specific_kubernetes_version>
```

使用dockerhub的mirrorgooglecontainers镜像仓:
```
./pull_by_hawsers.sh -g|--mirrorgooglecontainers
```
依赖镜像将会被自动下载及改名.

### 在 Windows 平台运行

请使用git bash来运行这里的脚本.

### 支出的 Kubernetes 版本 

v1.10.0+

### 启动你的 Kubernetes

* Enable Kubernetes Support in Docker
* MiniKube
* ... 

**ENJOY Kubernetes!!!**

### 拉取 Dashboard 镜像

拉取最新版本的Dashboard镜像:
```
./pull_by_hawsers.sh -d|--dashboard
```
拉取最新版本的Dashboard镜像:
```
./pull_by_hawsers.sh -d|--dashboard -v=<specific_kubernetes_version>
```
你可以在yaml文件中找到Dashboard的部署版本.

*当前支持2.0以下的版本*

### 拉取 HELM tiller server 镜像

拉取最新版本的helm tiller镜像:
```
./pull_by_hawsers.sh -h|--helm
```
拉取最新版本的helm tiller镜像:
```
 ./pull_by_hawsers.sh -h|--helm -v=<specific_kubernetes_version>
```
使用helm客户端确定要部署的版本:
```
helm version
```


## 镜像列表

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


## Kubernetes Dashboard 简单指南

### 安装 & 运行 Dashboard 

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
```

### 检查 Dashboard 版本

打开上面URL的内容，查找"image:"，你可以获取镜像及其版本. 例如, 在 https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml 中,
可以找到以下镜像:
```
image: kubernetesui/dashboard:v2.0.0-beta1
```
和
```
image: kubernetesui/metrics-scraper:v1.0.0
```

### 运行 Proxy for Dashboard

你可以通过kubectl命令行工具访问Dashboard:
```
kubectl proxy
```

### 检查 Dashboard 认证使用的 bearer token 

```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```

### 在浏览器中打开 Dashboard URL

```
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```
or
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

## HELM 简单指南

### 检查 Helm 版本

安装完Helm的客户端后输入:
```
helm version
```
可用检查Helm客户端及Tiller服务端的版本，两者应该一致.

### 安装 tiller server

安装 tiller server 的命令:
```
helm init --tiller-image hawsers/kubernetes-helm.tiller:<tag>
```
更新 tiller server 的命令:
```
helm init --upgrade --tiller-image hawsers/kubernetes-helm.tiller:<tag>
```

## 其它指南:

### 版本列表

* In [kubernetes_image_versions.json](https://raw.githubusercontent.com/hawsers/kubernetes_image_mirrors/master/kubernetes_image_versions.json)
* [All kubernetes version](https://github.com/kubernetes/sig-release/tree/master/releases/)
* [All dashboard version](https://github.com/kubernetes/dashboard/releases)

### 镜像名称的破坏式变更

refer to: https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#running-kubeadm-without-an-internet-connection

```In Kubernetes 1.12 and later, the k8s.gcr.io/kube-*, k8s.gcr.io/etcd and k8s.gcr.io/pause images don’t require an -${ARCH} suffix.```


