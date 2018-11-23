#!/bin/sh
exec /sbin/setuser redis /usr/bin/redis-server /opt/redis/redis.conf
