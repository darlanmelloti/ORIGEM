#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT="${GODOT_BIN:-}"
if [ -z "$GODOT" ]; then
  GODOT="$(command -v Godot_v4.7.1-stable_linux.x86_64 || command -v godot || true)"
fi
if [ -z "$GODOT" ] && [ -x /home/ubuntu/tools/godot-4.7.1/Godot_v4.7.1-stable_linux.x86_64 ]; then
  GODOT=/home/ubuntu/tools/godot-4.7.1/Godot_v4.7.1-stable_linux.x86_64
fi
if [ -z "$GODOT" ] || [ ! -x "$GODOT" ]; then
  echo 'Godot 4.7.1 não encontrado; defina GODOT_BIN ou disponibilize o binário no PATH.' >&2
  exit 2
fi
OUT="${1:?uso: capture_r6_arrival_runtime.sh <directorio_evidencia> [rota]}"
DISPLAY_NUM="${ORIGEM_QA_DISPLAY:-:124}"
ROUTE="${2:-ruins_arrival}"
case "$ROUTE" in
  forest_to_ruins) SPAWN_MARKER='Spawn Floresta–Ruínas' ;;
  majestic_to_lake) SPAWN_MARKER='Spawn Majestic–lago' ;;
  ruins_arrival) SPAWN_MARKER='Spawn Chegada Ruínas' ;;
  *)
    echo "Rota R6 inválida: $ROUTE. Use forest_to_ruins, majestic_to_lake ou ruins_arrival." >&2
    exit 2
    ;;
esac
SNAPSHOT="$OUT/${ROUTE}_postload.png"
RUNTIME_LOG="$OUT/runtime.log"

mkdir -p "$OUT"
"$GODOT" --headless --path "$ROOT" --editor --quit --rendering-driver opengl3 >"$OUT/parser.log" 2>&1
if grep -Eqi 'Parse Error|SCRIPT ERROR|Compile Error|Failed to load script|Failed loading resource|Unable to open file' "$OUT/parser.log"; then
  cat "$OUT/parser.log"
  exit 1
fi

Xvfb "$DISPLAY_NUM" -screen 0 1600x900x24 >"$OUT/xvfb.log" 2>&1 &
XVFB_PID=$!
GAME_PID=""
cleanup() {
  [ -n "$GAME_PID" ] && kill "$GAME_PID" 2>/dev/null || true
  [ -n "$GAME_PID" ] && wait "$GAME_PID" 2>/dev/null || true
  kill "$XVFB_PID" 2>/dev/null || true
  wait "$XVFB_PID" 2>/dev/null || true
}
trap cleanup EXIT
sleep 2
DISPLAY="$DISPLAY_NUM" ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_ROUTE="$ROUTE" ORIGEM_QA_CLEAN_CARTOGRAPHIC_MARKERS=1 GODOT_SILENCE_ROOT_WARNING=1 "$GODOT" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" >"$RUNTIME_LOG" 2>&1 &
GAME_PID=$!

spawned=0
for _ in $(seq 1 35); do
  if grep -Fq "[ORIGEM_QA_ROUTE] $SPAWN_MARKER" "$RUNTIME_LOG" 2>/dev/null; then
    spawned=1
    break
  fi
  sleep 1
done
if [ "$spawned" -ne 1 ]; then
  cat "$RUNTIME_LOG"
  echo "A rota $ROUTE não confirmou spawn dentro do limite de 35 segundos." >&2
  exit 1
fi
CAPTURE_SETTLE_SECONDS="${ORIGEM_QA_CAPTURE_SETTLE_SECONDS:-12}"
if ! [[ "$CAPTURE_SETTLE_SECONDS" =~ ^[0-9]+$ ]] || [ "$CAPTURE_SETTLE_SECONDS" -lt 4 ]; then
  echo "Tempo de estabilização de captura inválido: $CAPTURE_SETTLE_SECONDS" >&2
  exit 2
fi
sleep "$CAPTURE_SETTLE_SECONDS"
WINDOW_ID="$(DISPLAY="$DISPLAY_NUM" xdotool search --onlyvisible --name 'ORIGEM' 2>/dev/null | tail -n 1 || true)"
if [ -z "$WINDOW_ID" ]; then
  echo 'Janela ORIGEM não encontrada após o spawn R6.' >&2
  exit 1
fi
DISPLAY="$DISPLAY_NUM" import -window "$WINDOW_ID" "$SNAPSHOT"
GODOT_SILENCE_ROOT_WARNING=1 "$GODOT" --headless --path "$ROOT" --script res://qa/r6/inspect_r6_runtime_composition.gd --rendering-driver opengl3 >"$OUT/composition.log" 2>&1
if grep -Eqi 'ORIGEM_R6_RUNTIME_COMPOSITION_ERROR|Parse Error|SCRIPT ERROR|Compile Error' "$OUT/composition.log"; then
  cat "$OUT/composition.log"
  exit 1
fi
if grep -Eqi 'Parse Error|SCRIPT ERROR|Compile Error|Failed loading resource|Unable to open file|Segmentation fault' "$RUNTIME_LOG"; then
  cat "$RUNTIME_LOG"
  exit 1
fi
identify "$SNAPSHOT"
grep -F "[ORIGEM_QA_ROUTE] $SPAWN_MARKER" "$RUNTIME_LOG"
grep '\[ORIGEM_R6_RUNTIME_COMPOSITION\]' "$OUT/composition.log"
printf 'route=%s evidence=%s\n' "$ROUTE" "$SNAPSHOT" | tee "$OUT/summary.txt"
