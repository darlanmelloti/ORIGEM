#!/usr/bin/env bash
# QA-CASA-VOSS-HIGHLAND-060 — prova de 60 s da descida Casa Voss por teclas X11 reais.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT_BIN="${GODOT_BIN:-godot}"
OUTPUT_DIR="${QA_OUTPUT_DIR:-$ROOT/qa_evidence_casa_voss_highland_060}"
PROBE_ID="QA-CASA-VOSS-HIGHLAND-060"
mkdir -p "$OUTPUT_DIR"

inside_xvfb() {
  local log="$OUTPUT_DIR/casa_voss_highland_060.log"
  local pid=""
  cleanup() {
    xdotool keyup w 2>/dev/null || true
    xdotool keyup a 2>/dev/null || true
    xdotool keyup s 2>/dev/null || true
    xdotool keyup d 2>/dev/null || true
    if [[ -n "${pid:-}" ]]; then
      kill "$pid" 2>/dev/null || true
      wait "$pid" 2>/dev/null || true
    fi
  }
  trap cleanup EXIT

  env \
    ORIGEM_QA_AUTOSTART_NEW_GAME=1 \
    ORIGEM_QA_ROUTE=voss_to_road \
    ORIGEM_QA_CASA_VOSS_HIGHLAND=1 \
    ORIGEM_QA_OUTPUT_DIR="$OUTPUT_DIR" \
    GODOT_SILENCE_ROOT_WARNING=1 \
    "$GODOT_BIN" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" >"$log" 2>&1 &
  pid=$!

  sleep 6
  local wid
  wid=$(xdotool search --name "ORIGEM" 2>/dev/null | tail -n 1 || true)
  if [[ -z "$wid" ]]; then
    echo "[$PROBE_ID-FAIL] janela ORIGEM não encontrada" >>"$log"
    exit 2
  fi
  xdotool windowactivate "$wid" 2>/dev/null || true
  xdotool mousemove --window "$wid" 640 360 click 1 2>/dev/null || true

  local deadline=$((SECONDS + 25))
  until grep -q "\[$PROBE_ID-START\]" "$log"; do
    if (( SECONDS >= deadline )); then
      echo "[$PROBE_ID-FAIL] spawn de patamar ausente" >>"$log"
      exit 3
    fi
    sleep 1
  done

  # Percurso real: desce, cruza a estrada, testa o desvio lateral e regressa ao eixo.
  xdotool keydown w; sleep 19; xdotool keyup w
  xdotool keydown d; sleep 8; xdotool keyup d
  xdotool keydown w; sleep 14; xdotool keyup w
  xdotool keydown a; sleep 8; xdotool keyup a
  xdotool keydown s; sleep 4; xdotool keyup s
  xdotool keydown w; sleep 8; xdotool keyup w

  deadline=$((SECONDS + 18))
  until grep -q "\[$PROBE_ID-RESULT\]" "$log"; do
    if (( SECONDS >= deadline )); then
      echo "[$PROBE_ID-FAIL] resultado ausente após 60 s" >>"$log"
      exit 4
    fi
    sleep 1
  done
  wait "$pid" || true
  pid=""

  if grep -Eqi 'Parse Error|SCRIPT ERROR|Invalid access|Failed loading resource|Cannot load resource|Segmentation fault' "$log"; then
    cat "$log"
    exit 5
  fi
  if ! grep -q "\[$PROBE_ID-RESULT\].*\"passed\":true" "$log"; then
    cat "$log"
    exit 6
  fi
  printf '%s aprovado\nEvidências: %s\n' "$PROBE_ID" "$OUTPUT_DIR"
}

if [[ "${1:-}" == "--inside-xvfb" ]]; then
  inside_xvfb
  exit 0
fi

command -v "$GODOT_BIN" >/dev/null 2>&1 || test -x "$GODOT_BIN"
command -v xvfb-run >/dev/null
command -v xdotool >/dev/null
rm -f "$OUTPUT_DIR/casa_voss_highland_060.log" "$OUTPUT_DIR"/*.png
xvfb-run -a -s '-screen 0 1600x900x24' env GODOT_BIN="$GODOT_BIN" QA_OUTPUT_DIR="$OUTPUT_DIR" "$0" --inside-xvfb
