FROM phusion/baseimage:0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Do a general OS update.
RUN apt-get update
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y --no-install-recommends redis-server

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /opt/redis
COPY start_redis.sh /opt/redis
COPY config/redis.conf /opt/redis/
RUN chmod +x /opt/redis/start_redis.sh

CMD ["/sbin/my_init", "--skip-runit", "/opt/redis/start_redis.sh"]

EXPOSE 6379
