FROM kkos2display/php-base as fetcher
ARG branch=master
ARG repository=https://github.com/os2display/screen.git

RUN apt-get -y --no-install-recommends install git

# Fetch minimal history
RUN git clone --depth=1 --branch=${branch} ${repository} /var/www/screen
RUN rm -rf /var/www/screen/.git

WORKDIR /var/www/screen

FROM kkos2display/nginx-base

WORKDIR /var/www/screen

COPY config/screen.conf /etc/nginx/sites-enabled/

COPY --from=fetcher /var/www/screen /var/www/screen
COPY config/config.js /var/www/screen/app/config.js
