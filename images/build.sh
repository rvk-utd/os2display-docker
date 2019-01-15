#!/usr/bin/env bash
set -euxo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"
source "_versions.source"

docker build \
 -t kkos2display/docker-base:latest \
 -t kkos2display/docker-base:"${DOCKER_BASE_TAG}" \
 -f docker-base/Dockerfile \
 --no-cache \
 --build-arg base_image="${MAIN_BASE_IMAGE}" \
 docker-base

docker build \
 -t kkos2display/php-base:latest \
 -t kkos2display/php-base:"${PHP_BASE_TAG}" \
 -f php-base/Dockerfile \
 --no-cache \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 php-base

docker build \
 -t kkos2display/nginx-base:latest \
 -t kkos2display/nginx-base:"${NGINX_BASE_TAG}" \
 -f nginx-base/Dockerfile \
 --no-cache \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 nginx-base

docker build \
 -t kkos2display/admin-nginx:latest \
 -t kkos2display/admin-nginx:"${ADMIN_NGINX_TAG}" \
 -f admin-nginx/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 admin-nginx

docker build \
 -t kkos2display/admin-php:latest \
 -t kkos2display/admin-php:"${ADMIN_PHP_TAG}" \
 -f admin-php/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 admin-php

docker build \
 -t kkos2display/elasticsearch:latest \
 -t kkos2display/elasticsearch:"${ELASICSEARCH_TAG}" \
 -f elasticsearch/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 elasticsearch

docker build \
 -t kkos2display/redis:latest \
 -t kkos2display/redis:"${REDIS_TAG}" \
 -f redis/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 redis

docker build \
 -t kkos2display/node-base:latest \
 -t kkos2display/node-base:"${NODE_BASE_TAG}" \
 -f node-base/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 node-base

docker build \
 -t kkos2display/search:latest \
 -t kkos2display/search:"${SEARCH_TAG}" \
 -f search/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 --build-arg revision=feature/support-non-default-es-host \
 --build-arg repository=https://github.com/kkos2/search_node.git \
 search

docker build \
 -t kkos2display/middleware:latest \
 -t kkos2display/middleware:"${MIDDLEWARE_TAG}" \
 -f middleware/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 middleware

docker build \
 -t kkos2display/screen:latest \
 -t kkos2display/screen:"${SCREEN_TAG}" \
 -f screen/Dockerfile \
 --build-arg os2display_image_repository="${KKOS_IMAGE_REPOSITORY}" \
 screen



