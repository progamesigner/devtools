#!/bin/bash

set -e

if [ -d $HOME/.claude ]; then
    if [ -f $HOME/.claude.json ] && [ ! -L $HOME/.claude.json ]; then
        mv -f $HOME/.claude.json $HOME/.claude/.claude.json
    fi
    ln -sf $HOME/.claude/.claude.json $HOME/.claude.json
fi

echo "Installing / Updating Claude Code ..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Installed Claude Code version: $(claude --version)"

if [ "$#" -eq 0 ]; then
    exec claude remote-control --name "${CLAUDE_NAME:-default}" --spawn=same-dir --no-create-session-in-dir
else
    exec "$@"
fi
