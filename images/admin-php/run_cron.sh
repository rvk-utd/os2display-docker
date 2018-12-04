#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $# -eq 0 ]] ; then
    echo "Syntax: $0 <environment>"
    exit 1
fi

cd /var/www/admin
app/console --env="$1" os2display:core:cron
