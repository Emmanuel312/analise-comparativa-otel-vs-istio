#!bin/bash

kind create cluster --name otel
k config use-context kind-otel
k apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
k apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
k apply -f global-collector/collector-config-map.yaml
k apply -f global-collector/otel-collector.yaml
k apply -f global-collector/otel-collector-service.yaml
k apply -f otel-operator/otel-instrumentation.yaml
k apply -f otel-operator/otel-sidecar.yaml
k apply -f app/app.yaml
k apply -f prometheus/prometheus-config-map.yaml 
k apply -f prometheus/prometheus.yaml
k port-forward deployments/prometheus 9090
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
# grafana credentials admin:prom-operator
k port-forward deployments/prometheus-grafana 3000