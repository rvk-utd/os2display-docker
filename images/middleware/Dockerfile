FROM phusion/baseimage:0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
## Create a user for the web app.
RUN addgroup --gid 9999 app
RUN adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
RUN usermod -L app
RUN mkdir -p /home/app/.ssh
RUN chmod 700 /home/app/.ssh
RUN chown app:app /home/app/.ssh

# Do a general OS update.
RUN apt-get update
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y --no-install-recommends nodejs npm

RUN npm update npm -g

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=app:app middleware /home/app/middleware
WORKDIR /home/app/middleware
RUN mkdir logs
RUN touch logs/messages.log logs/info.log logs/error.log logs/debug.log logs/socket.log
RUN chown -R app:app logs

COPY --chown=app:app config/config.json ./
COPY --chown=app:app config/apikeys.json ./
COPY --chown=app:app start_middleware.sh ./

RUN ./install.sh

CMD ["/sbin/my_init", "--skip-runit", "./start_middleware.sh"]
EXPOSE 3020
