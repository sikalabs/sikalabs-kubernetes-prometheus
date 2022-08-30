PROMETHEUS_OPERATOR_VERSION = v0.58.0

cluster-setup:
	slu scripts kubernetes install-ingress --use-proxy-protocol
	slu scripts kubernetes install-cert-manager
	slu scripts kubernetes install-cluster-issuer

longhorn:
	kubectl delete sc --all
	kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/longhorn.yaml
	kubectl patch storageclass longhorn -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

longhorn-ingress:
	kubectl apply -f longhorn-ingress.yml

maildev:
	helm upgrade --install -n maildev --create-namespace maildev maildev --repo https://helm.sikalabs.io --set host=mail.k8s.sikademo.com

crd:
	kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/$(PROMETHEUS_OPERATOR_VERSION)/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
	kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/$(PROMETHEUS_OPERATOR_VERSION)/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
	kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/$(PROMETHEUS_OPERATOR_VERSION)/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
	kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/$(PROMETHEUS_OPERATOR_VERSION)/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
	kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/$(PROMETHEUS_OPERATOR_VERSION)/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
	kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/$(PROMETHEUS_OPERATOR_VERSION)/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml

copy-example-values:
	cp values/prom/ingress.example.yml values/prom/ingress.yml
	cp values/prom/alertmanager-config.example.yml values/prom/alertmanager-config.yml

prom:
	@make _prom EXTRA_ARGS="-f values/prom/disable-digitalocean.yml"

prom-disable-defaults:
	@make _prom EXTRA_ARGS="-f values/prom/disable-defaults.yml"

_prom:
	helm upgrade --install \
		prometheus-stack kube-prometheus-stack \
		--repo https://prometheus-community.github.io/helm-charts \
		-n prometheus-stack \
		--create-namespace \
		-f values/prom/general.yml \
		-f values/prom/ingress.yml \
		-f values/prom/alertmanager-config.yml ${EXTRA_ARGS}

prom-get-values:
	helm get values prometheus-stack -n prometheus-stack

prom-uninstall:
	helm uninstall -n prometheus-stack prometheus-stack

reload:
	curl -X POST https://prometheus.k8s.sikademo.com/-/reload
	curl -X POST https://alertmanager.k8s.sikademo.com/-/reload
