FROM node:latest

RUN mkdir -p /app
WORKDIR /app

RUN yarn global add preact-cli

ADD ./preact_client/package.json /app/package.json
ADD ./preact_client/yarn.lock /app/yarn.lock

RUN yarn install

ADD . /app

EXPOSE 8080
