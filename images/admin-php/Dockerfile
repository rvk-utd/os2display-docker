FROM kkos2display/php-base

RUN apt-get update
RUN apt-get install -y --no-install-recommends\
  php5.6-fpm
# Clean out temporary files, notices that you have to a squash to get any gains.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /var/www/admin
RUN mkdir /run/php

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
CMD ["/sbin/my_init", "--skip-runit", "/usr/local/sbin/start_admin_php.sh"]
EXPOSE 9000
