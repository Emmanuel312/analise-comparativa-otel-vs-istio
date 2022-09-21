#!bin/bash

# cluster + app
kind create cluster --name istio
k config use-context kind-istio
# install istio and add it in your path 
istioctl install --set profile=minimal -y
k label namespace default istio-injection=enabled
k apply -f ../experiment-01/namespace/sock-shop.yaml
k apply -f ../experiment-01/namespace/monitoring.yaml
k label namespace sock-shop istio-injection=enabled
k apply -f ../experiment-01/istio/app/app.yaml
k port-forward deployments/frontend 8080
k port-forward deployments/frontend 8079 -n sock-shop
# prometheus
k apply -f ~/istio-1.14.1/samples/addons/prometheus.yaml
k port-forward deployment/prometheus 9090 -n istio-system