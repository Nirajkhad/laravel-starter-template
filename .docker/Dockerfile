########################################
# FrankenPHP + Laravel Octane
########################################
FROM serversideup/php:8.5-frankenphp

ARG HOST_UID=1000
ARG HOST_GID=1000

########################################
# Root only for setup
########################################
USER root

# Align www-data UID/GID with host
RUN docker-php-serversideup-set-id www-data ${HOST_UID}:${HOST_GID}

# REQUIRED for Caddy (FrankenPHP)
RUN mkdir -p /data/caddy /config/caddy \
 && chown -R ${HOST_UID}:${HOST_GID} /data /config

# Laravel-required PHP extensions
RUN install-php-extensions \
    pdo_mysql \
    redis \
    zip \
    bcmath \
    intl

RUN mkdir -p  /var/www/html \
 && chown -R ${HOST_UID}:${HOST_GID}  /var/www/html


########################################
# App directory
########################################
WORKDIR /var/www/html

########################################
# Startup and Scheduler scripts
########################################
COPY --chmod=755 .docker/scripts/startup.sh /etc/entrypoint.d/
COPY --chmod=755 .docker/scripts/scheduler.sh /usr/local/bin/scheduler


########################################
# Drop privileges
########################################
USER ${HOST_UID}:${HOST_GID}