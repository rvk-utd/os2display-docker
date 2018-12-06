#!/bin/sh
# Initscript for kubernetes.
# When used in k8 this container is added as an init-container and is expected
# copy the embedded release-source into release directory and fix any
# necessary permissions.

cp -r /var/www/admin /release/
chown -R www-data:www-data /release/admin/app/logs /release/admin/app/cache
