FROM webdevops/php-apache:8.2

WORKDIR /app

COPY . /app

RUN chown -R application:application /app
