#!/bin/bash
# Regenerate compiled AppleScripts into Shuttle/apple-scpt/.
# Icons (StatusIcon*.png, shuttle.icns) are committed assets — not generated here.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "==> Compiling Terminal AppleScripts"
./compile-Terminal.sh

echo "==> Compiling Virtual AppleScripts"
./compile-Virtual.sh

if [[ "${SKIP_ITERM:-0}" == "1" ]]; then
  echo "==> Skipping iTerm AppleScripts (SKIP_ITERM=1)"
else
  if [[ -d "/Applications/iTerm.app" || -d "/Applications/iTerm2.app" ]]; then
    echo "==> Compiling iTerm Stable AppleScripts"
    ./compile-iTermStable.sh
    echo "==> Compiling iTerm Nightly AppleScripts"
    ./compile-iTermNightly.sh
  else
    echo "==> iTerm2 not installed — keeping committed iTerm .scpt files"
    echo "    Install iTerm2 and re-run, or set SKIP_ITERM=1 to silence this."
  fi
fi

echo "==> Prepared AppleScripts in Shuttle/apple-scpt/"
ls -la ../Shuttle/apple-scpt/
