#!/usr/bin/env bash
set -euo pipefail

info () { echo -e "\033[1;34m[postcreate]\033[0m $*"; }

# Go to workspace root (cloned Voyager repo)
cd /workspaces/"${PWD##*/}"

# --- Python (venv) ---
info "Creating Python virtual environment at ./.venv"
python -m venv .venv
source .venv/bin/activate

info "Upgrading pip + wheel + setuptools"
python -m pip install --upgrade pip wheel setuptools

info "Installing Voyager (editable mode)"
pip install -e .

# --- Node.js ---
if [[ -d "voyager/env/mineflayer" ]]; then
  cd voyager/env/mineflayer

  info "Installing Node npx"
  npm install -g npx

  info "Installing mineflayer deps"
  npm install

  cd mineflayer-collectblock
  info "Compiling TypeScript"
  npx tsc
  cd ..

  info "Installing mineflayer parent deps"
  npm install

  cd ../../..  # back to repo root
fi

# --- Version check ---
echo ""
info "Versions:"
echo "  Python: $(python -V 2>&1)"
echo "  Pip:    $(pip -V 2>&1)"
echo "  Node:   $(node -v 2>/dev/null || echo 'not found')"
echo "  npm:    $(npm -v 2>/dev/null || echo 'not found')"
echo "  Java:   $(java -version 2>&1 | head -n1 || echo 'not found')"
echo ""
info "Voyager environment ready."
