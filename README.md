TOTAL HACK JOB - use at your own risk

As it currently stands, the Imagemagick programs provided with Ubuntu, even 18.04, don't compile / link against any library that handles JPEG2000.  Years ago, it used to use Jasper, but Jasper's not in Debian/Ubuntu trees at all any more.

Imagemagick itself will link against libopenjp2. But, the version in Debian/Ubuntu `main` doesn't since libopenjp2 isn't in `main`.

So, we're building a local repo from source.  Fun.

The Dockerfile does 99% of the build, but just leaves the files in the built container.  From there, I mounted the output/

`docker run -it --rm -v $PWD/output:/output imbuilt`

and inside of it

`tar cvfz output/imagemagick-kulib-localrepo.tgz *.deb Packages.gz`

I also just checked in that tarball to this repo for easy retrieval.

---

My build script for a ubuntu:18.04-based Docker container using this repo (a Dockerized version of [Islandora 7.x](https://islandora.ca)) is configured with the following:

```
# Customized imagemagick with support for OpenJP2k

mkdir /usr/local/imagemagickrepo
pushd /usr/local/imagemagickrepo
wget https://github.com/shorock/ubu1804-imagemagick-jp2k/raw/master/output/imagemagick-kulib-localrepo.tgz
tar xvfz imagemagick-kulib-localrepo.tgz
echo "deb [trusted=yes] file:/usr/local/imagemagickrepo ./" > /etc/apt/sources.list.d/local-imagemagic.list
apt update && apt install -y libopenjp2-7 imagemagick
popd
```
