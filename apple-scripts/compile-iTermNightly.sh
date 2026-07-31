#!/bin/bash
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$REPO_ROOT/Shuttle/apple-scpt"
echo "compiling applescripts for iTerm Nightly..."
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/iTerm2-nightly-new-window.scpt" -x "$REPO_ROOT/apple-scripts/iTermNightly/iTerm2-nightly-new-window.applescript"
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/iTerm2-nightly-current-window.scpt" -x "$REPO_ROOT/apple-scripts/iTermNightly/iTerm2-nightly-current-window.applescript"
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/iTerm2-nightly-new-tab-default.scpt" -x "$REPO_ROOT/apple-scripts/iTermNightly/iTerm2-nightly-new-tab-default.applescript"
