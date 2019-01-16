ARG os2display_image_repository=os2display

FROM ${os2display_image_repository}/docker-base

RUN apt-get update
RUN apt-get install -y --no-install-recommends nginx
# Clean out temporary files, notices that you have to a squash to get any gains.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Disable the default site which will make our site the default.
RUN unlink /etc/nginx/sites-enabled/default

# Following section is taken from the official nginx images

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
