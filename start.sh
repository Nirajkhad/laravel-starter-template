#!/bin/bash
set -e

echo "Starting application..."

export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

echo "Using UID:GID = $HOST_UID:$HOST_GID"

if [ ! -f .env ]; then
  cp .env.example .env
fi

docker compose down
docker compose build --no-cache
docker compose up
