# Laravel Starter Template

A fully optimized Laravel 12 development environment with Docker, PostgreSQL, Redis, and Mailpit configured and ready to go.

## 🚀 Quick Start

### Prerequisites

-   Docker & Docker Compose
-   Bash shell

### Installation

1. **Clone and setup:**

    ```bash
    git clone <repository-url>
    cd laravel-starter-template
    ```

2. **Start the application:**

    ```bash
    ./start.sh
    ```

3. **Access the app:**
    - Laravel App: http://localhost:8000
    - Mailpit Web UI: http://localhost:8025
    - PostgreSQL: localhost:5432
    - Redis: localhost:6379

## 📋 Available Commands

### Quick Access

```bash
# Open app in browser (requires Linux/Mac)
./app open

# Enter container shell
./app.cli

# Run any command in container
./app php artisan make:model User
./app composer require package-name
./app php -v
```

### Database

```bash
./app php artisan migrate              # Run migrations
./app php artisan migrate:fresh        # Reset database
./app php artisan db:seed              # Seed database
./app php artisan tinker               # Open PHP REPL
```

### Cache & Queue

```bash
./app php artisan optimize:clear       # Clear cache
./app php artisan queue:work           # Start queue worker
```

### Testing

```bash
./app php artisan test                 # Run tests
./app ./vendor/bin/pint                # Code formatting (Pint)
```

### Docker Management

```bash
docker compose logs -f app             # View container logs
docker compose restart app             # Restart app container
docker compose down                    # Stop all services
docker compose up -d                   # Start in background
```

## 🐳 Services

### Application (PHP 8.4 + Nginx)

-   **Container:** `laravel_app`
-   **Port:** 8000
-   **Image:** webdevops/php-nginx:8.4
-   **Features:**
    -   Nginx + PHP-FPM
    -   Supervisor for queue workers
    -   Hot code reloading via volume mounts
    -   Automatic migrations on startup

### PostgreSQL 16

-   **Container:** `laravel_postgres`
-   **Port:** 5432
-   **Database:** `laravel`
-   **User:** `laravel`
-   **Password:** `secret`
-   **Data:** Persisted in `pgdata` volume

### Redis 7

-   **Container:** `laravel_redis`
-   **Port:** 6379
-   **Use:** Cache store, Queue driver

### Mailpit

-   **Container:** `laravel_mailpit`
-   **SMTP Port:** 1025
-   **Web UI:** http://localhost:8025
-   **Use:** Email testing and development

## 📁 Project Structure

```
laravel-starter-template/
├── app/                          # Application code
│   ├── Http/Controllers/         # Route controllers
│   ├── Models/                   # Eloquent models
│   └── Providers/                # Service providers
├── bootstrap/                    # Framework bootstrap files
├── config/                       # Configuration files
├── database/
│   ├── factories/                # Model factories
│   ├── migrations/               # Database migrations
│   └── seeders/                  # Database seeders
├── resources/
│   ├── css/                      # Application styles
│   ├── js/                       # JavaScript
│   └── views/                    # Blade templates
├── routes/
│   ├── web.php                   # Web routes
│   └── console.php               # Console commands
├── storage/                      # Application storage
├── tests/                        # Test suites
├── vendor/                       # Composer dependencies
├── .docker/                      # Docker configuration
│   ├── Dockerfile                # Application image
│   ├── startup.sh                # Container startup script
│   └── supervisor/               # Supervisor configs
├── docker-compose.yaml           # Docker services definition
├── start.sh                      # Project startup script
├── app                           # CLI helper script
├── app.cli                       # Container shell access
├── .env                          # Environment variables (local)
├── .env.example                  # Environment template
└── composer.json                 # PHP dependencies
```

## 🔧 Configuration

### Environment Variables

Edit `.env` to customize:

```bash
# Application
APP_NAME=Laravel
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8000

# Database
DB_CONNECTION=pgsql
DB_HOST=postgres
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret

# Cache & Queue
CACHE_STORE=redis
QUEUE_CONNECTION=redis
REDIS_HOST=redis
REDIS_PORT=6379

# Email (Mailpit)
MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_FROM_ADDRESS=laravel@example.com

# Session
SESSION_DRIVER=cookie
```

### Docker Customization

Edit `docker-compose.yaml` to:

-   Change port mappings
-   Adjust resource limits
-   Add environment variables
-   Configure health checks

## 🐛 Troubleshooting

### Containers won't start

```bash
# Clean up and restart
docker compose down
docker compose up --build
```

### Port already in use

Change port in `docker-compose.yaml`:

```yaml
ports:
    - "8001:80" # Change 8000 to another port
```

### Database migration errors

```bash
# Reset and re-run migrations
./app php artisan migrate:fresh --seed
```

### Container shell access

```bash
./app.cli
# or
docker compose exec app bash
```

### View logs

```bash
# All services
docker compose logs

# Specific service
docker compose logs app
docker compose logs postgres

# Real-time logs
docker compose logs -f app
```

## 📦 Included Packages

### Laravel Framework

-   `laravel/framework: ^12.0` - Core framework
-   `laravel/tinker: ^2.10.1` - PHP REPL
-   `laravel/pail: ^1.2` - Log viewer

### Development Tools

-   `laravel/pint: ^1.24` - Code formatting
-   `laravel/sail: ^1.41` - Docker environment
-   `phpunit/phpunit: ^11.5.3` - Testing framework
-   `mockery/mockery: ^1.6` - Mocking library
-   `fakerphp/faker: ^1.23` - Fake data generation

### Frontend

-   `vite: ^7.0.7` - Build tool
-   `tailwindcss: ^4.0.0` - CSS framework
-   `laravel-vite-plugin: ^2.0.0` - Vite integration
-   `axios: ^1.11.0` - HTTP client

## 🚢 Deployment

### Production Considerations

1. Update `.env` with production values
2. Set `APP_ENV=production`
3. Set `APP_DEBUG=false`
4. Generate app key: `./app php artisan key:generate`
5. Rebuild image without development dependencies
6. Use secrets management instead of plain text .env

### Building for Production

```bash
# Build image for production
docker build -f .docker/Dockerfile -t laravel-app:prod .

# Run with production compose file
docker compose -f docker-compose.prod.yml up
```

## 📚 Learning Resources

-   [Laravel Documentation](https://laravel.com/docs)
-   [Docker Documentation](https://docs.docker.com/)
-   [PostgreSQL Documentation](https://www.postgresql.org/docs/)
-   [Redis Documentation](https://redis.io/documentation)

## 📝 License

This project is open-sourced software licensed under the MIT license.

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Run tests: `./app php artisan test`
4. Format code: `./app ./vendor/bin/pint`
5. Submit a pull request

## ⚡ Performance Tips

-   Use `docker compose up -d` for background operation
-   Enable Docker Desktop resource limits to prevent slowdown
-   Regular `./app composer install` to keep dependencies current
-   Use Redis for caching instead of file caching
-   Monitor logs with `docker compose logs -f app`

## 🆘 Support

For issues or questions:

1. Check the Troubleshooting section
2. Review container logs
3. Ensure all services are healthy: `docker compose ps`
4. Verify environment variables in `.env`

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

-   **[Vehikl](https://vehikl.com)**
-   **[Tighten Co.](https://tighten.co)**
-   **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
-   **[64 Robots](https://64robots.com)**
-   **[Curotec](https://www.curotec.com/services/technologies/laravel)**
-   **[DevSquad](https://devsquad.com/hire-laravel-developers)**
-   **[Redberry](https://redberry.international/laravel-development)**
-   **[Active Logic](https://activelogic.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
