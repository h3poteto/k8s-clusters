## Create cluster
```
$ kops create cluster $CLUSTER_NAME --zones ap-northeast-1a,ap-northeast-1c,ap-northeast-1d --node-count 3 --master-zones ap-northeast-1a,ap-northeast-1c,ap-northeast-1d --node-size t3.medium --master-size t3.small
```

Edit this cluster before apply. And apply it.

```
$ kops update cluster --name $CLUSTER_NAME --create-kube-config --admin --yes
```


## Edit cluster

You can edit cluster or instancegroup.

Edit cluster.

```bash
$ kops edit cluster $CLUSTER_NAME
```

Edit master instancegroup. You have to edit each master instance.

```bash
$ kops edit instancegroup master-ap-northeast-1a --name external-prd-20200329.k8s.h3poteto.dev
$ kops edit instancegroup master-ap-northeast-1c --name external-prd-20200329.k8s.h3poteto.dev
...
```
Edit node instancegroup.


```bash
$ kops edit instancegroup nodes --name external-prd-20200329.k8s.h3poteto.dev
```

## Update cluster
And after that, please update the cluster.

At first, update cluster definition.
Then rolling update the cluster to replace all master and node instances.

```bash
$ kops update cluster --yes --admin --create-kube-config
```

Sometimes the command show some differences about iam role, please ignore it. I added required policy to role, but kops added the poliyc as inline policy, so the differences are appear. But it is no problem.

```bash
# update master instances
$ kops rolling-update cluster external-prd-20200329.k8s.h3poteto.dev --instance-group-roles=control-plane --force --yes
# update node instances
$ kops rolling-update cluster external-prd-20200329.k8s.h3poteto.dev --instance-group-roles=node --force --yes
```
