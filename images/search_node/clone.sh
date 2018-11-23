#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${SCRIPT_DIR}"
git clone git@github.com:kkos2/search_node.git
cd search_node
git checkout feature/support-non-default-es-host
