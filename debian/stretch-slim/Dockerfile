FROM debian:stretch-slim

MAINTAINER wilkesystems <maintainer@wilke.systems>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update; \
apt-get install -y ca-certificates locales locales-all apache2 openssl ssl-cert \
libapache2-mod-fcgid libapache2-mod-gnutls; \
a2enmod actions alias fcgid proxy_fcgi setenvif socache_dbm userdir; \
a2ensite default-tls; \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
ln -sf /dev/stdout /var/log/apache2/access.log; \
ln -sf /dev/stderr /var/log/apache2/error.log;

EXPOSE 80 443

STOPSIGNAL WINCH

COPY ["docker-entrypoint.sh", "/usr/bin/docker-entrypoint.sh"]

WORKDIR /var/www

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2ctl", "-D", "FOREGROUND"]
