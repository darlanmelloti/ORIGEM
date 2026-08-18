#!/usr/bin/env bash
# QA-INPUT-01 — porta E, pausa/cursor e retorno Orion por E.
# Uso: GODOT_BIN=/caminho/Godot_v4.x QA_OUTPUT_DIR=/caminho/evidencias ./tools/qa/verify_input_flow.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT_BIN="${GODOT_BIN:-godot}"
OUTPUT_DIR="${QA_OUTPUT_DIR:-$ROOT/qa_evidence_voss_vista}"
mkdir -p "$OUTPUT_DIR"

check_log() {
  local log="$1"
  if grep -Eqi 'Parse Error|SCRIPT ERROR|Invalid access|game_paused.*Nil|Failed loading resource|Unable to open file|Cannot load resource|Segmentation fault' "$log"; then
    cat "$log"
    exit 1
  fi
}

main_session() {
  local log="$OUTPUT_DIR/qa_input01_main_30s.log"
  ORIGEM_QA_SKIP_OPENING=1 GODOT_SILENCE_ROOT_WARNING=1 "$GODOT_BIN" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" "res://scenes/main.tscn" > "$log" 2>&1 &
  local pid=$!
  cleanup() { if [ -n "${pid:-}" ]; then kill "$pid" 2>/dev/null || true; wait "$pid" 2>/dev/null || true; fi; }
  trap cleanup EXIT
  sleep 5
  local wid
  wid=$(xdotool search --name "ORIGEM" 2>/dev/null | tail -n 1 || true)
  if [ -n "$wid" ]; then
    xdotool windowactivate "$wid" 2>/dev/null || true
    xdotool mousemove --window "$wid" 640 360 click 1 2>/dev/null || true
  fi
  xdotool key e
  sleep 2
  xdotool key Escape
  sleep 2
  ffmpeg -y -loglevel error -f x11grab -video_size 1280x720 -i "$DISPLAY" -frames:v 1 "$OUTPUT_DIR/qa_input01_pause.png" || true
  xdotool key Escape
  sleep 19
  ffmpeg -y -loglevel error -f x11grab -video_size 1280x720 -i "$DISPLAY" -frames:v 1 "$OUTPUT_DIR/qa_input01_resumed.png" || true
}

orion_session() {
  local log="$OUTPUT_DIR/qa_input01_orion_return_30s.log"
  GODOT_SILENCE_ROOT_WARNING=1 "$GODOT_BIN" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" "res://scenes/orion_interior.tscn" > "$log" 2>&1 &
  local pid=$!
  cleanup() { if [ -n "${pid:-}" ]; then kill "$pid" 2>/dev/null || true; wait "$pid" 2>/dev/null || true; fi; }
  trap cleanup EXIT
  sleep 5
  local wid
  wid=$(xdotool search --name "ORIGEM" 2>/dev/null | tail -n 1 || true)
  if [ -n "$wid" ]; then
    xdotool windowactivate "$wid" 2>/dev/null || true
    xdotool mousemove --window "$wid" 640 360 click 1 2>/dev/null || true
  fi
  xdotool key e
  sleep 25
  ffmpeg -y -loglevel error -f x11grab -video_size 1280x720 -i "$DISPLAY" -frames:v 1 "$OUTPUT_DIR/qa_input01_orion_return.png" || true
}

case "${1:-}" in
  --main-session)
    main_session
    exit 0
    ;;
  --orion-session)
    orion_session
    exit 0
    ;;
esac

command -v "$GODOT_BIN" >/dev/null 2>&1 || test -x "$GODOT_BIN"
command -v xvfb-run >/dev/null
command -v xdotool >/dev/null
command -v ffmpeg >/dev/null
rm -f "$OUTPUT_DIR/qa_input01_main_30s.log" "$OUTPUT_DIR/qa_input01_orion_return_30s.log" "$OUTPUT_DIR/qa_input01_pause.png" "$OUTPUT_DIR/qa_input01_resumed.png" "$OUTPUT_DIR/qa_input01_orion_return.png"
xvfb-run -a -s '-screen 0 1280x720x24' env GODOT_BIN="$GODOT_BIN" QA_OUTPUT_DIR="$OUTPUT_DIR" "$0" --main-session
check_log "$OUTPUT_DIR/qa_input01_main_30s.log"
test -s "$OUTPUT_DIR/qa_input01_pause.png"
test -s "$OUTPUT_DIR/qa_input01_resumed.png"
xvfb-run -a -s '-screen 0 1280x720x24' env GODOT_BIN="$GODOT_BIN" QA_OUTPUT_DIR="$OUTPUT_DIR" "$0" --orion-session
check_log "$OUTPUT_DIR/qa_input01_orion_return_30s.log"
test -s "$OUTPUT_DIR/qa_input01_orion_return.png"
printf 'QA-INPUT-01 aprovado\nEvidências: %s\n' "$OUTPUT_DIR"
