#!/usr/bin/env bash
set -euo pipefail

ROUTE="${1:-handoff_to_village}"
OUT="${2:?uso: run_dev3_take3_capture.sh [rota] <directorio_evidencia>}"
ROOT=/home/ubuntu/work/ORIGEM_director_cinematic_polish_pass02
GODOT=/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64
DISPLAY_NUM=:119
SNAPSHOT="$OUT/${ROUTE}_36s.png"

mkdir -p "$OUT"
GODOT_SILENCE_ROOT_WARNING=1 timeout 180 "$GODOT" --headless --path "$ROOT" --editor --quit >"$OUT/parser.log" 2>&1
if grep -Eqi 'Parse Error|SCRIPT ERROR|Compile Error|Failed to load script|Failed loading resource|Unable to open file' "$OUT/parser.log"; then
  cat "$OUT/parser.log"
  exit 1
fi

Xvfb "$DISPLAY_NUM" -screen 0 1600x900x24 >"$OUT/xvfb.log" 2>&1 &
XVFB_PID=$!
GAME_PID=""
cleanup() {
  DISPLAY="$DISPLAY_NUM" xdotool keyup w 2>/dev/null || true
  [ -n "$GAME_PID" ] && kill "$GAME_PID" 2>/dev/null || true
  [ -n "$GAME_PID" ] && wait "$GAME_PID" 2>/dev/null || true
  kill "$XVFB_PID" 2>/dev/null || true
  wait "$XVFB_PID" 2>/dev/null || true
}
trap cleanup EXIT
sleep 1
DISPLAY="$DISPLAY_NUM" ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_ROUTE="$ROUTE" ORIGEM_QA_CLEAN_CARTOGRAPHIC_MARKERS=1 GODOT_SILENCE_ROOT_WARNING=1 "$GODOT" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" >"$OUT/runtime_36s.log" 2>&1 &
GAME_PID=$!
sleep 10
DISPLAY="$DISPLAY_NUM" xdotool keydown w || true
sleep 20
WINDOW_ID="$(DISPLAY="$DISPLAY_NUM" xdotool search --onlyvisible --name 'ORIGEM' 2>/dev/null | tail -n 1 || true)"
if [ -n "$WINDOW_ID" ]; then
  DISPLAY="$DISPLAY_NUM" import -window "$WINDOW_ID" "$SNAPSHOT" 2>/dev/null || true
fi
if [ ! -s "$SNAPSHOT" ]; then
  DISPLAY="$DISPLAY_NUM" xwd -root -silent >"$OUT/${ROUTE}_30s.xwd" 2>/dev/null || true
  if [ -s "$OUT/${ROUTE}_30s.xwd" ]; then
    convert "$OUT/${ROUTE}_30s.xwd" "$SNAPSHOT" 2>/dev/null || true
  fi
fi
DISPLAY="$DISPLAY_NUM" xdotool keyup w || true
sleep 5
kill "$GAME_PID" 2>/dev/null || true
wait "$GAME_PID" 2>/dev/null || true
GAME_PID=""
if grep -Eqi 'Parse Error|SCRIPT ERROR|Compile Error|Failed loading resource|Unable to open file|Segmentation fault' "$OUT/runtime_36s.log"; then
  cat "$OUT/runtime_36s.log"
  exit 1
fi
printf 'route=%s duration_seconds=36 snapshot=%s\n' "$ROUTE" "$SNAPSHOT" | tee "$OUT/summary.txt"
test -s "$SNAPSHOT"
