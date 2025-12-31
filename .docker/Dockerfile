FROM webdevops/php-nginx:8.4

# Set labels for metadata
LABEL maintainer="Laravel Dev Team"
LABEL description="Laravel Starter Template with PHP 8.4, Nginx, and PostgreSQL"

# Environment variables
ENV WEB_DOCUMENT_ROOT=/var/www/html/public \
    PHP_MEMORY_LIMIT=512M \
    PHP_MAX_UPLOAD_SIZE=50M

WORKDIR /var/www/html

# Copy and setup startup script before application code (layer caching)
COPY .docker/startup.sh /opt/docker/provision/entrypoint.d/99-laravel-init.sh
RUN chmod +x /opt/docker/provision/entrypoint.d/99-laravel-init.sh

# Copy application
COPY . /var/www/html

# Set file permissions for critical directories only
RUN chown -R 1001:1001 /opt/docker && \
    chmod -R 755 /opt/docker && \
    chown -R 1001:1001 /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=5s --retries=3 --start-period=30s \
    CMD curl -f http://localhost:80/ || exit 1
