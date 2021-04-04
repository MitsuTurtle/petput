FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /petput
WORKDIR /petput

COPY Gemfile /petput/Gemfile
COPY Gemfile.lock /petput/Gemfile.lock

RUN gem install bundler
RUN bundle install
COPY . /petput