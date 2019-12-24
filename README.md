
## Edit cluster

You can edit cluster or instancegroup.

Edit cluster.

```bash
$ kops edit cluster external-prd.k8s.h3poteto.dev
```

Edit master instancegroup. You have to edit each master instance.

```bash
$ kops edit instancegroup master-ap-northeast-1a --name external-prd.k8s.h3poteto.dev
$ kops edit instancegroup master-ap-northeast-1c --name external-prd.k8s.h3poteto.dev
...
```
Edit node instancegroup.


```bash
$ kops edit instancegroup nodes --name external-prd.k8s.h3poteto.dev
```

## Update cluster
And after that, please update the cluster.

At first, update cluster definition.
Then rolling update the cluster to replace all master and node instances.

```bash
$ kops update cluster --yes --lifecycle-overrides IAMRole=ExistsAndWarnIfChanges,IAMRolePolicy=ExistsAndWarnIfChanges,IAMInstanceProfileRole=ExistsAndWarnIfChanges
```

Sometimes the command show some differences about iam role, please ignore it. I added required policy to role, but kops added the poliyc as inline policy, so the differences are appear. But it is no problem.

```bash
# update master instances
$ kops rolling-update cluster external-prd.k8s.h3poteto.dev --instance-group-roles=Master --force --yes
# update node instances
$ kops rolling-update cluster external-prd.k8s.h3poteto.dev --instance-group-roles=Node --force --yes
```
