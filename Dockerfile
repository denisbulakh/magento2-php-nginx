FROM php:7.4-fpm

RUN apt-get update \
    && apt-get install -y git libicu-dev zlib1g-dev libpng-dev \
        libxml2-dev libxslt1-dev libzip-dev libjpeg-dev libfreetype6-dev \
        nginx \
    && docker-php-ext-install pdo pdo_mysql intl soap xsl zip bcmath sockets \
    && docker-php-ext-configure gd \
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable gd

RUN curl https://getcomposer.org/installer > composer-setup.php && php composer-setup.php &&\
    mv composer.phar /usr/local/bin/composer && rm composer-setup.php

RUN mkdir /usr/src/app
COPY ./install.sh /usr/src/app
COPY ./docker-php-magento2.ini "$PHP_INI_DIR/conf.d/"
COPY ./magento /etc/nginx/sites-enabled
COPY ./magento /etc/nginx/sites-available

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

EXPOSE 80 9000

WORKDIR /usr/src/app

CMD ["sh", "-c", "exec 3<>/tmp/stdout; cat <&3 >&2 & exec service nginx start & exec php-fpm -F >/tmp/stdout 2>&1"]
