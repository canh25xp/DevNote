#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRIVATE_DIR="${SCRIPT_DIR}/../Privates"

if [[ ! -d "${PRIVATE_DIR}" ]]; then
  echo "Private notes directory not found: ${PRIVATE_DIR}" >&2
  exit 1
fi

if ! command -v chezmoi >/dev/null 2>&1; then
  echo "chezmoi command not found. Please install chezmoi before running this script." >&2
  exit 1
fi

REMOVE_SOURCE=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --rm|-r)
      REMOVE_SOURCE=true
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
  shift
done

found_any=false
while IFS= read -r -d '' note; do
  found_any=true
  encrypted_note="${note}.age"
  echo "Encrypting ${note} -> ${encrypted_note}"
  chezmoi encrypt "${note}" --output "${encrypted_note}"
  if [[ "${REMOVE_SOURCE}" == true ]]; then
    rm -f -- "${note}"
  fi
done < <(find "${PRIVATE_DIR}" -type f -name '*.md' -print0)

if [[ "${found_any}" == false ]]; then
  echo "No markdown notes found in ${PRIVATE_DIR}."
fi
