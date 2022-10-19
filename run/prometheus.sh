helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring
# grafana credentials admin:prom-operator

k port-forward prometheus-prometheus-kube-prometheus-prometheus-0 9090 -n monitoring
k port-forward deployments/prometheus-grafana 3000 -n monitoring