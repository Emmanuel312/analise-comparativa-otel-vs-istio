#!bin/bash

kind create cluster --name istio-prometheus
k config use-context kind-istio-prometheus
# install istio and add it in your path 
istioctl install --set profile=demo -y
k label namespace default istio-injection=enabled
k apply -f ./app/app.yaml 
k apply -f ~/istio-1.14.1/samples/addons/prometheus.yaml
k port-forward deployment/prometheus 9090 -n istio-system