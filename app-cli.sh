set -e

# Auto-detect host user/group
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

#!/bin/bash
docker compose exec -it app bash
