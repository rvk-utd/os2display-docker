# Source release and init container.
FROM kkos2display/php-base as fetcher
ARG revision=master
ARG repository=https://github.com/os2display/admin.git

RUN apt-get -y --no-install-recommends install git
RUN rm -rf /var/lib/apt/lists/*


# Fetch minimal history
RUN git clone --depth=1 --branch=${revision} ${repository} /var/www/admin
RUN rm -rf /var/www/admin/.git

WORKDIR /var/www/admin
# TODO - do not run as root
RUN composer install

FROM busybox

RUN mkdir -p /var/www
COPY --chown=root:root --from=fetcher /var/www/admin /var/www/admin

RUN mkdir -p web/uploads
RUN mkdir -p app/cache
RUN mkdir -p app/logs
RUN chown -R www-data:www-data web/uploads app/cache app/logs
RUN chmod -R g+w web/uploads app/cache app/logs

CMD ["/bin/true"]

