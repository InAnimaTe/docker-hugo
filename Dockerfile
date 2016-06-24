FROM debian:wheezy
MAINTAINER yigal@publysher.nl

# Install pygments (for syntax highlighting) 
RUN apt-get -qq update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends python-pygments \
	&& rm -rf /var/lib/apt/lists/*

# Download and install hugo
ENV WORK_DIR /opt
ENV HUGO_VERSION 0.16
ENV HUGO_ARCHIVE hugo_${HUGO_VERSION}_linux-64bit.tgz
ENV HUGO_BINARY hugo

ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ARCHIVE} ${WORK_DIR}
RUN tar xzf ${WORK_DIR}/${HUGO_ARCHIVE} \
	&& ln -s ${WORK_DIR}/${HUGO_BINARY} /usr/local/bin/hugo

# Create working directory
RUN mkdir /usr/share/blog
WORKDIR /usr/share/blog

# Expose default hugo port
EXPOSE 1313

# Automatically build site
ONBUILD ADD site/ /usr/share/blog
ONBUILD RUN hugo -d /usr/share/nginx/html/

# By default, serve site
ENV HUGO_BASE_URL http://localhost:1313
CMD hugo server -b ${HUGO_BASE_URL}
