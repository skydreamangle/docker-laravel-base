FROM alpine:3.6

RUN apk update && \
    apk add nginx bash ca-certificates s6 curl ssmtp php7 php7-phar php7-curl \
    php7-fpm php7-json php7-zlib php7-xml php7-dom php7-ctype php7-opcache php7-zip php7-iconv \
    php7-pdo php7-pdo_mysql php7-pdo_sqlite php7-pdo_pgsql php7-mbstring php7-session \
    php7-gd php7-mcrypt php7-openssl php7-sockets php7-posix php7-ldap php7-simplexml \
    php7-mysqli php7-mysqlnd php7-tokenizer php7-fileinfo php7-xmlwriter php7-redis && \
    rm -rf /var/cache/apk/* && \
    rm -f /etc/php7/php-fpm.d/www.conf && \
    touch /etc/php7/php-fpm.d/env.conf

RUN apk add --update nodejs nodejs-npm

ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --filename=/usr/local/bin/composer

ONBUILD RUN rm -rf /var/www/* && mkdir /var/www/app

ONBUILD COPY files/php/conf.d/local.ini /etc/php7/conf.d/
ONBUILD COPY files/php/php-fpm.conf /etc/php7/
ONBUILD COPY files/php/phpinfo.php /var/www/app/index.php
ONBUILD COPY files/nginx/nginx.conf /etc/nginx/nginx.conf
COPY files/services.d /etc/services.d

EXPOSE 80

ENTRYPOINT ["/bin/s6-svscan", "/etc/services.d"]
CMD []
