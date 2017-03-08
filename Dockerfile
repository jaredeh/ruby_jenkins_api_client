FROM ruby:alpine
LABEL Description="This image is holds a ruby install with the jenkins_api_client gem and it's dependencies" Vendor="jaredeh" Version="0.1"

RUN apk update && apk upgrade
COPY ipmitool_hack /
ENV ROOT=/ D=/tmp/install SCRIPTDIR=/ AUXDIR=/aux WORKDIR=/tmp SOURCEDIR=/tmp
RUN apk add --no-cache alpine-sdk; \
    gem install jenkins_api_client; \
    apk del --no-cache alpine-sdk
RUN apk add --no-cache linux-headers openssl-dev curl file gcc libgcc libc-dev make libtool; \
    /pkg.sh build ipmitool-1.8.16; \
    rm -rf /tmp/*; \
    apk del --no-cache linux-headers openssl-dev curl file gcc libgcc libc-dev make libtool


RUN gem install rubyipmi

RUN mkdir -p /usr/src/code

