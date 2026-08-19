#!/usr/bin/env bash
# QA-BUDGET-01 — prova de 36 s após Novo Jogo, complementar à sonda de orçamento.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT_BIN="${GODOT_BIN:-/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64}"
OUT_DIR="${OUT_DIR:-/home/ubuntu/qa_evidence_dev4_budget}"
DISPLAY_ID="${DISPLAY_ID:-:106}"
LOG="$OUT_DIR/qa_budget_gameplay_36s.log"
SNAPSHOT="$OUT_DIR/qa_budget_gameplay_36s.png"

mkdir -p "$OUT_DIR"
Xvfb "$DISPLAY_ID" -screen 0 1600x900x24 >/dev/null 2>&1 &
XVFB_PID=$!
GAME_PID=""
cleanup() {
  [ -n "$GAME_PID" ] && kill "$GAME_PID" 2>/dev/null || true
  [ -n "$GAME_PID" ] && wait "$GAME_PID" 2>/dev/null || true
  kill "$XVFB_PID" 2>/dev/null || true
  wait "$XVFB_PID" 2>/dev/null || true
}
trap cleanup EXIT
sleep 1
DISPLAY="$DISPLAY_ID" ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_VIEWPORT_SNAPSHOT="$SNAPSHOT" GODOT_SILENCE_ROOT_WARNING=1 \
  "$GODOT_BIN" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" >"$LOG" 2>&1 &
GAME_PID=$!
sleep 36
# O snapshot interno nem sempre está disponível nesta branch; captura X11 preserva a prova real antes de encerrar o jogo.
if [ ! -s "$SNAPSHOT" ]; then
  xwd -display "$DISPLAY_ID" -root -silent 2>/dev/null | convert xwd:- "$SNAPSHOT" 2>/dev/null || true
fi
kill "$GAME_PID" 2>/dev/null || true
wait "$GAME_PID" 2>/dev/null || true
GAME_PID=""
if grep -Eqi 'Parse Error|SCRIPT ERROR|Compile Error|Segmentation fault' "$LOG"; then
  cat "$LOG"
  exit 1
fi
test -s "$SNAPSHOT"
printf 'QA-BUDGET-01 gameplay=PASS duration_seconds=36 snapshot=%s\n' "$SNAPSHOT"
