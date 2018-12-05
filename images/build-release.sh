#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $# -eq 0 ]] ; then
    echo "Syntax: $0 <tag>"
    exit 1
fi

TAG=$1

cd "${SCRIPT_DIR}"
docker build \
 -t "kkos2display/admin-release:${TAG}" \
 --no-cache \
 -f admin-release/Dockerfile \
 --build-arg revision="${TAG}" \
 --build-arg repository=https://github.com/kkos2/os2display-admin.git \
 admin-release

