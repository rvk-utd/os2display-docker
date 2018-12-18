#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]] ; then
    echo "Syntax: $0 <tag>"
    exit 1
fi

TAG=$1
set -x
docker push "kkos2display/admin-release:${TAG}" 
docker push "kkos2display/admin-release:latest" 
