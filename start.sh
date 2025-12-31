#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔═══════════════════════════════════╗${NC}"
echo -e "${BLUE}║ Laravel Starter Template - Start  ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════╝${NC}\n"

# Navigate to project directory
cd "$(dirname "$0")" || exit 1

# Stop all other Docker containers to avoid port conflicts
echo -e "${YELLOW}Cleaning up Docker environment...${NC}"
OTHER_CONTAINERS=$(docker ps -q --filter "label!=com.docker.compose.project=laravel-starter-template" 2>/dev/null)
if [ -n "$OTHER_CONTAINERS" ]; then
    echo -e "${YELLOW}Stopping containers from other projects...${NC}"
    docker stop $OTHER_CONTAINERS 2>/dev/null
fi

# Start the app
echo -e "${YELLOW}Starting Laravel application (optimized)...${NC}"
docker compose up
sleep 5

# Check health status
HEALTH_CHECK=0
for i in {1..30}; do
    if docker compose exec -T app curl -f http://localhost:80/ > /dev/null 2>&1; then
        HEALTH_CHECK=1
        break
    fi
    echo -n "."
    sleep 1
done

echo ""
if [ $HEALTH_CHECK -eq 1 ]; then
    echo -e "${GREEN}✓ Application is healthy!${NC}\n"
else
    echo -e "${YELLOW}⚠ Application is starting. Checking services...${NC}\n"
fi

