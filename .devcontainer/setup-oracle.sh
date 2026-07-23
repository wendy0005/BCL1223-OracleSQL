#!/bin/bash
set -e

echo "=== BCL1223 Oracle Demo Setup ==="

if docker container inspect oracle-demo > /dev/null 2>&1; then
  status=$(docker inspect -f '{{.State.Status}}' oracle-demo 2>/dev/null)
  if [ "$status" = "running" ]; then
    echo "Oracle container is already running."
    echo ""
    echo "To run your SQL script:"
    echo "  docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 20260718_Database_Fundamentals_Assignment_LiveSQL.sql"
    echo ""
    echo "To open interactive SQL:"
    echo "  docker exec -it oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1"
    exit 0
  else
    echo "Starting existing container..."
    docker start oracle-demo
    echo "Container started. It will be ready in about 2 minutes."
    echo "Check status: docker logs oracle-demo"
    exit 0
  fi
fi

echo "=== Pulling Oracle Free image ==="
docker pull gvenzl/oracle-free:latest

echo "=== Starting Oracle Free container ==="
docker run -d --name oracle-demo \
  -p 1521:1521 \
  -e ORACLE_PASSWORD=oracle \
  gvenzl/oracle-free:latest

echo "=== Waiting for Oracle database to be ready ==="
echo "(This takes about 2-3 minutes...)"
for i in $(seq 1 120); do
  if docker logs oracle-demo 2>&1 | grep -q "DATABASE IS READY TO USE"; then
    echo ""
    echo "=== Oracle is ready! ==="
    echo ""
    echo "Run your SQL script:"
    echo "  docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < 20260718_Database_Fundamentals_Assignment_LiveSQL.sql"
    echo ""
    echo "Open interactive SQL:"
    echo "  docker exec -it oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1"
    exit 0
  fi
  printf "."
  sleep 5
done

echo ""
echo "Timed out waiting for Oracle."
echo "Check logs: docker logs oracle-demo"
exit 1
