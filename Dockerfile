FROM ruby:alpine
MAINTAINER Jared Hulbert <jaredeh@gmail.com>

RUN apk update && apl upgrade
RUN apk add --update alpine-sdk
RUN gem install jenkins_api_client
