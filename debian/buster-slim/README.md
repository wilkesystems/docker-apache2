# Supported tags and respective `Dockerfile` links

-	[`latest` (*/debian/buster-slim/Dockerfile*)](https://github.com/wilkesystems/docker-apache2/blob/master/debian/buster-slim/Dockerfile)

----------------

![Apache2](https://github.com/wilkesystems/docker-apache2/raw/master/docs/logo.png)

# Apache2 on Debian Buster
The Apache HTTP Server Project's goal is to build a secure, efficient and extensible HTTP server as standards-compliant open source software. The result has long been the number one web server on the Internet.

----------------

# Get Image
[Docker hub](https://hub.docker.com/r/wilkesystems/apache2)

```bash
docker pull wilkesystems/apache2
```

----------------

# How to use this image

```bash
$ docker run -d -p 80:80 -p 443:443 wilkesystems/apache2
```

----------------

# Auto Builds
New images are automatically built by each new library/debian push.

----------------

# Package: apache2
Package: [apache2](https://packages.debian.org/buster/apache2)

The Apache HTTP Server Project's goal is to build a secure, efficient and extensible HTTP server as standards-compliant open source software. The result has long been the number one web server on the Internet.

Installing this package results in a full installation, including the configuration files, init scripts and support scripts.