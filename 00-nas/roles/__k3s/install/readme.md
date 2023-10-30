# Based on https://github.com/k3s-io/k3s-ansible

## Merging kubeconfigs:

```
scp aam@k8s00:~/.kube/config ./config.tmp
KUBECONFIG=~/.kube/config:./config.tmp kubectl config view --flatten
```
