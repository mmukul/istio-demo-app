# istio-demo-app
Deploying an istio-demo bookinfo app on kubernetes


kubectl apply -f book.yaml

kubectl  apply -f book-gateway.yaml

#### Check pods:
kubectl  get pods

#### Check gateway:
kubectl  get svc istio-ingressgateway -n istio-system

#### Check pods have proxy auto-injected
kubectl describe pods -l app=productpage

#### Check proxy processes for the product page
docker container ls --filter name=istio-proxy_productpage* -q

docker container top $(docker container ls --filter name=istio-proxy_productpage* -q)