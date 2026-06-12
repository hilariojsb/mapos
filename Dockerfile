FROM php:8.4-apache

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libzip-dev \
    libpng-dev \
    libicu-dev

RUN docker-php-ext-install \
    mysqli \
    pdo_mysql \
    zip \
    gd \
    intl

RUN a2enmod rewrite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --ignore-platform-reqs --no-scripts

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
