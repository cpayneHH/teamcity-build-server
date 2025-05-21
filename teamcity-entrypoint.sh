#!/usr/bin/env bash
set -e

# (re-ensure permissions in case you mount a volume)
chown -R "${TEAMCITY_USER}:${TEAMCITY_USER}" "${TEAMCITY_HOME}"

echo "🚀 Launching TeamCity…"
# exec so it becomes PID 1 and handles signals properly
exec "${TEAMCITY_HOME}/bin/runAll.sh" start
