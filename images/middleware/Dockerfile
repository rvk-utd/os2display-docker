ARG os2display_image_repository=os2display

FROM ${os2display_image_repository}/docker-base as fetcher
ARG revision=5.0.2
ARG repository=https://github.com/os2display/middleware

RUN apt-get update
RUN apt-get -y --no-install-recommends install git

# Fetch minimal history
RUN git clone --depth=1 --branch=${revision} ${repository} /opt/middleware
RUN rm -rf /opt/middleware/.git

FROM ${os2display_image_repository}/node-base

COPY --chown=app:app  --from=fetcher /opt/middleware /home/app/middleware
WORKDIR /home/app/middleware

RUN mkdir logs
RUN touch logs/messages.log logs/info.log logs/error.log logs/debug.log logs/socket.log
RUN chown -R app:app logs

COPY --chown=app:app config/config.json ./
COPY --chown=app:app config/apikeys.json ./
COPY --chown=app:app start_middleware.sh ./

RUN ./install.sh

CMD ["./start_middleware.sh"]
EXPOSE 3020
