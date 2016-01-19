FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install RMagick
# RUN apt-get install -y libmagickwand-dev imagemagick

# Install Nokogiri
# RUN apt-get install -y zlib1g-dev

ENV DEBIAN_FRONTEND noninteractive

# Install basic dev tools
RUN apt-get update && apt-get install -y -q \
    build-essential \
    wget \
    curl \
    git

# Install package for ruby
RUN apt-get install -y -q \
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

# Install package for postgresql
RUN apt-get install -y -q libpq-dev

#RUN apt-get install -y -q zlib1g zlib1g-dev build-essential sqlite3 libsqlite3-dev openssl libssl-dev libyaml-dev libreadline-dev libxml2-dev libxslt1-dev

# Install packages for MySQL
RUN apt-get install -y -q mysql-server mysql-client libmysqlclient-dev

# Install Postgres gem dependencies
#RUN apt-get install -y -q libpq-dev postgresql-server-dev-9.4

RUN mkdir /spree
WORKDIR /tmp
COPY . /tmp

RUN bundle install --jobs 4

ADD . /spree
WORKDIR /spree
