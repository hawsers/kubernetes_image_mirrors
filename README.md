# Kubernetes Images Mirror

# Check your docker's kubernetes version
Check kubernetes version in "About Docker Desktop"
![About Docker Desktop](https://user-images.githubusercontent.com/1544010/56942975-f34cdd00-6b4f-11e9-8042-142b8b116419.png)

# List kubernetes image version list
```
kubeadm config images list --kubernetes-version=v1.10.11
```

## Other Version List
* KUBE_VERSION: see above from your docker desktop. other kubernetes version: https://github.com/kubernetes/sig-release/tree/master/releases/
* ETCD_VERSION: https://github.com/kubernetes/kubernetes/blob/master/cluster/images/etcd/migrate-if-needed.sh
* DASHBOARD_VERSION: https://github.com/kubernetes/dashboard/releases
* DNS_VERSION: ?
* KUBE_PAUSE_VERSION: ?

## Run sh before enable Kubernetes 

Update variables in pull_docker_kubernetes_images_from_mirror.sh.
For example:

```
KUBE_VERSION=v1.10.11
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.1.12
DNS_VERSION=1.14.8
DASHBOARD_VERSION=v1.10.1
```

Run sh:
```
./pull_docker_kubernetes_images_from_mirror.sh
```

## Run Local Dashboard 
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
```

## Run Proxy for dashboard
You can access Dashboard using the kubectl command-line tool by running the following command:

```
kubectl proxy
```

## Check bearer token for dashboard authentication
```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```

## Open Local Dashboard URL
```
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

**ENJOY Kubernetes!!!**
