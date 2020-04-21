# Helloworld service

This sample includes two versions of a simple helloworld service that returns its version
and instance (hostname) when called.It can be used as a test service when experimenting with version routing.

## Start the helloworld-demo service

To run both versions of the helloworld service, use the following command:

```bash
kubectl apply -f helloworld-demo.yaml
```

Alternatively, you can run just one version at a time by first defining the service:

```bash
kubectl apply -f helloworld-demo.yaml -l app=helloworld
```

and then deploying version v1, v2, or both:

```bash
kubectl apply -f helloworld-demo.yaml -l version=v1
kubectl apply -f helloworld-demo.yaml -l version=v2
```

## Configure the helloworld-demo gateway

Apply the helloworld gateway configuration:

```bash
kubectl apply -f helloworld-demo-gateway.yaml
```

to set the INGRESS_HOST and INGRESS_PORT variables and then confirm the sample is running using curl:

```bash
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
curl http://$GATEWAY_URL/hello
```

## Autoscale the services

Note that a Kubernetes "Horizontal Pod Autoscaler" only works if all containers in the pods request cpu. In this sample the deployment containers in `helloworld.yaml` are configured with the request.
The injected istio-proxy containers also include cpu requests,making the helloworld service ready for autoscaling.

Enable autoscaling on both versions of the service:

```bash
kubectl autoscale deployment helloworld-v1 --cpu-percent=50 --min=1 --max=10
kubectl autoscale deployment helloworld-v2 --cpu-percent=50 --min=1 --max=10
kubectl get hpa
```

## Cleanup

```bash
kubectl delete -f helloworld.yaml
kubectl delete -f helloworld-gateway.yaml
kubectl delete hpa helloworld-v1 helloworld-v2
```