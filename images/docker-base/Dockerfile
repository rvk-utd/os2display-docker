FROM phusion/baseimage:0.11

# Do a general OS update.
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y --no-install-recommends sudo iputils-ping language-pack-da
# perform a general image upgrade as reccomended by phusion docs.
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"
