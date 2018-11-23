FROM os2-phusion-base

# Do a general OS update.
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update

# Do a general OS update.
RUN apt-get install -y --no-install-recommends\
  php5.6-fpm \
  php5.6-cli \
  php5.6-xdebug \
  php5.6-mysql \
  php5.6-curl \
  php5.6-mbstring \
  php5.6-mcrypt \
  php5.6-gd \
  php5.6-xml \
  php5.6-zip \
  git \
  imagemagick

# Install composer 1.6.5  using the latest installer.
# We compare the downloaded installer with a hash from a second source to reduce
# the chanche we're downloading a compromised installer.
RUN curl -o /tmp/composer-installer https://getcomposer.org/installer && \
  curl -o /tmp/composer-installer.sig https://composer.github.io/installer.sig &&  \
  php -r "if (hash('SHA384', file_get_contents('/tmp/composer-installer')) !== trim(file_get_contents('/tmp/composer-installer.sig'))) { unlink('/tmp/composer-installer'); echo 'Invalid installer' . PHP_EOL; exit(1); }" && \
  php /tmp/composer-installer --version=1.6.5 --filename=composer --install-dir=/usr/local/bin && \
  php -r "unlink('/tmp/composer-installer');" && \
  php -r "unlink('/tmp/composer-installer.sig');"

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i '/;date.timezone =/c date.timezone = Europe/Copenhagen' /etc/php/5.6/fpm/php.ini
RUN sed -i '/;date.timezone =/c date.timezone = Europe/Copenhagen' /etc/php/5.6/fpm/php.ini

RUN sed -i '/upload_max_filesize = 2M/cupload_max_filesize = 256M' /etc/php/5.6/fpm/php.ini
RUN sed -i '/post_max_size = 8M/cpost_max_size = 300M' /etc/php/5.6/fpm/php.ini

RUN # Set php memory limit to 256mb
RUN sed -i '/memory_limit = 128M/c memory_limit = 256M' /etc/php/5.6/fpm/php.ini

COPY --chown=www-data:www-data admin /var/www/admin
WORKDIR /var/www/admin


RUN mkdir /run/php

COPY config/www.conf /etc/php/5.6/fpm/pool.d/
COPY config/php-fpm.conf /etc/php/5.6/fpm/
COPY start_admin_php.sh /usr/local/sbin/
RUN chmod +x /usr/local/sbin/start_admin_php.sh

#TODO
#RUN echo "*/1 * * * * /usr/bin/php /var/www/admin/app/console ik:cron" | crontab -u www-data

RUN mkdir -p web/uploads
RUN mkdir -p app/{cache,logs}
RUN chown -R www-data:www-data web/uploads app/{cache,logs} || exit 1
RUN chmod -R g+w web/uploads app/{cache,logs} || exit 1

COPY --chown=www-data:www-data config/parameters.yml /var/www/admin/app/config/
USER www-data
RUN composer install


USER root
CMD ["/sbin/my_init", "--skip-runit", "/usr/local/sbin/start_admin_php.sh"]
EXPOSE 9000
