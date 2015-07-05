FROM php:5.6-apache

ENV PIWIK_VERSION 2.13.0

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install mysqli \
                            mbstring \
                            gd

RUN curl -L -O http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar --strip 1 -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    rm piwik-${PIWIK_VERSION}.tar.gz
RUN chmod a+w /var/www/html/config
RUN chown www-data:www-data -R /var/www/html
RUN echo "always_populate_raw_post_data=-1" > /usr/local/etc/php/php.ini

EXPOSE 80
VOLUME /var/www/html/config
