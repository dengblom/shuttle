#!/bin/bash
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$REPO_ROOT/Shuttle/apple-scpt"
echo "compiling applescripts for OS X terminal..."
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/terminal-new-window.scpt" -x "$REPO_ROOT/apple-scripts/terminal/terminal-new-window.applescript"
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/terminal-current-window.scpt" -x "$REPO_ROOT/apple-scripts/terminal/terminal-current-window.applescript"
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/terminal-new-tab-default.scpt" -x "$REPO_ROOT/apple-scripts/terminal/terminal-new-tab-default.applescript"
