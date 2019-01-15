# Multipurpose image, see entrypoint for how to switch.
# FPM: A PHP fpm container that handles all php-requests for the admin-backend
# Jobber: A cron-runner that executes the cron-hooks for symfony every minute.
ARG os2display_image_repository=os2display

# Intermediate step that builds a pinned version of jobber that supports output
# to std-out. Can be replaced with a fetch of a official binary when version
# 1.4 of Jobber is released.
FROM golang:latest as builder
RUN apt-get update
RUN apt-get install -y rsync

RUN mkdir -p src/github.com/dshearer

WORKDIR src/github.com/dshearer
RUN git clone https://github.com/dshearer/jobber.git

WORKDIR jobber
RUN git checkout 260c8df30802384304e067ee52de2942b524326b
RUN make check
RUN make install DESTDIR=/

# Main image.
FROM ${os2display_image_repository}/php-base:latest
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      php5.6-fpm \
    && \
    apt-get clean && \
    rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

# Install wait-for-it application
# https://github.com/vishnubob/wait-for-it
RUN curl -o /usr/local/bin/wait-for-it https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it

WORKDIR /var/www/admin
RUN test -d /run/php || mkdir /run/php

# Pull in docker from the build step.
RUN mkdir -p /usr/local/libexec/
COPY --from=builder /usr/local/libexec/jobbermaster /usr/local/libexec/jobbermaster
COPY --from=builder /usr/local/libexec/jobberrunner /usr/local/libexec/jobberrunner
COPY --from=builder /usr/local/bin/jobber /usr/local/bin/jobber
COPY files/.jobber /root/
RUN chmod a-rwx /root/.jobber && chmod u+rw /root/.jobber

COPY config/www.conf /etc/php/5.6/fpm/pool.d/
COPY config/php-fpm.conf /etc/php/5.6/fpm/

COPY files/etc/ /etc/
COPY files/bin/ /usr/local/bin/

# We set the execution bit explicitly to make it clear what we introduce.
RUN chmod +x /usr/local/bin/xdebug-start
RUN chmod +x /usr/local/bin/jobber-notify.sh
RUN chmod +x /usr/local/bin/jobber-entrypoint.sh
RUN chmod +x /usr/local/bin/fpm-entrypoint.sh
RUN chmod +x /usr/local/bin/run_os2display_cron.sh

# Don't enable xdebug pr. default.
RUN phpdismod xdebug
# Tweak PHP configuration.
RUN phpenmod os2display-php-settings

RUN mkdir -p web/uploads
RUN mkdir -p app/cache
RUN mkdir -p app/logs
RUN chown -R www-data:www-data web/uploads app/cache app/logs
RUN chmod -R g+w web/uploads app/cache app/logs

USER root
ENV APP_ENV=prod

# We default to FPM.
CMD ["/usr/local/bin/fpm-entrypoint.sh"]
EXPOSE 9000

# Use /usr/local/bin/jobber-entrypoint.sh if the container act as cron-
# runner.

