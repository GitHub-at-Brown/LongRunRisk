#!/bin/bash
set -euo pipefail

if [ -n "${MATHEMATICA_MATH:-}" ]; then
  MATH="$MATHEMATICA_MATH"
elif command -v math >/dev/null 2>&1; then
  MATH="$(command -v math)"
elif [ -f "/apps/Mathematica/13.1/Executables/math" ]; then
  MATH="/apps/Mathematica/13.1/Executables/math"
else
  echo "ERROR: 'math' executable not found" >&2
  echo "Set MATHEMATICA_MATH environment variable or add 'math' to PATH" >&2
  exit 1
fi

"$MATH" -script CreateMomentsDatabase.wls