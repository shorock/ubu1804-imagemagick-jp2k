FROM ubuntu:18.04

RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && apt update && apt install -y build-essential automake git dpkg-dev apt-utils

RUN apt-get build-dep -y imagemagick && apt-get source imagemagick && apt install -y libopenjp2-7-dev


# RUN apt-get source imagemagick
