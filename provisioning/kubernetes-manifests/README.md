# Environment setup
```
kubectl create namespace <namespace>
kubectl apply -n <namespace> kubectl apply -n production --recursive  -f ./
<wait a bit>
kubectl exec \
  -n <namespace> \
  -ti \
  --container=admin-php \
  $(kubectl get pods --selector=app=admin -o jsonpath='{.items[0].metadata.name}') \
  tools/init-environment.sh <admin username> <admin email> <admin password> <search apikey> <admin search index id>
```
