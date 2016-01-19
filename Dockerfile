FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install RMagick
# RUN apt-get install -y libmagickwand-dev imagemagick

# Install Nokogiri
# RUN apt-get install -y zlib1g-dev

RUN apt-get install -y zlib1g zlib1g-dev build-essential sqlite3 libsqlite3-dev openssl libssl-dev libyaml-dev libreadline-dev libxml2-dev libxslt1-dev

# Install MySQL gem dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y -q mysql-server mysql-client libmysqlclient-dev

# Install Postgres gem dependencies
RUN apt-get install -y libpq-dev postgresql-server-dev-9.4

RUN mkdir /spree
WORKDIR /tmp
COPY . /tmp

RUN bundle install --jobs 4

ADD . /spree
WORKDIR /spree
