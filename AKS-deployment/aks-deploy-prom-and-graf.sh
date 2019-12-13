# Install helm if it's not already
if ! [ -x "$(command -v helm)" ]; then
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh | bash || \
    echo "Helm is not installed and for some reason couldn't be installed, please check the logs for the specific error and try to install it manually" && exit 1
fi

# Create Tiller Service Account and Apply ClusterRoleBinding
kubectl apply -f prom-rbactillerconfig.yml

# Add the Core OS Helm Repo in case it is not already installed
helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/

# Create a new Monitoring Namespace to deploy Prometheus Operator too
kubectl create namespace monitoring

# Install Prometheus Operator
helm install prometheus-operator coreos/prometheus-operator --namespace monitoring
kubectl -n monitoring get all -l "release=prometheus-operator"

# Install Prometheus Configuration and Setup for Kubernetes
helm install kube-prometheus coreos/kube-prometheus --namespace monitoring
kubectl -n monitoring get all -l "release=kube-prometheus"

# Update Container Image in Deployment manifest (prom-graf-sample-go-app.yml)
kubectl apply -f prom-graf-sample-go-app.yml -n sample-app

# Deploy the ServiceMonitor to Monitor the app
kubectl apply -f prom-graf-servicemonitor.yml -n monitoring

# Deploy the ConfigMap to Raise Alerts for the app
kubectl apply -f prom-graf-configmap.yml -n monitoring

# Check to see that all the Pods are running
kubectl get pods -n monitoring

# Other Useful Prometheus Operator Resources to Peruse
# kubectl get prometheus -n monitoring
# kubectl get prometheusrules -n monitoring
# kubectl get servicemonitor -n monitoring
# kubectl get cm -n monitoring
# kubectl get secrets -n monitoring

# ------------------------
# TODO: manually

# Change the snippet to be a LoadBalancer instead of a ClusterIP
# kubectl edit service kube-prometheus -n monitoring

# repeat for Alert Manager
# kubectl edit service kube-prometheus-alertmanager -n monitoring

# repeat for Grafana
# kubectl edit service kube-prometheus-grafana -n monitoring

# Get your public IP address for the Prometheus dashboard
# kubectl get service kube-prometheus -n monitoring

# Get your public IP address for the Prometheus Alert Manager
# kubectl get service kube-prometheus-alertmanager -n monitoring

# Get your public IP address for Grafana
# kubectl get service kube-prometheus-grafana -n monitoring

#! These settings should not generally be used in production.
#! The endpoints should be secured behind an Ingress.

