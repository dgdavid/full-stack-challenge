FROM ruby:latest

RUN mkdir -p /app
WORKDIR /app

ADD main/Gemfile /app/Gemfile
ADD main/Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD main /app

EXPOSE 2300

ENV HANAMI_HOST=0.0.0.0
