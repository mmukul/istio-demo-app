# Helloworld service

This sample includes two versions of a simple helloworld service that returns its version
and instance (hostname) when called.It can be used as a test service when experimenting with version routing.

## Start the helloworld service

To run both versions of the helloworld service, use the following command:

```bash
kubectl apply -f helloworld.yaml
```

Alternatively, you can run just one version at a time by first defining the service:

```bash
kubectl apply -f helloworld.yaml -l app=helloworld
```

and then deploying version v1, v2, or both:

```bash
kubectl apply -f helloworld.yaml -l version=v1
kubectl apply -f helloworld.yaml -l version=v2
```

## Configure the helloworld-demo gateway

Apply the helloworld gateway configuration:

```bash
kubectl apply -f helloworld-gateway.yaml
```

to set the INGRESS_HOST and INGRESS_PORT variables and then confirm the sample is running using curl:

```bash
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
curl http://$GATEWAY_URL/hello
```

## Autoscale the services

Enable autoscaling on both versions of the service:

```bash
kubectl autoscale deployment helloworld-v1 --cpu-percent=50 --min=1 --max=10
kubectl autoscale deployment helloworld-v2 --cpu-percent=50 --min=1 --max=10
kubectl get hpa
```

Now generate some load on the helloworld service, we would notice that when scaling begins, the v1 autoscaler will scale up its replicas significantly higher than the v2 autoscaler replicas because v1 pods are handling 90% of the load.

~~~bash
kubectl get pods | grep helloworld
~~~

## Cleanup

```bash
kubectl delete -f helloworld.yaml
kubectl delete -f helloworld-gateway.yaml
kubectl delete hpa helloworld-v1 helloworld-v2
```