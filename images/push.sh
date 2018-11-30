#!/usr/bin/env bash
set -exuo pipefail

docker push kkos2display/docker-base:latest
docker push kkos2display/php-base:latest
docker push kkos2display/nginx-base:latest
docker push kkos2display/admin-nginx:latest
docker push kkos2display/admin-php:latest
docker push kkos2display/admin-release:latest
docker push kkos2display/elasticsearch:1.7.1
docker push kkos2display/redis:latest
docker push kkos2display/node-base:latest
docker push kkos2display/search:support-non-default-es-host
docker push kkos2display/middleware:latest
docker push kkos2display/screen:latest
