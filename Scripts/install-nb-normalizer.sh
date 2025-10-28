#!/usr/bin/env bash
set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "[install-nb-normalizer] git not found on PATH" >&2
  exit 1
fi

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "[install-nb-normalizer] not inside a git repository" >&2
  exit 1
}

cd "$ROOT"

git config core.hooksPath .githooks

chmod +x .githooks/pre-commit scripts/nb-clean.wls

if ! command -v wolframscript >/dev/null 2>&1; then
  echo "[install-nb-normalizer] ERROR: wolframscript not found on PATH" >&2
  echo "[install-nb-normalizer] Install Wolfram Engine/Mathematica or add wolframscript to PATH before continuing." >&2
  exit 1
fi

echo "[install-nb-normalizer] caching ResourceFunction[\"SaveReadableNotebook\"]..."
if wolframscript -code 'Needs["ResourceFunction`"]; ResourceFunction["SaveReadableNotebook"];' >/dev/null 2>&1; then
  echo "[install-nb-normalizer] resource cached successfully"
else
  echo "[install-nb-normalizer] WARNING: failed to cache resource; first run may download it" >&2
fi

echo "[install-nb-normalizer] Notebook normalization hook installed."
