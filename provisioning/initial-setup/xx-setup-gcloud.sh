#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPT_DIR}/_settings.sh"

gcloud beta container clusters get-credentials "${CLUSTER_NAME}" --region "${REGION}" --project os2display-kff
