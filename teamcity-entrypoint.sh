#!/usr/bin/env bash
set -euo pipefail

# Gracefully handle stop signals
cleanup() {
  echo "⚙️  Stopping TeamCity..."
  /opt/TeamCity/bin/runAll.sh stop
  exit 0
}
trap 'cleanup' SIGINT SIGTERM

echo "⚙️  Starting TeamCity..."
# start both server + agent
/opt/TeamCity/bin/runAll.sh start

echo "📝  Tailing TeamCity logs..."
# replace these paths if your install dir differs
exec tail -F \
  /opt/TeamCity/logs/teamcity-server.log \
  /opt/TeamCity/logs/teamcity-agent.log
