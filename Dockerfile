FROM centos:centos7
MAINTAINER David Nunez <arizonatribe@gmail.com>

# Make sure we're using the proper terminal environment
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV TERM xterm

# Install general OS utilities
RUN yum install -y \
     curl \
     epel-release \
     git \
     jq \
     man \
     tar \
     vim \
     wget

# Install Make tools
RUN yum install -y \
     gcc-c++ \
     glibc-devel \
     make

# Install python-related tools
RUN yum install -y \
     python \
     python-pip \
     python-setuptools \
     supervisor
RUN pip install --upgrade pip
RUN easy_install supervisor

# Default locations for Node Version Manager and version of Node to be installed
ENV NODE_VERSION 6.2.0
ENV NVM_DIR /.nvm
     
# Default version of Node to be installed; can be overridden
RUN git clone https://github.com/creationix/nvm.git $NVM_DIR
RUN echo ". $NVM_DIR/nvm.sh" >> /etc/bash.bashrc

# Install node.js
RUN source $NVM_DIR/nvm.sh \
    && nvm install v$NODE_VERSION \
    && nvm use v$NODE_VERSION \
    && nvm alias default v$NODE_VERSION \
    && ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/node /usr/bin/node \
    && ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm

