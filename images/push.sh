#!/usr/bin/env bash
set -exuo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"
source "../_variables.source"

set -x
docker push "${MAIN_IMAGE_REPOSITORY}/admin-nginx:${ADMIN_NGINX_BUILD_TAG}"
docker push "${MAIN_IMAGE_REPOSITORY}/admin-php:${ADMIN_PHP_BUILD_TAG}"
docker push "${MAIN_IMAGE_REPOSITORY}/elasticsearch:${ELASTICSEARCH_SOURCE_TAG}-${ELASTICSEARCH_BUILD_TAG}"
docker push "${MAIN_IMAGE_REPOSITORY}/redis:${REDIS_SOURCE_TAG}-${REDIS_BUILD_TAG}"
docker push "${MAIN_IMAGE_REPOSITORY}/search:${SEARCH_SOURCE_TAG}-${SEARCH_BUILD_TAG}"
docker push "${MAIN_IMAGE_REPOSITORY}/middleware:${MIDDLEWARE_SOURCE_TAG}-${MIDDLEWARE_BUILD_TAG}"
docker push "${MAIN_IMAGE_REPOSITORY}/screen:${SCREEN_SOURCE_TAG}-${SCREEN_BUILD_TAG}"

