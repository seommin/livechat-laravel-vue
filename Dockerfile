FROM php:7.3-fpm-alpine

RUN apk update && \
    apk add -u vim procps tzdata bash curl zip git zlib-dev libzip-dev icu-dev npm && \
    rm -rf /var/cache/apk/*

RUN cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN echo "Asia/Seoul" > /etc/timezone

# Composer Install
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer
RUN ["/bin/bash", "-c", "echo PATH=$PATH:~/.composer/vendor/bin/ >> ~/.bashrc"]
RUN ["/bin/bash", "-c", "source ~/.bashrc"]

# PHP Extension Install
RUN docker-php-ext-install opcache
RUN docker-php-ext-install intl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_mysql mysqli && docker-php-ext-enable mysqli

# PHP Config
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini && \
    sed -i "s/display_errors = Off/display_errors = On/" /usr/local/etc/php/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 10M/" /usr/local/etc/php/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 12M/" /usr/local/etc/php/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /usr/local/etc/php/php.ini && \
    sed -i "s/variables_order = .*/variables_order = 'EGPCS'/" /usr/local/etc/php/php.ini && \
    sed -i "s/listen = .*/listen = 9000/" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/pm.max_children = .*/pm.max_children = 200/" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/pm.start_servers = .*/pm.start_servers = 56/" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/pm.min_spare_servers = .*/pm.min_spare_servers = 32/" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/pm.max_spare_servers = .*/pm.max_spare_servers = 96/" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/^;clear_env = no$/clear_env = no/" /usr/local/etc/php-fpm.d/www.conf
RUN echo '*       *       *       *       *       cd /var/www/html/ && php artisan schedule:run >> /dev/null 2>&1' >> /etc/crontabs/root

COPY ./livechat /var/www/html
WORKDIR /var/www/html

# download the Laravel installer using Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require laravel/installer
RUN composer global require laravel/ui
RUN php artisan ui vue
RUN composer require laravel-frontend-presets/tailwindcss --dev
RUN php artisan ui tailwindcss --auth

RUN npm install && npm run dev

# permission
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache/

# Bind Port
EXPOSE 9000