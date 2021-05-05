FROM ruby:2.6.5

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

RUN mkdir /petput
WORKDIR /petput

COPY Gemfile /petput/Gemfile
COPY Gemfile.lock /petput/Gemfile.lock

RUN gem install bundler
RUN bundle install
COPY . /petput