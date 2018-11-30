#!/usr/bin/env bash
# Displays a basic info about how to access and use the site.
set -euo pipefail
IFS=$'\n\t'
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

trap exit_trap SIGINT
function exit_trap {
  # Kill all child-processes
  kill 0
}

kubectl port-forward -n testns $(kubectl get -n testns pod -l "app=admin" -o jsonpath='{.items[0].metadata.name}') 8888:80 &
kubectl port-forward -n testns $(kubectl get -n testns pod -l "app=search" -o jsonpath='{.items[0].metadata.name}') 8880:3010 &
kubectl port-forward -n testns $(kubectl get -n testns pod -l "app=screen" -o jsonpath='{.items[0].metadata.name}') 8800:80 &

# Wait until all child-processes has exited.
wait
