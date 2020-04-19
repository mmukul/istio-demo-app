#!/bin/bash

# Download Istio on Linux
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.5.1
export PATH="$PATH:/root/istio-demo-app/istio-1.5.1/bin
istioctl verify-install
istioctl manifest apply --set profile=demo


# Demo configuration profile
istioctl manifest apply --set profile=demo

# Label to instruct Istio to automatically inject Envoy sidecar proxies
kubectl label namespace default istio-injection=enabled

# Deploy the Bookinfo sample application
kubectl apply -f $HOME/book.yaml

# Check Services
kubectl get services

# Check pods
kubectl get pods

# Associate the application with Istio gateway to accessible from outside
kubectl apply -f $HOME/book-gateway.yaml

# Verify that the app is running inside the cluster and serving HTML pages by checking for the page title in the response
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"

# Check the gateway
kubectl get gateway

# Determining the ingress details
kubectl get svc istio-ingressgateway -n istio-system