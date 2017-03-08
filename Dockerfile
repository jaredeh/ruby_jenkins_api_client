FROM ruby
LABEL Description="This image is holds a ruby install with the jenkins_api_client gem and it's dependencies" Vendor="jaredeh" Version="0.1"

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y build-essential; \
    gem install jenkins_api_client; \
    apt-get remove -y build-essential; \
    apt-get autoremove -y
RUN apt-get install -y ipmitool

RUN gem install rubyipmi

RUN mkdir -p /usr/src/code

