# Kubernetes Images Mirror

## Run sh before bootup Kubernetes 

update variables in pull_kubernetes_images_from_mirror.sh:

```
KUBE_VERSION=v1.10.11
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.1.12
DNS_VERSION=1.14.8
DASHBOARD_VERSION=v1.10.1
```

run sh:
```
./pull_kubernetes_images_from_mirror.sh
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