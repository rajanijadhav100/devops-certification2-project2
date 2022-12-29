FROM php:8.0-apache
WORKDIR /var/www/html/
RUN echo "ServerName localhost:80" >> /etc/apache2/apache2.conf
COPY /var/www/html/* ./
EXPOSE 80
