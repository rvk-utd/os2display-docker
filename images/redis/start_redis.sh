#!/bin/sh
exec gosu redis /usr/bin/redis-server /opt/redis/redis.conf
