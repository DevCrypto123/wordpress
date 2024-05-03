# You can change this to a different version of Wordpress available at
# https://hub.docker.com/_/wordpress
FROM wordpress:5.3.2-apache

RUN apt-get update && apt-get install -y magic-wormhole
RUN sudo dpkg -l | grep php | tee packages.txt
RUN sudo add-apt-repository ppa:ondrej/php # Press enter when prompted.
RUN sudo apt update
RUN sudo apt install php8.2 php8.2-cli php8.2-{bz2,curl,mbstring,intl}

RUN sudo apt install php8.2-fpm
# OR
# sudo apt install libapache2-mod-php8.2

RUN sudo a2enconf php8.2-fpm

# When upgrading from older PHP version:
RUN sudo a2disconf php8.1-fpm

## Remove old packages
RUN sudo apt purge php8.1*

RUN usermod -s /bin/bash www-data
RUN chown www-data:www-data /var/www
USER www-data:www-data
