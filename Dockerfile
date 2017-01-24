FROM php:7.0-apache
RUN a2enmod rewrite
COPY src/ /var/www/html
EXPOSE 80

