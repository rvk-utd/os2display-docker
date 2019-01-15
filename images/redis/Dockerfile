ARG os2display_image_repository=os2display

FROM ${os2display_image_repository}/docker-base

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      redis=5:4.0.9\* \
    && \
    apt-get clean && \
    rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

RUN mkdir /opt/redis
COPY start_redis.sh /opt/redis
COPY config/redis.conf /opt/redis/
RUN chmod +x /opt/redis/start_redis.sh

CMD ["/opt/redis/start_redis.sh"]

EXPOSE 6379
