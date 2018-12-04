#!/usr/bin/env bash

set -euxo pipefail
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPT_DIR}/_settings.sh"

helm install \
    --name nginx-ingress stable/nginx-ingress \
    --set rbac.create=true \
    --set controller.service.loadBalancerIP="${EXTERNAL_IP}"

helm install \
    --name cert-manager \
    --namespace kube-system \
    stable/cert-manager
