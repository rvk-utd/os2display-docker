ARG os2display_image_repository=os2display

FROM ${os2display_image_repository}/docker-base
# Install elasticsearch from the official source.

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openjdk-8-jre \
     && \
    apt-get clean && \
    rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

ARG es_version=1.7.1
RUN curl -o /tmp/elasticsearch.deb https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${es_version}.deb
RUN dpkg -i /tmp/elasticsearch.deb
RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.5.0

COPY start_elasticsearch.sh /usr/share/elasticsearch/start_elasticsearch.sh
WORKDIR /usr/share/elasticsearch

CMD ["./start_elasticsearch.sh"]

EXPOSE 9200
