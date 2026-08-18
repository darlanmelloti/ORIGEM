#!/usr/bin/env bash
# Recupera um checkout cinematográfico real a partir da fonte Git canónica.
# Uso: tools/qa/bootstrap_dev3_workspace.sh [directório-destino]
set -euo pipefail

REPO_URL="https://github.com/darlanmelloti/ORIGEM.git"
BRANCH="feature/cine07-final"
TARGET="${1:-$HOME/work/ORIGEM_director_cinematic_polish_pass02}"
GODOT_BIN="${GODOT_BIN:-$HOME/tools/godot471/Godot_v4.7.1-stable_linux.x86_64}"

if [[ -d "$TARGET/.git" ]]; then
  git -C "$TARGET" fetch origin "$BRANCH"
  git -C "$TARGET" checkout "$BRANCH"
  git -C "$TARGET" pull --ff-only origin "$BRANCH"
else
  rm -rf "$TARGET"
  mkdir -p "$(dirname "$TARGET")"
  git clone --branch "$BRANCH" --single-branch "$REPO_URL" "$TARGET"
fi

if [[ ! -f "$TARGET/project.godot" ]]; then
  echo "ERRO: checkout recuperado sem project.godot: $TARGET" >&2
  exit 2
fi

GODOT_SILENCE_ROOT_WARNING=1 timeout 180 "$GODOT_BIN" --headless --path "$TARGET" --editor --quit
printf 'DEV3_WORKSPACE_READY=%s\n' "$TARGET"
printf 'DEV3_BRANCH=%s\n' "$(git -C "$TARGET" branch --show-current)"
printf 'DEV3_COMMIT=%s\n' "$(git -C "$TARGET" rev-parse --short HEAD)"
