FROM ubuntu:14.04

# Update package list
RUN apt-get update -qq

ENV DEBIAN_FRONTEND noninteractive

# Install basic dev tools
RUN apt-get install -y -q \
    build-essential \
    wget \
    curl \
    git \
    openssl \
    software-properties-common

# Install packages for ruby
RUN apt-get install -y -q \
    zlib1g \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev

# Update your packages and install the ones that are needed to compile Ruby
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl libxml2-dev libxslt-dev libcurl4-openssl-dev libreadline6-dev libssl-dev patch build-essential zlib1g-dev openssh-server libyaml-dev libicu-dev

# Download Ruby and compile it
RUN mkdir /tmp/ruby
RUN cd /tmp/ruby && curl --silent ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz | tar xz
RUN cd /tmp/ruby/ruby-2.0.0-p481 && ./configure --disable-install-rdoc && make install

RUN gem install bundler

# Set an utf-8 locale
RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

# Prepare a known host file for non-interactive ssh connections
RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/known_hosts

# Install package for sqlite3
RUN apt-get install -y \
    sqlite3 \
    libsqlite3-dev

# Install packages for postgresql
RUN apt-get install -y -q \
    postgresql \
    postgresql-server-dev-9.4

# Install packages for MySQL
RUN apt-get install -y -q mysql-server mysql-client libmysqlclient-dev

RUN mkdir /spree
WORKDIR /tmp
COPY . /tmp

RUN bundle install --jobs 4

ADD . /spree
WORKDIR /spree
