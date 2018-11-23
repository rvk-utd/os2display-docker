FROM phusion/baseimage:0.11

ARG es_version=1.7.1
ENV var=${var}

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
## Create a user for the web app.
run addgroup --gid 9999 app
run adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
run usermod -L app
run mkdir -p /home/app/.ssh
run chmod 700 /home/app/.ssh
run chown app:app /home/app/.ssh

# Do a general OS update.
RUN apt-get update
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y --no-install-recommends nodejs npm

RUN npm update npm -g

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=app:app search_node /home/app/search_node
WORKDIR /home/app/search_node

RUN mkdir logs
RUN touch logs/messages.log logs/info.log logs/error.log logs/debug.log logs/socket.log
RUN chown -R app:app logs

COPY --chown=app:app config/config.json /home/app/search_node/config.json
COPY --chown=app:app start_search_node.sh /home/app/search_node/
COPY --chown=app:app config/apikeys.json /home/app/search_node/
COPY --chown=app:app config/mappings.json /home/app/search_node/

RUN ./install.sh

CMD ["/sbin/my_init", "--skip-runit", "./start_search_node.sh"]
EXPOSE 3010
