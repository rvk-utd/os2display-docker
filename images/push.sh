#!/usr/bin/env bash
set -exuo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"
source "_versions.source"

docker push "kkos2display/docker-base:${DOCKER_BASE_TAG}"
docker push "kkos2display/php-base:${PHP_BASE_TAG}"
docker push "kkos2display/nginx-base:${NGINX_BASE_TAG}"
docker push "kkos2display/admin-nginx:${ADMIN_NGINX_TAG}"
docker push "kkos2display/admin-php:${ADMIN_PHP_TAG}"
docker push "kkos2display/elasticsearch:${ELASICSEARCH_TAG}"
docker push "kkos2display/redis:${REDIS_TAG}"
docker push "kkos2display/node-base:${NODE_BASE_TAG}"
docker push "kkos2display/search:${SEARCH_TAG}"
docker push "kkos2display/middleware:${MIDDLEWARE_TAG}"
docker push "kkos2display/screen:${SCREEN_TAG}"

