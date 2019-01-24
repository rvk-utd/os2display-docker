# Initial cluster installation
The following describes how to use the scripts in `provisioning/initial-setup`
to provision a GKE Kubernetes cluster and prepare for settings up an actual
installation of OS2display.

The documentation assumes you have the following installed
* The [gcloud sdk](https://cloud.google.com/sdk/install)
* The [Helm client](https://docs.helm.sh/using_helm/#installing-helm)

And that you've created a google cloud project.

1. Edit _settings.sh and fill out the project and cluster details, leave 
   `EXTERNAL_IP` out for now
2. Run `01-setup-cluster.sh` to provision the cluster and IP
3. Run `configure-kubectl.sh` to configure your local kubectl - this might 
   require a couple of tries as the cluster is being provisioned.
4. Verify that the cluster is available by running `kubectl get nodes`
5. Run `02-helm.sh` to prepare the cluster for Helm and install Tiller.
6. Run `get-external-ip.sh`, insert the ip-address listet under "address" in 
   `_settings.sh` and uncomment the line. (Try a couple of times if the IP is 
   not available yet).
7. Run `03-setup-ingress.sh` to install an Ingress controller and certificate 
   manager.

You a now ready to create a namespace and deploy OS2Display to it.

# Install environment
First create a kubernetes namespace
```bash
kubectl create namespace <namespace>
```

Then customize the manifests in `provisioning/kubernetes-manifests/configuration`.
We currently do not have a good solution for handling secrets, so don't commit
the files in configuration, instead keep them somewhere safe or store the 
secrets somewhere else.

Then ensure all image-references in `provisioning/kubernetes-manifests/static`
are as you expect, in particular take notice of 
`provisioning/kubernetes-manifests/configuration/admin/deployment.yml`

Then apply the manifests
`kubectl apply --recursive -n <namespace> provisioning/kubernetes-manifests`

See [Deploying](deploying.md) on how to do the subsequent deployments. 
