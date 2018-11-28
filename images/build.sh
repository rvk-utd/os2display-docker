#!/usr/bin/env bash
set -exuo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${SCRIPT_DIR}"

docker build \
 -t os2display/docker-base \
 -f docker-base/Dockerfile \
 docker-base

docker build \
 -t os2display/php-base \
 -f php-base/Dockerfile \
 php-base

docker build \
 -t os2display/nginx-base \
 -f nginx-base/Dockerfile \
 nginx-base

docker build \
 -t os2display/admin-nginx \
 -f admin-nginx/Dockerfile \
 admin-nginx

docker build \
 -t os2display/admin-php \
 -f admin-php/Dockerfile \
 admin-php

docker build \
 -t os2display/admin-release \
 -f admin-release/Dockerfile \
 --build-arg branch=kk-develop \
 --build-arg repository=https://github.com/kkos2/os2display-admin.git \
 admin-release

docker build \
 -t os2display/elasticsearch \
 -f elasticsearch/Dockerfile \
 elasticsearch

docker build \
 -t os2display/redis \
 -f redis/Dockerfile \
 redis

docker build \
 -t os2display/node-base \
 -f node-base/Dockerfile \
 node-base

docker build \
 -t os2display/search_node \
 -f search_node/Dockerfile \
 --build-arg branch=feature/support-non-default-es-host \
 --build-arg repository=https://github.com/kkos2/search_node.git \
 search_node

docker build \
 -t os2display/middleware \
 -f middleware/Dockerfile \
 middleware

docker build \
 -t os2display/screen \
 -f screen/Dockerfile \
 screen



