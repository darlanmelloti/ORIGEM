#!/usr/bin/env bash
# QA-PACKAGE-01 — valida um pacote recém-extraído antes de qualquer entrega.
# Uso: GODOT_BIN=/caminho/para/Godot_v4.x ./tools/qa/verify_clean_package.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT_BIN="${GODOT_BIN:-godot}"
WORK_DIR="$(mktemp -d /tmp/origem_package_qa.XXXXXX)"
ZIP_PATH="$WORK_DIR/ORIGEM_package_qa.zip"
EXTRACT_DIR="$WORK_DIR/extracted"
HEADLESS_LOG="$WORK_DIR/headless.log"
RUN_LOG="$WORK_DIR/menu_new_game.log"
FRAME_PATH="$WORK_DIR/new_game_30s.png"

cleanup() {
  if [ -n "${GAME_PID:-}" ]; then
    kill "$GAME_PID" 2>/dev/null || true
    wait "$GAME_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

command -v zip >/dev/null
command -v unzip >/dev/null
command -v xvfb-run >/dev/null
command -v xdotool >/dev/null
command -v ffmpeg >/dev/null
command -v "$GODOT_BIN" >/dev/null 2>&1 || [ -x "$GODOT_BIN" ]

cd "$ROOT"
zip -qr "$ZIP_PATH" . -x '.git/*' '.godot/*' 'qa_evidence_voss_vista/*' '*.zip' '__pycache__/*' '*.pyc'
mkdir -p "$EXTRACT_DIR"
unzip -q "$ZIP_PATH" -d "$EXTRACT_DIR"
test -f "$EXTRACT_DIR/project.godot"

GODOT_SILENCE_ROOT_WARNING=1 timeout 180 "$GODOT_BIN" --headless --path "$EXTRACT_DIR" --editor --quit > "$HEADLESS_LOG" 2>&1
if grep -Eqi 'Parse Error|SCRIPT ERROR|Invalid access to property|game_paused.*Nil|ERROR:' "$HEADLESS_LOG"; then
  cat "$HEADLESS_LOG"
  exit 1
fi

xvfb-run -a -s '-screen 0 1280x720x24' bash -lc '
  GODOT_SILENCE_ROOT_WARNING=1 "'$GODOT_BIN'" --audio-driver Dummy --rendering-driver opengl3 --path "'$EXTRACT_DIR'" > "'$RUN_LOG'" 2>&1 &
  GAME_PID=$!
  sleep 4
  WINDOW_ID=$(xdotool search --name "ORIGEM" 2>/dev/null | tail -n 1 || true)
  if [ -n "$WINDOW_ID" ]; then
    xdotool windowactivate "$WINDOW_ID" 2>/dev/null || true
    xdotool mousemove --window "$WINDOW_ID" 640 360 click 1 2>/dev/null || true
  fi
  sleep 0.5
  xdotool key Return
  sleep 30
  ffmpeg -y -loglevel error -f x11grab -video_size 1280x720 -i "$DISPLAY" -frames:v 1 "'$FRAME_PATH'" || true
  kill "$GAME_PID" 2>/dev/null || true
  wait "$GAME_PID" 2>/dev/null || true
'

if grep -Eqi 'Parse Error|SCRIPT ERROR|Invalid access to property|game_paused.*Nil|Segmentation fault|ERROR:' "$RUN_LOG"; then
  cat "$RUN_LOG"
  exit 1
fi
test -s "$FRAME_PATH"
printf 'QA-PACKAGE-01 aprovado\nZIP: %s\nSHA-256: ' "$ZIP_PATH"
sha256sum "$ZIP_PATH" | awk '{print $1}'
printf 'Captura: %s\nLogs: %s ; %s\n' "$FRAME_PATH" "$HEADLESS_LOG" "$RUN_LOG"
