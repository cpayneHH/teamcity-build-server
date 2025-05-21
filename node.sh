#!/usr/bin/env bash
set -euo pipefail

#— 1. Install prerequisites —#
echo "🔄 Updating apt and installing prerequisites..."
apt-get update -qq
apt-get install -y curl ca-certificates

#— 2. Add NodeSource Node.js 18.x repo —#
echo "🔄 Adding Node.js 18.x repository..."
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

export NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

#— 3. Install Node.js —#
echo "🔄 Installing Node.js 18.x..."
apt-get update
apt-get install -y nodejs

#— 4. (Optional) Build tools —#
# Uncomment if you need to compile native addons
# echo "🔄 Installing build-essential..."
# apt-get install -y build-essential

#— 5. Verify installation —#
echo "✅ Installed Node.js version: $(node -v)"
echo "✅ Installed npm version: $(npm -v)"
