FROM phusion/baseimage:0.11

ARG es_version=1.7.1

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Do a general OS update.
RUN apt-get update
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y --no-install-recommends openjdk-8-jre

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /etc/service/elasticsearch
COPY start_elasticsearch.sh /usr/share/elasticsearch/start_elasticsearch.sh
WORKDIR /usr/share/elasticsearch

ADD https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${es_version}.deb /tmp/elasticsearch.deb
RUN dpkg -i /tmp/elasticsearch.deb
RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.5.0

CMD ["/sbin/my_init", "--skip-runit", "./start_elasticsearch.sh"]

EXPOSE 9200
