FROM webdevops/php-apache:7.4

WORKDIR /app

COPY . /app

# Instala Composer
RUN apt-get update && apt-get install -y unzip git curl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instala dependências PHP
RUN composer install --no-dev --optimize-autoloader

# Permissões
RUN chown -R application:application /app
