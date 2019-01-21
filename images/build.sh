#!/usr/bin/env bash
set -euxo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"
source "_versions.source"

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/docker-base:latest \
 -f docker-base/Dockerfile \
 --no-cache \
 --build-arg base_image="${MAIN_BASE_IMAGE}" \
 docker-base

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/php-base:latest \
 -f php-base/Dockerfile \
 --no-cache \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 php-base

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/nginx-base:latest \
 -f nginx-base/Dockerfile \
 --no-cache \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 nginx-base

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/admin-nginx:"${ADMIN_NGINX_BUILD_TAG}" \
 -f admin-nginx/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 admin-nginx

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/admin-php:"${ADMIN_PHP_BUILD_TAG}" \
 -f admin-php/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 admin-php

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/elasticsearch:"${ELASTICSEARCH_SOURCE_TAG}-${ELASTICSEARCH_BUILD_TAG}" \
 -f elasticsearch/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 elasticsearch

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/redis:"${REDIS_SOURCE_TAG}-${REDIS_BUILD_TAG}" \
 -f redis/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 redis

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/node-base:latest \
 -f node-base/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 node-base

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/search:"${SEARCH_SOURCE_TAG}-${SEARCH_BUILD_TAG}" \
 -f search/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 --build-arg repository="${SEARCH_REPOSITORY}"  \
 --build-arg revision="${SEARCH_SOURCE_TAG}" \
 search

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/middleware:"${MIDDLEWARE_SOURCE_TAG}-${MIDDLEWARE_BUILD_TAG}" \
 -f middleware/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 --build-arg repository="${MIDDLEWARE_REPOSITORY}" \
 --build-arg revision="${MIDDLEWARE_SOURCE_TAG}" \
 middleware

docker build \
 -t ${MAIN_IMAGE_REPOSITORY}/screen:"${SCREEN_SOURCE_TAG}-${SCREEN_BUILD_TAG}" \
 -f screen/Dockerfile \
 --build-arg os2display_image_repository="${MAIN_IMAGE_REPOSITORY}" \
 --build-arg revison="${SCREEN_SOURCE_TAG}" \
 screen



