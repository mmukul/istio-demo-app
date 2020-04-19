#!/bin/bash

# Download Istio on Linux
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.5.1
export PATH=$PWD/bin:$PATH
istioctl manifest apply --set profile=demo

# Demo configuration profile
istioctl manifest apply --set profile=demo

# Label to instruct Istio to automatically inject Envoy sidecar proxies
kubectl label namespace default istio-injection=enabled

# Deploy the Bookinfo sample application
kubectl apply -f book.yaml

# Check Services
kubectl get services

# Check pods
kubectl get pods

# Verify that the app is running inside the cluster and serving HTML pages by checking for the page title in the response
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"

# Associate the application with Istio gateway to accessible from outside
kubectl apply -f book-gateway.yaml

# Check the gateway
kubectl get gateway