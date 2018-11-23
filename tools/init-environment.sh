#!/usr/bin/env bash
set -exuo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Candidate for a init-container for admin_php
docker-compose exec admin_php bash -c "
  echo moo
  sudo -u www-data app/console doctrine:migrations:migrate --no-interaction && \
  sudo -u www-data app/console os2display:core:templates:load && \
  sudo -u www-data app/console doctrine:query:sql \"UPDATE ik_screen_templates SET enabled=1;\" && \
  sudo -u www-data app/console doctrine:query:sql \"UPDATE ik_slide_templates SET enabled=1;\" && \
  app/console fos:user:create admin admin@admin.os2display.vm admin --super-admin
"
