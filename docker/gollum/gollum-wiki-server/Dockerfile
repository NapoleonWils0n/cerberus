# gollum wiki server

FROM ubuntu:14.04
MAINTAINER username <username@gmail.com>

# Install dependencies
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install -q build-essential \
ruby1.9.3 python2.7 ruby-bundler libicu-dev libreadline-dev libssl-dev zlib1g-dev git-core

# Install gollum
RUN gem install gollum redcarpet github-markdown

# Initialize wiki data
RUN mkdir /var/wiki

# Expose default gollum port 4567
EXPOSE 4567

# entrypoint
ENTRYPOINT ["/usr/local/bin/gollum", "/var/wiki"]
