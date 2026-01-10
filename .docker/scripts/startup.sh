#!/usr/bin/env bash
set -e

cd /var/www/html

# Copy env if missing (dev only)
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Generate key once
if ! grep -q "APP_KEY=base64:" .env; then
    php artisan key:generate --force
fi

# 🚨 ONLY APP CONTAINER RUNS SETUP 🚨
if [ "$RUN_APP_SETUP" = "true" ]; then
    if [ ! -d vendor ]; then
        composer install --no-interaction --prefer-dist
    fi

    echo "Waiting for database..."
    sleep 5

    php artisan migrate --force

    if [ ! -L public/storage ]; then
        php artisan storage:link
    fi

    php artisan optimize:clear
fi

echo "Container ready"
