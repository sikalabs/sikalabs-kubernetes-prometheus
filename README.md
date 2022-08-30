[SikaLabs](https://sikalabs.com) | <opensource@sikalabs.com> | [Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io>

# sikalabs-kubernetes-prometheus

## Setup

Clone repo

```
git clone git@github.com:sikalabs/sikalabs-kubernetes-prometheus.git
cd sikalabs-kubernetes-prometheus
```

Setup helm, longhorn, consul, ingress, maildev

```
make helm
make longhorn
make consul
make ingress
make maildev
```

Create CRDs

```
make crd
```

Use example configuration (values)

```
make copy-example-values
```

Install Prometheus

```
make prom
```

## Example

Apply example

```
kubectl apply -f ./example/
```

### Prometheus

- Service Discovery - https://prometheus.k8s.sikademo.com/service-discovery
- Targets - https://prometheus.k8s.sikademo.com/targets
- Alerts - https://prometheus.k8s.sikademo.com/alerts
- Graph - https://prometheus.k8s.sikademo.com/graph?g0.range_input=1h&g0.expr=example_requests&g0.tab=1

### Grafana

- URL: https://grafana.k8s.sikademo.com
- User: `admin`
- Password: `prom-operator`

Our example dashboard: https://grafana.k8s.sikademo.com/d/ex01/example-dashboard

### Alert Manager

- https://alertmanager.k8s.sikademo.com
- Status - https://alertmanager.k8s.sikademo.com/#/status

### MailDev (Email Client)

- https://mail.k8s.sikademo.com
