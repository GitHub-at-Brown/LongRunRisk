#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "[normalize-notebooks] not inside a git repository" >&2
  exit 1
}

cd "$ROOT"

if ! command -v wolframscript >/dev/null 2>&1; then
  echo "[normalize-notebooks] wolframscript not found on PATH" >&2
  exit 1
fi

nb_files=()
while IFS= read -r file; do
  nb_files+=("$file")
done < <(git ls-files '*.nb')

excludes=("ResourceDefinition.nb" "Tests/InteractiveTests/longRunRisk.nb")
filtered=()
for f in "${nb_files[@]}"; do
  skip=0
  for ex in "${excludes[@]}"; do
    if [ "$f" = "$ex" ]; then
      skip=1
      echo "[normalize-notebooks] skipping $f (excluded)"
      break
    fi
  done
  if [ $skip -eq 0 ]; then
    filtered+=("$f")
  fi

done

nb_files=("${filtered[@]}")

if [ "${#nb_files[@]}" -eq 0 ]; then
  echo "[normalize-notebooks] no tracked notebooks found"
  exit 0
fi

echo "[normalize-notebooks] cleaning ${#nb_files[@]} notebook(s)"

wolframscript -file "$ROOT/scripts/nb-clean.wls" "${nb_files[@]}"

echo "[normalize-notebooks] done. review changes with 'git status'."
