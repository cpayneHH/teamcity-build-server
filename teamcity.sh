#!/usr/bin/env bash
set -euov pipefail

ARCHIVE_NAME="TeamCity-${TEAMCITY_VERSION}.tar.gz"
DOWNLOAD_URL="https://download.jetbrains.com/teamcity/${ARCHIVE_NAME}"

#— 1. Create dedicated user if it doesn't exist —#
if ! id "$TEAMCITY_USER" &>/dev/null; then
  useradd --system --shell /usr/sbin/nologin --comment "TeamCity CI user" "$TEAMCITY_USER"
  echo "✔ Created system user '$TEAMCITY_USER'"
else
  echo "ℹ User '$TEAMCITY_USER' already exists, skipping creation"
fi

#— 2. Install Java and wget —#
echo "🔄 Updating package lists and installing prerequisites..."
apt-get update -qq
apt-get install -y openjdk-11-jre-headless wget

#— 3. Download & extract TeamCity —#
echo "🔄 Downloading TeamCity $TEAMCITY_VERSION..."
mkdir -p "$TEAMCITY_HOME"
cd "$TEAMCITY_HOME"
wget -q "$DOWNLOAD_URL" -O "$ARCHIVE_NAME"

echo "🔄 Extracting archive..."
tar xzf "$ARCHIVE_NAME" --strip-components=1
rm "$ARCHIVE_NAME"

# (re-ensure permissions in case you mount a volume)
chown -R "${TEAMCITY_USER}:${TEAMCITY_USER}" "${TEAMCITY_HOME}"