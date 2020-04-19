#!/bin/bash

# Download Istio on Linux
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.5.1
export PATH=$PWD/bin:$PATH
export PATH="$PATH:/root/istio-demo-app/istio-1.5.1/bin"

# Demo configuration profile
istioctl manifest apply --set profile=demo

# Label to instruct Istio to automatically inject Envoy sidecar proxies
kubectl label namespace default istio-injection=enabled