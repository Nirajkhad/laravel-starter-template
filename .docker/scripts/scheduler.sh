#!/usr/bin/env bash
set -e

cd /var/www/html

echo "Starting Laravel Scheduler..."

while true; do
  php artisan schedule:run --no-interaction --verbose
  sleep 60
done
