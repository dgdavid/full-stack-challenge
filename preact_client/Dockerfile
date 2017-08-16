FROM node:latest

RUN mkdir -p /app
WORKDIR /app

RUN yarn global add preact-cli

ADD package.json /app/package.json
ADD yarn.lock /app/yarn.lock

RUN yarn install

ADD . /app

EXPOSE 8080
