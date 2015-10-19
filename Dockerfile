FROM node:slim

MAINTAINER Yuriy Kryshchuk <yuriy.kryshchuk@gmail.com>

ENV GULP_TARGET_DIR=/mnt/target GULP_SOURCE_DIR=/mnt/source

ADD jumpin.sh /bin/jumpin.sh

RUN mkdir -p $GULP_SOURCE_DIR && mkdir -p $GULP_TARGET_DIR

WORKDIR $GULP_SOURCE_DIR

RUN apt-get update && apt-get install -y \
	g++ make python \
	libpng-dev

RUN npm install -g gulp

ENTRYPOINT ["/bin/jumpin.sh"]
