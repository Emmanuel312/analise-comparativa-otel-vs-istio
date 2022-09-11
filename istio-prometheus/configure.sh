#!bin/bash

kind create cluster --name istio-prometheus
k config use-context kind-istio-prometheus
# install istio and add it in your path 
istioctl install --set profile=minimal -y
k label namespace default istio-injection=enabled
k apply -f ./app/app.yaml 
k apply -f ~/istio-1.14.1/samples/addons/prometheus.yaml
k port-forward deployment/prometheus 9090 -n istio-system
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
# grafana credentials admin:prom-operator
k port-forward deployments/prometheus-grafana 3000