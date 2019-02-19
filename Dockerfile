FROM ubuntu:18.04

RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && apt update && apt install -y build-essential automake git dpkg-dev apt-utils devscripts

RUN apt-get build-dep -y imagemagick && apt-get source imagemagick && apt install -y libopenjp2-7-dev

RUN cd imagemagick-6.9.7.4+dfsg && dch -v 8:6.9.7.4+dfsg-99kulib6.4 "Compile with OpenJP2" && debuild -b -uc -us

RUN cd / && dpkg-scanpackages . | gzip -c > Packages.gz 

# With the output volume mounted - cp *.deb Packages.gz output/, tarball that up, what have you
