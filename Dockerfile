# PhantomJS Docker Container (based on Ubuntu, with NodeJS and Python)
FROM node:4

# Install PhantomJS
ENV PHANTOMJS_VERSION 1.9.7

ENV PHANTOM_PACKAGES libfreetype6 libfontconfig python

# Add Dockerize, as it's useful.
RUN \
  apt-get update && apt-get install -y wget && \
  wget https://github.com/jwilder/dockerize/releases/download/v0.1.0/dockerize-linux-amd64-v0.1.0.tar.gz && \
  tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.1.0.tar.gz && \
  apt-get remove -y wget && \
  apt-get autoremove -y && \
  apt-get clean all

# Install the packages we need.
RUN \
  # We need the contrib repo for ttf-mscorefonts-installer.
  echo "deb http://httpredir.debian.org/debian jessie contrib" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y $PHANTOM_PACKAGES && \
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
  apt-get install -y ttf-mscorefonts-installer && \
  apt-get autoremove -y && \
  apt-get clean all

# Install PhantomJS.
RUN \
  curl -SLO "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" && \
  tar -xjf "phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" -C /usr/local --strip-components=1 && \
  rm "phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2"

CMD [ "phantomjs" ]
