FROM kkos2display/php-base

RUN apt-get install -y --no-install-recommends\
  php5.6-fpm
# Clean out temporary files, notices that you have to a squash to get any gains.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i '/;date.timezone =/c date.timezone = Europe/Copenhagen' /etc/php/5.6/fpm/php.ini
RUN sed -i '/;date.timezone =/c date.timezone = Europe/Copenhagen' /etc/php/5.6/fpm/php.ini

RUN sed -i '/upload_max_filesize = 2M/cupload_max_filesize = 256M' /etc/php/5.6/fpm/php.ini
RUN sed -i '/post_max_size = 8M/cpost_max_size = 300M' /etc/php/5.6/fpm/php.ini

RUN # Set php memory limit to 256mb
RUN sed -i '/memory_limit = 128M/c memory_limit = 256M' /etc/php/5.6/fpm/php.ini

WORKDIR /var/www/admin
RUN mkdir /run/php

COPY config/www.conf /etc/php/5.6/fpm/pool.d/
COPY config/php-fpm.conf /etc/php/5.6/fpm/
COPY start_admin_php.sh /usr/local/sbin/
RUN chmod +x /usr/local/sbin/start_admin_php.sh

RUN mkdir -p web/uploads
RUN mkdir -p app/cache
RUN mkdir -p app/logs
RUN chown -R www-data:www-data web/uploads app/cache app/logs
RUN chmod -R g+w web/uploads app/cache app/logs

USER www-data

USER root
CMD ["/sbin/my_init", "--skip-runit", "/usr/local/sbin/start_admin_php.sh"]
EXPOSE 9000
