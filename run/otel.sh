#!bin/bash

# cluster + app
kind create cluster --name otel --image=kindest/node:v1.19.16
k config use-context kind-otel
k apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
k apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
k apply -f ../experiment-08/otel/global-collector/collector-config-map.yaml
k apply -f ../experiment-08/otel/global-collector/otel-collector.yaml
k apply -f ../experiment-08/otel/global-collector/otel-collector-service.yaml
k apply -f ../experiment-08/namespace/sock-shop.yaml
k apply -f ../experiment-08/namespace/monitoring.yaml
k apply -f ../experiment-08/otel/otel-operator/otel-instrumentation.yaml
k apply -f ../experiment-08/otel/otel-operator/otel-sidecar.yaml
k apply -f ../experiment-08/otel/app/app.yaml
k port-forward deployments/frontend 8080
k port-forward deployments/frontend 8079 -n sock-shop
jmeter -n -t ../experiment-08/load-test/load-test.jmx 
# prometheus 
k apply -f prometheus/prometheus-config-map.yaml 
k apply -f prometheus/prometheus.yaml
k port-forward deployments/prometheus 9090