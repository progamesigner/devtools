#!/bin/bash

set -e

echo "Installing / Updating Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Installed Claude Code version: $(claude --version)"

exec "$@"
