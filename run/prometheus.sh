helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring
# grafana credentials admin:prom-operator
k port-forward deployments/prometheus-grafana 3000 -n monitoring