#!/usr/bin/env bash
set -euo pipefail

#— 3. Install Yarn —#
echo "🔄 Installing Yarn..."
if [ $YARN_VERSION == 'latest']
  then
    npm install -g corepack
    npx corepack enable

    yarn set_version stable
    yarn install
  else
    npm install -g yarn@${YARN_VERSION}
fi

#— 4. Verify installation —#
echo
echo "✅ Installed Yarn version: $(yarn --version)"
