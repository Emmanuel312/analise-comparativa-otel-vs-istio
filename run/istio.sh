#!bin/bash

# cluster + app
kind create cluster --name istio --image=kindest/node:v1.19.16
k config use-context kind-istio
# install istio and add it in your path 
istioctl install --set profile=default --set values.telemetry.v2.enabled=false -y
k label namespace default istio-injection=enabled
k apply -f ../experiment-08/namespace/sock-shop.yaml
k apply -f ../experiment-08/namespace/monitoring.yaml
k label namespace sock-shop istio-injection=enabled
k apply -f ../experiment-08/istio/app/app.yaml
k port-forward deployments/frontend 8080
k port-forward deployments/frontend 8079 -n sock-shop
jmeter -n -t ../experiment-08/load-test/load-test.jmx 
# prometheus
k apply -f ~/istio-1.15.0/samples/addons/prometheus.yaml
k port-forward deployment/prometheus 9090 -n istio-system