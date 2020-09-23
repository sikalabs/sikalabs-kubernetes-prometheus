# ondrejsika-k8s-prom

## Setup

Clone repo

```
git clone git@github.com:ondrejsika/ondrejsika-k8s-prom.git
cd ondrejsika-k8s-prom
```

Setup helm, longhorn, consul, ingress

```
make helm
make longhorn
make consul
make ingress
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

- https://maildev.k8s.sikademo.com
