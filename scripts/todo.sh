#!/usr/bin/env bash

set -e

FILE="TODO.md"

# Map flags → markers
declare -A MARKS=(
  ["-N"]="\\[ \\]"         # Not started
  ["-H"]="\\[/\\]|\\[<\\]" # Half done OR On hold
  ["-D"]="\\[-\\]"         # Dropped
  ["-T"]="\\[>\\]"         # Transferred
  ["-Q"]="\\[\\?\\]"       # Question
  ["-I"]="\\[!\\]"         # Important
  ["-C"]="\\[x\\]"         # Completed
)

# Build regex from input flags
regex=""

for arg in "$@"; do
  if [[ -n "${MARKS[$arg]}" ]]; then
    if [[ -z "$regex" ]]; then
      regex="${MARKS[$arg]}"
    else
      regex="$regex|${MARKS[$arg]}"
    fi
  else
    echo "Unknown flag: $arg"
    exit 1
  fi
done

if [[ -z "$regex" ]]; then
  echo "Usage: $0 [-N] [-H] [-D] [-T] [-Q] [-I] [-C]"
  exit 1
fi

# Filter TODO items only (ignore note section)
awk '/^# TODO list/,/^> \[!NOTE\]/' "$FILE" | grep -E "^- .*($regex)"
