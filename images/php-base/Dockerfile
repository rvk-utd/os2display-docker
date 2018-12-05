FROM kkos2display/docker-base

# Do a general OS update.
RUN apt-get update
RUN apt-get install -y --no-install-recommends\
  php5.6-cli \
  php5.6-xdebug \
  php5.6-mysql \
  php5.6-curl \
  php5.6-mbstring \
  php5.6-mcrypt \
  php5.6-gd \
  php5.6-xml \
  php5.6-zip \
  imagemagick \
  git

# Install composer 1.6.5  using the latest installer.
# We compare the downloaded installer with a hash from a second source to reduce
# the chanche we're downloading a compromised installer.
RUN curl -o /tmp/composer-installer https://getcomposer.org/installer && \
  curl -o /tmp/composer-installer.sig https://composer.github.io/installer.sig &&  \
  php -r "if (hash('SHA384', file_get_contents('/tmp/composer-installer')) !== trim(file_get_contents('/tmp/composer-installer.sig'))) { unlink('/tmp/composer-installer'); echo 'Invalid installer' . PHP_EOL; exit(1); }" && \
  php /tmp/composer-installer --version=1.6.5 --filename=composer --install-dir=/usr/local/bin && \
  php -r "unlink('/tmp/composer-installer');" && \
  php -r "unlink('/tmp/composer-installer.sig');"
RUN composer global require hirak/prestissimo
