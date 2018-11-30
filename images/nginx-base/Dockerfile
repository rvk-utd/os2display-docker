FROM kkos2display/docker-base

RUN apt-get install -y --no-install-recommends nginx
# Clean out temporary files, notices that you have to a squash to get any gains.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Disable the default site which will make our site the default.
RUN unlink /etc/nginx/sites-enabled/default

COPY start_nginx.sh /usr/local/sbin/

EXPOSE 80
CMD ["/sbin/my_init", "--skip-runit", "/usr/local/sbin/start_nginx.sh"]
