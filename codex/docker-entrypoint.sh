#!/bin/bash

set -e

rm -f \
  "${HOME}/.codex/app-server-control/app-server-control.sock" \
  "${HOME}/.codex/app-server-control/app-server-startup.lock" \
  "${HOME}/.codex/app-server-daemon/app-server-updater.pid" \
  "${HOME}/.codex/app-server-daemon/app-server-updater.pid.lock" \
  "${HOME}/.codex/app-server-daemon/app-server.pid.lock" \
  "${HOME}/.codex/app-server-daemon/daemon.lock"

echo "Installing / Updating Codex ..."
curl -fsSL https://chatgpt.com/codex/install.sh | sh

echo "Installed Codex version: $(codex --version)"

if [ "$#" -eq 0 ]; then
    exec codex remote-control
else
    exec "$@"
fi
