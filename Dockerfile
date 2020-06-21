FROM php:7.3-apache

COPY ./php/php.ini /etc/php/
COPY ./apache/*.conf /etc/apache2/sites-available/

COPY ./laravel-app /var/www/html 

RUN apt-get update \
   && apt-get -y install \ 
   vim \
   zlib1g-dev \
   libpq-dev \
   libzip-dev \
   mariadb-client \
   unzip \
   cron \
   vim \
   wget \
   gnupg \
   && docker-php-ext-install zip 



RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN a2enmod rewrite

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

WORKDIR /var/www/html

RUN composer global require "laravel/installer"
