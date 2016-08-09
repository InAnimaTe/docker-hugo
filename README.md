
## Docker-Hugo

The goal of this docker image is to provide a build environment for Hugo sites.
My company, [Arroyo Networks](https://arroyonetworks.com/) uses it with Gitlab
CI to test and build our static web properties.
We also include NPM and necessary projects to enable minification and other
features that happen at build time.

A few notes here. Let's say you're using CI, you can have the following commands
run to build your site:

* `mv /opt/node/node_modules .`
* `npm run build`

However, you can also still utilize this image as documented below from the
original repo owners' own readme i.e. as standalone server or volume image for
your own web server (see ENTRYPOINT/CMD in Dockerfile)

> As you can see, I include my own optimized package.json and instruct you to
> move your node_modules directory over. This is the best way to ensure node
> will work with your resulting mounted in project files during CI time.

-------------------------------------------------------------------------
publysher/hugo
==============

`publysher/hugo` is a [Docker](https://www.docker.io) base image for static sites generated with [Hugo](http://gohugo.io). 

Images derived from this image can either run as a stand-alone server, or function as a volume image for your web server. 

Prerequisites
-------------

The image is based on the following directory structure:

	.
	├── Dockerfile
	└── site
	    ├── config.toml
	    ├── content
	    │   └── ...
	    ├── layouts
	    │   └── ...
	    └── static
		└── ...

In other words, your Hugo site resides in the `site` directory, and you have a simple Dockerfile:

	FROM publysher/hugo 


Building your site
------------------

Based on this structure, you can easily build an image for your site:

	docker build -t my/image .

Your site is automatically generated during this build. 


Using your site
---------------

There are two options for using the image you generated: 

- as a stand-alone image
- as a volume image for your webserver

Using your image as a stand-alone image is the easiest:

	docker run -p 1313:1313 my/image

This will automatically start `hugo server`, and your blog is now available on http://localhost:1313. 

If you are using `boot2docker`, you need to adjust the base URL: 

	docker run -p 1313:1313 -e HUGO_BASE_URL=http://YOUR_DOCKER_IP:1313 my/image

The image is also suitable for use as a volume image for a web server, such as [nginx](https://registry.hub.docker.com/_/nginx/)

	docker run -d -v /usr/share/nginx/html --name site-data my/image
	docker run -d --volumes-from site-data --name site-server -p 80:80 nginx


Examples
--------

For an example of a Hugo site, have a look at https://github.com/publysher/blog.publysher.nl
