ARG os2display_image_repository=os2display

FROM ${os2display_image_repository}/docker-base as fetcher

ARG revision=master
ARG repository=https://github.com/search-node/search_node

RUN apt-get update && \
    apt-get -y --no-install-recommends \
      install \
      git \
    && \
    apt-get clean && \
    rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

# Fetch minimal history
RUN git clone --depth=1 --branch=${revision} ${repository} /opt/search_node
RUN rm -rf /opt/middleware/.git

FROM ${os2display_image_repository}/node-base

COPY --chown=app:app  --from=fetcher /opt/search_node /home/app/search_node
WORKDIR /home/app/search_node

RUN mkdir -p logs
RUN touch logs/messages.log logs/info.log logs/error.log logs/debug.log logs/socket.log
RUN chown -R app:app logs

COPY --chown=app:app config/config.json /home/app/search_node/config.json
COPY --chown=app:app config/apikeys.json /home/app/search_node/
COPY --chown=app:app config/mappings.json /home/app/search_node/

RUN ./install.sh

COPY --chown=app:app start_search_node.sh /home/app/search_node/
CMD ["./start_search_node.sh"]
EXPOSE 3010
