FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install RMagick
# RUN apt-get install -y libmagickwand-dev imagemagick

# Install Nokogiri
# RUN apt-get install -y zlib1g-dev

RUN mkdir /spree
WORKDIR /tmp
COPY . /tmp

RUN bundle install --deployment --jobs 4

ADD . /spree
WORKDIR /spree
