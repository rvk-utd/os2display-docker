#!/bin/sh
# `gosu memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
exec gosu elasticsearch /usr/share/elasticsearch/bin/elasticsearch \
    -Des.pidfile=/var/run/elasticsearch/elasticsearch.pid \
    -Des.default.path.home=/usr/share/elasticsearch \
    -Des.default.path.logs=/var/log/elasticsearch \
    -Des.default.path.data=/var/lib/elasticsearch \
    -Des.default.config=/etc/elasticsearch/elasticsearch.yml \
    -Des.default.path.conf=/etc/elasticsearch
