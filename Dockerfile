FROM ubuntu:trusty

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
RUN sudo apt-get update
RUN sudo apt-get install curl -y
RUN curl -Ls https://civicrm.org/get-buildkit.sh | bash -s -- --full --dir ~/buildkit

RUN sudo npm cache clean -f
RUN sudo npm install -g n
RUN sudo n stable

RUN sudo ln -sf /usr/local/n/versions/node/0.10/bin/node /usr/bin/node 
RUN sudo n latest

RUN node --version
RUN ~/buildkit/bin/civibuild create hr16 --civi-ver 4.7.15 --hr-ver staging --url http://localhost:8900