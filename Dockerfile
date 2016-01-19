FROM ruby:2.2.0

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

# Install packages for ruby
RUN apt-get install -y -q \
    zlib1g \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev

# Install package for sqlite3
RUN apt-get install -y -q \
    sqlite3 \
    libsqlite3-dev

# Install packages for postgresql
RUN apt-get install -y -q \
    libpq-dev \
    postgresql-server-dev-9.4

# Install packages for MySQL
RUN apt-get install -y -q mysql-server mysql-client libmysqlclient-dev

RUN mkdir /spree
WORKDIR /tmp
COPY . /tmp

RUN bundle install --jobs 4

ADD . /spree
WORKDIR /spree
