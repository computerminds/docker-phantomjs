# Drush Docker Container
FROM ubuntu:14.04

# Install PhantomJS
ENV PHANTOMJS_VERSION 1.9.7

# Commands
RUN \
  apt-get update && \
  apt-get install -y vim git wget libfreetype6 libfontconfig bzip2

RUN  mkdir -p /srv/var && \
  wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
  ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs && \
#  git clone https://github.com/n1k0/casperjs.git /srv/var/casperjs && \
#  ln -s /srv/var/casperjs/bin/casperjs /usr/bin/casperjs && \
  apt-get autoremove -y && \
  apt-get clean all


# Install npm

RUN \
  apt-get update && \
  apt-get install -y curl && \
  apt-get autoremove -y && \
  apt-get clean all

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

RUN \
  apt-get update && \
  apt-get install -y nodejs python && \
  apt-get autoremove -y && \
  apt-get clean all

