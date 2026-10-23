#!/usr/bin/env bash
# PreToolUse: keep production secrets in .env out of Claude's context and untouched.
set -euo pipefail

file_path=$(jq -r '.tool_input.file_path // ""')

if [[ "$(basename "$file_path")" == ".env" ]]; then
    echo "Blocked: .env holds secrets. Ask the user for the value you need." >&2
    exit 2
fi
