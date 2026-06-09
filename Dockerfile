FROM php:8.1-apache

WORKDIR /var/www/html

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libzip-dev \
    zip

# Extensões PHP necessárias
RUN docker-php-ext-install mysqli pdo pdo_mysql zip

# Habilita mod_rewrite
RUN a2enmod rewrite

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia arquivos
COPY . /var/www/html

# Instala dependências PHP
RUN composer install --no-dev --optimize-autoloader

# Permissões
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
