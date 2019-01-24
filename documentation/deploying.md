## Deploying

### Identify yourself with Google Cloud
From the root of the project run `make configure-kubectl`. You only have to do this one time.
This of course assumes you are logged into gcloud.

### Tag the release
When developing for the site, most code is changed in the `development/admin` folder, where the [os2display-admin](https://github.com/rvk-utd/os2display-admin) repo is checked out. When you are done working on a feature there and it is merged to the `bbs-develop` branch you need to tag it and build a release.

Assuming that you are in the `development/admin` folder:

1. Find out what the next tag should be by upping the number on the current tag: `git describe --tags`. We'll refer to it as `MYTAG` here.
2. `git tag MYTAG`
3. `git push origin --tags`

### Build and push the release
Now `cd` to the root of this repo and:

1. `make build-release TAG=MYTAG`
2. `make push-release TAG=MYTAG`
3. Edit the file `provisioning/kubernetes-manifests/static/admin/deployment.yaml` and find the initContainer named `init-copy-source` and bump the tag on it's image to `MYTAG`.
4. Just to be safe, check that you are in the right kubectl context:
`kubectl config get-contexts`. There should be a star next to the name that ends in `os2display-bbs-cluster-1`. If you are in the wrong context, change it with ` kubectl config use-context YOURCONTEXT`.
5. Verify that you have access to the cluster and namespace you are about to deploy to:
```bash
kubectl get --namespace=bbs-pilot1 deployments,pods
```
Consider leaving this overview running in a window while you deploy:
```bash
watch -n 1 kubectl --namespace=bbs-pilot1 get deployments,pods
```
6. Do the actual deployment:
```bash
kubectl apply --namespace=bbs-pilot1 -f provisioning/kubernetes-manifests/static/admin/deployment.yaml
```
7. Commit and push `provisioning/kubernetes-manifests/static/admin/deployment.yaml` to master and you are done! 




