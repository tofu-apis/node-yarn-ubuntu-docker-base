# To run this image execute the following commands:
# docker build --tag node-ubuntu-docker-base:latest .
# docker run --detach node-ubuntu-docker-base:latest

# Set the base image to ubuntu
# https://hub.docker.com/_/ubuntu
FROM ubuntu:18.04

#----------------------------------------------------------------------
# Dependencies Installation
#----------------------------------------------------------------------
# Adding non-interactive for debian front-end to hide dialog questions during build.
# Args only live during the build so they do not persist to the final image.
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update \
    && apt-get install -qq -y \
        apt-utils \
        curl \
    && apt-get -qq -y autoclean

#----------------------------------------------------------------------
# Node & NPM Setup
#----------------------------------------------------------------------

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# nvm environment variables
ENV YARN_VERSION 1.22.10
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.19.1
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN mkdir $NVM_DIR

# install nvm
RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

RUN npm install --global yarn \
  && yarn set version $YARN_VERSION

COPY check_versions.sh /usr/local/bin/check_versions.sh
