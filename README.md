TOTAL HACK JOB - use at your own risk

As it currently stands, the Imagemagick programs provided with Ubuntu, even 18.04, don't compile a link against anything that handles JPEG2000.

Imagemagick itself links against libopenjp2. But, the version in Debian/Ubuntu `main` doesn't.

So, we're building a .deb from source.  Fun.

The Dockerfile does 99% of the build, but leaves the files in the container.  From there, I mounted the output/

`docker run -it --rm -v $PWD/output:/output imbuilt`

and inside of it

`tar cvfz output/imagemagick-kulib-localrepo.tgz *.deb Packages.gz`

I also just checked in that tarball to this repo for easy retrieval.

---

My build script for a ubuntu:18.04 derived Docker container containing this .tgz is using:

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
