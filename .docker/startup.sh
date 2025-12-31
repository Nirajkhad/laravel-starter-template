#!/bin/bash
set -euo pipefail

cd /var/www/html

# Skip if .env already exists (it's loaded via env_file)
if [ ! -f .env ]; then
    cp .env.example .env || true
fi

# Only generate key if APP_KEY is empty
if grep -q "^APP_KEY=$" .env 2>/dev/null; then
    php artisan key:generate --force || true
fi

# Default startup tasks...
composer install --no-interaction --optimize-autoloader || true

# Run migrations with proper error handling
echo "Running database migrations..."
php artisan migrate --force 2>&1 | tee /tmp/migration.log || echo "Migrations completed with warnings"

# Generate storage symlink
php artisan storage:link || true

# Clear any caches
php artisan optimize:clear || true

echo "Laravel initialization complete. Ready to serve requests."
