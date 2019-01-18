#!/usr/bin/env bash

set -euxo pipefail

# GCloud settings
PROJECT_ID="os2display-bbs"
REGION="europe-west2"
ZONE="europe-west2-b"
ADDRESS_NAME="os2display-ingress-ip"
# Cluster settings
CLUSTER_NAME="os2display-bbs-cluster-1"
MACHINE_TYPE="n1-standard-4"
CLUSTER_VER="1.11.6-gke.2"
NUM_NODES=1
MAINTENANCE="02:30" # UTC
# Set this after running 01-setup-cluster.sh
EXTERNAL_IP="35.246.27.206"
