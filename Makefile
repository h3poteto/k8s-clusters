.PONY: install encrypt decrypt

install:
	bundle install --path vendor/bundle

encrypt: install
	./vault encrypt ./external-prd-20210225/cluster.yaml ./external-prd-20210225/encrypted-cluster.yaml $$.spec.fileAssets
	./vault encrypt ./external-prd-20210225/encrypted-cluster.yaml ./external-prd-20210225/encrypted-cluster.yaml $$.spec.kubeAPIServer

decrypt: install
	./vault decrypt ./external-prd-20210225/encrypted-cluster.yaml ./external-prd-20210225/cluster.yaml $$.spec.kubeAPIServer
	./vault decrypt ./external-prd-20210225/cluster.yaml ./external-prd-20210225/cluster.yaml $$.spec.fileAssets
