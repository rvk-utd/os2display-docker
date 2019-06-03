#!/usr/bin/env bash
#
# The location of console changed during release 6.x, this script acts as a
# proxy, executing console wherever we can find it.
#
set -euo pipefail

if [[ -x app/console ]]; then
  CONSOLE="app/console"
elif [[ -x bin/console ]]; then
  CONSOLE="bin/console"
else
  echo "Could not find console"
  exit 1
fi

exec $CONSOLE "$@"
