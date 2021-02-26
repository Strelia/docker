FROM php:8-fpm

ARG DEBIAN_FRONTEND=noninteractive


COPY phpsendmail /usr/local/bin/phpsendmail
#RUN chmod 777  /usr/local/bin/phpsendmail \
#    && mkdir /media/mail

RUN apt-get update && apt-get install -y \
    gnupg2 \
    curl \
    wget

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get update && \
    apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list && \
    wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - && \
    apt-get update

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    libmcrypt-dev \
    openssl \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    unzip \
    libxml2-dev \
    zlib1g-dev \
    libicu-dev \
    libpq-dev \
    g++ \
    libc-client-dev \
    libkrb5-dev
#    rm -r /var/lib/apt/lists/*

# install dependecies
RUN docker-php-ext-install -j$(nproc) iconv && \
    docker-php-ext-configure gd --with-freetype --with-jpeg&& \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-configure intl && \
    docker-php-ext-configure pdo_pgsql --with-pdo-pgsql && \
    docker-php-ext-install pgsql pdo pdo_pgsql intl opcache soap && \
    pecl install xdebug && \
    docker-php-ext-enable opcache xdebug && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

RUN curl -sS https://getcomposer.org/installer | tee composer-setup.php \
    && php composer-setup.php && rm composer-setup.php* \
    && chmod +x composer.phar && mv composer.phar /usr/bin/composer
#    \
#    && ln -s /usr/bin/php8 /usr/local/bin/php

COPY php.ini /usr/local/etc/php/conf.d/

WORKDIR /application

CMD ["php-fpm"]
