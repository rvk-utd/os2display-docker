FROM kkos2display/php-base:latest

RUN apt-get update
RUN apt-get install -y --no-install-recommends php5.6-fpm

WORKDIR /var/www/admin
RUN test -d /run/php || mkdir /run/php

COPY config/www.conf /etc/php/5.6/fpm/pool.d/
COPY config/php-fpm.conf /etc/php/5.6/fpm/
COPY start_admin_php.sh /usr/local/sbin/
COPY run_cron.sh /usr/local/sbin/
RUN chmod +x /usr/local/sbin/start_admin_php.sh
RUN chmod +x /usr/local/sbin/run_cron.sh

# Don't enable xdebug pr default.
COPY files/etc/ /etc/
COPY files/bin/xdebug-start /usr/local/bin/
RUN chmod +x /usr/local/bin/xdebug-start
RUN phpdismod xdebug
RUN phpenmod os2display-php-settings

RUN mkdir -p web/uploads
RUN mkdir -p app/cache
RUN mkdir -p app/logs
RUN chown -R www-data:www-data web/uploads app/cache app/logs
RUN chmod -R g+w web/uploads app/cache app/logs

USER root

ENV ENV=prod
# Default to starting up fpm-hosting. If this is a cron-run override the entrypoint
# and run /sbin/my_init.
CMD ["/sbin/my_init", "--skip-runit", "/usr/local/sbin/start_admin_php.sh"]
EXPOSE 9000
