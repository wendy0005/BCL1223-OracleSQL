#/usr/bin/env bash
# Run a SQL script against the local Oracle Docker container
# Usage: ./run_sql.sh [sql_file]
# Default: 20260718_Database_Fundamentals_Assignment_LiveSQL.sql

SQL_FILE="${1:-20260718_Database_Fundamentals_Assignment_LiveSQL.sql}"

if [ ! -f "$SQL_FILE" ]; then
  echo "Error: $SQL_FILE not found."
  exit 1
fi

echo "=== Running $SQL_FILE against Oracle ==="
docker exec -i oracle-demo sqlplus system/oracle@//localhost:1521/FREEPDB1 < "$SQL_FILE"
