#!/bin/bash
set -e

echo "=== BCL1223 Oracle Demo Setup ==="

# --------------- Oracle Free Container ---------------
if docker container inspect oracle-demo > /dev/null 2>&1; then
  status=$(docker inspect -f '{{.State.Status}}' oracle-demo 2>/dev/null)
  if [ "$status" = "running" ]; then
    echo "Oracle container already running."
  else
    echo "Starting existing Oracle container..."
    docker start oracle-demo
  fi
else
  echo "=== Pulling Oracle Free image ==="
  docker pull gvenzl/oracle-free:latest
  echo "=== Starting Oracle Free container ==="
  docker run -d --name oracle-demo \
    -p 1521:1521 \
    -e ORACLE_PASSWORD=oracle \
    gvenzl/oracle-free:latest
fi

# --------------- CloudBeaver GUI Container ---------------
if docker container inspect cloudbeaver > /dev/null 2>&1; then
  status=$(docker inspect -f '{{.State.Status}}' cloudbeaver 2>/dev/null)
  if [ "$status" = "running" ]; then
    echo "CloudBeaver container already running."
  else
    echo "Starting existing CloudBeaver container..."
    docker start cloudbeaver
  fi
else
  echo "=== Pulling CloudBeaver image ==="
  docker pull dbeaver/cloudbeaver:latest
  echo "=== Starting CloudBeaver container ==="
  docker run -d --name cloudbeaver \
    --network container:oracle-demo \
    dbeaver/cloudbeaver:latest
fi

# --------------- Network ---------------
# Ensure both containers can communicate
docker network create oracle-net 2>/dev/null || true
docker network connect oracle-net oracle-demo 2>/dev/null || true
docker network connect oracle-net cloudbeaver 2>/dev/null || true

# --------------- Wait for Oracle ---------------
echo "=== Waiting for Oracle database to be ready ==="
for i in $(seq 1 120); do
  if docker logs oracle-demo 2>&1 | grep -q "DATABASE IS READY TO USE"; then
    echo ""
    echo "=== Oracle is ready! ==="
    break
  fi
  printf "."
  sleep 5
done

echo ""
echo "=== CloudBeaver starting up (port 8978) ==="
echo "Open http://localhost:8978 in the Codespace browser"
echo "Create admin account on first visit, then add connection:"
echo "  Host: localhost | Port: 1521"
echo "  Database: FREEPDB1 | User: system | Password: oracle"
echo ""
echo "=== Terminal commands ==="
echo "Run SQL:   docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 01_show_tables.sql"
echo "Interactive: docker exec -it oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1"
