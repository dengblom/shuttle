#!/bin/bash
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$REPO_ROOT/Shuttle/apple-scpt"
echo "compiling applescripts for iTerm Stable..."
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/iTerm2-stable-new-window.scpt" -x "$REPO_ROOT/apple-scripts/iTermStable/iTerm2-stable-new-window.applescript"
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/iTerm2-stable-current-window.scpt" -x "$REPO_ROOT/apple-scripts/iTermStable/iTerm2-stable-current-window.applescript"
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/iTerm2-stable-new-tab-default.scpt" -x "$REPO_ROOT/apple-scripts/iTermStable/iTerm2-stable-new-tab-default.applescript"
