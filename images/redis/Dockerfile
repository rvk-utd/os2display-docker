FROM kkos2display/docker-base

RUN apt-get install -y --no-install-recommends redis-server

RUN mkdir /opt/redis
COPY start_redis.sh /opt/redis
COPY config/redis.conf /opt/redis/
RUN chmod +x /opt/redis/start_redis.sh

CMD ["/sbin/my_init", "--skip-runit", "/opt/redis/start_redis.sh"]

EXPOSE 6379
