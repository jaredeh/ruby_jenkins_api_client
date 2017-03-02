FROM ruby:alpine
LABEL Description="This image is holds a ruby install with the jenkins_api_client gem and it's dependencies" Vendor="jaredeh" Version="0.1"

RUN apk update && apk upgrade
RUN apk add --no-cache alpine-sdk
RUN gem install jenkins_api_client
