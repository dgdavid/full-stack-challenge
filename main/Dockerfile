FROM ruby:latest

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /app

EXPOSE 2300

ENV HANAMI_HOST=0.0.0.0
