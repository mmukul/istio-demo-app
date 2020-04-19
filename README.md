# Setup & prepare istio environment

./deploy-istio-v1.sh

### Deploying an istio-demo app v1 on kubernetes

kubectl apply -f bookapp.yaml

### Check Services
kubectl get services

### Check pods
kubectl get pods

### Associate the application with Istio gateway to accessible from outside
kubectl apply -f $HOME/ingress-gateway.yaml

### Verify that the app is running inside the cluster and serving HTML pages by checking for the page title in the response
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"

### Check the gateway
kubectl get gateway

### Determining the ingress details
kubectl get svc istio-ingressgateway -n istio-system