#!/usr/bin/env bash
set -euxo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"
source "_versions.source"

docker build \
 -t kkos2display/docker-base:"${DOCKER_BASE_TAG}" \
 -f docker-base/Dockerfile \
 --no-cache \
 docker-base

docker build \
 -t kkos2display/php-base:"${PHP_BASE_TAG}" \
 -f php-base/Dockerfile \
 --no-cache \
 php-base

docker build \
 -t kkos2display/nginx-base:"${NGINX_BASE_TAG}" \
 -f nginx-base/Dockerfile \
 --no-cache \
 nginx-base

docker build \
 -t kkos2display/admin-nginx:"${ADMIN_NGINX_TAG}" \
 -f admin-nginx/Dockerfile \
 admin-nginx

docker build \
 -t kkos2display/admin-php:"${ADMIN_PHP_TAG}" \
 -f admin-php/Dockerfile \
 admin-php

docker build \
 -t kkos2display/elasticsearch:"${ELASICSEARCH_TAG}" \
 -f elasticsearch/Dockerfile \
 elasticsearch

docker build \
 -t kkos2display/redis:"${REDIS_TAG}" \
 -f redis/Dockerfile \
 redis

docker build \
 -t kkos2display/node-base:"${NODE_BASE_TAG}" \
 -f node-base/Dockerfile \
 node-base

docker build \
 -t kkos2display/search:"${SEARCH_TAG}" \
 -f search/Dockerfile \
 --build-arg revision=feature/support-non-default-es-host \
 --build-arg repository=https://github.com/kkos2/search_node.git \
 search

docker build \
 -t kkos2display/middleware:"${MIDDLEWARE_TAG}" \
 -f middleware/Dockerfile \
 middleware

docker build \
 -t kkos2display/screen:"${SCREEN_TAG}" \
 -f screen/Dockerfile \
 screen



