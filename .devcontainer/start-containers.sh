#!/bin/bash
# Start containers on Codespace restart (runs quickly)

docker start oracle-demo 2>/dev/null || true

if docker container inspect cloudbeaver > /dev/null 2>&1; then
  docker start cloudbeaver 2>/dev/null || true
fi

echo "Containers started (or already running)."
echo "Check: docker ps"
