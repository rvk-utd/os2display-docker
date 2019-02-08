#!/usr/bin/env bash

# Jobbermaster normally creates this, but as we run the runner directly to get
# a cron-runner, we have to create it manually.
if [[ ! -d /var/jobber/0 ]] ; then
  mkdir -p /var/jobber/0
fi

/usr/libexec/jobberrunner -u /var/jobber/0/cmd.sock /root/.jobber
