#!/bin/bash
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$REPO_ROOT/Shuttle/apple-scpt"
echo "compiling applescripts for OS X virtual..."
osacompile -o "$REPO_ROOT/Shuttle/apple-scpt/virtual-with-screen.scpt" -x "$REPO_ROOT/apple-scripts/virtual/virtual-with-screen.applescript"
