FROM php:8.0-apache
COPY * /var/www/html/
WORKDIR /var/www/html/
RUN echo "ServerName localhost:80" >> /etc/apache2/apache2.conf
EXPOSE 80
