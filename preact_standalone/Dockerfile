FROM node:latest

RUN mkdir -p /app
WORKDIR /app

RUN yarn global add preact-cli

ADD ./preact_standalone/package.json /app/package.json
ADD ./preact_standalone/yarn.lock /app/yarn.lock

RUN yarn install

ADD . /app

EXPOSE 9090
