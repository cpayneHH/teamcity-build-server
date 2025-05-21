#!/usr/bin/env bash
set -euo pipefail

#— 3. Install Yarn —#
echo "🔄 Installing Yarn..."
if [ $YARN_VERSION == 'latest']
  then
    # New yarn version selector helper
    npm install -g corepack
    npx corepack enable

    # navigate to the project directory
      # set the version
      # this set the version in the package.json
      yarn set_version stable
  else
    npm install -g yarn@${YARN_VERSION}
fi

#— 4. Verify installation —#
echo
echo "✅ Installed Yarn version: $(yarn --version)"
