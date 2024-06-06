[SikaLabs](https://sikalabs.com) | <opensource@sikalabs.com> | [Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io>

# sikalabs-kubernetes-prometheus

## Setup

Clone repo

```
git clone git@github.com:sikalabs/sikalabs-kubernetes-prometheus.git
cd sikalabs-kubernetes-prometheus
```

Setup helm, longhorn, maildev

```
make cluster-setup
make longhorn
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

See: https://metrics-example.k8s.sikademo.com/

### Prometheus

- Service Discovery - https://prometheus.k8s.sikademo.com/service-discovery
- Targets - https://prometheus.k8s.sikademo.com/targets
- Alerts - https://prometheus.k8s.sikademo.com/alerts
- Graph - https://prometheus.k8s.sikademo.com/graph?g0.range_input=1h&g0.expr=hello_world_server_requests_total&g0.tab=1

### Grafana

- URL: https://grafana.k8s.sikademo.com
- User: `admin`
- Password: `admin`

Our example dashboard: https://grafana.k8s.sikademo.com/d/example-dashboard/example-dashboard

### Alert Manager

- https://alertmanager.k8s.sikademo.com
- Status - https://alertmanager.k8s.sikademo.com/#/status

### MailDev (Email Client)

- https://mail.k8s.sikademo.com
