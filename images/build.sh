#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${SCRIPT_DIR}"

docker build \
 -t kkos2display/docker-base \
 -f docker-base/Dockerfile \
 docker-base

docker build \
 -t kkos2display/php-base \
 -f php-base/Dockerfile \
 php-base

docker build \
 -t kkos2display/nginx-base \
 -f nginx-base/Dockerfile \
 nginx-base

docker build \
 -t kkos2display/admin-nginx \
 -f admin-nginx/Dockerfile \
 admin-nginx

docker build \
 -t kkos2display/admin-php \
 -f admin-php/Dockerfile \
 admin-php

docker build \
 -t kkos2display/elasticsearch:1.7.1 \
 -f elasticsearch/Dockerfile \
 elasticsearch

docker build \
 -t kkos2display/redis \
 -f redis/Dockerfile \
 redis

docker build \
 -t kkos2display/node-base \
 -f node-base/Dockerfile \
 node-base

docker build \
 -t kkos2display/search:support-non-default-es-host \
 -f search/Dockerfile \
 --build-arg revision=feature/support-non-default-es-host \
 --build-arg repository=https://github.com/kkos2/search_node.git \
 search

docker build \
 -t kkos2display/middleware \
 -f middleware/Dockerfile \
 middleware

docker build \
 -t kkos2display/screen \
 -f screen/Dockerfile \
 screen



