#!/bin/bash

set -e

echo "Installing / Updating Codex ..."
curl -fsSL https://chatgpt.com/codex/install.sh | sh

echo "Installed Codex version: $(codex --version)"

exec "$@"
