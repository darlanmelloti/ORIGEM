#!/usr/bin/env bash
# QA-STATE-01: 36 s de runtime gráfico, clique em Novo Jogo e captura no 30.º segundo.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT_BIN="${GODOT_BIN:-/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64}"
OUT="${ORIGEM_QA_STATE_OUTPUT:-$ROOT/reports/qa_state_01_runtime}"
DISPLAY_NUM="${ORIGEM_QA_DISPLAY:-:121}"
rm -rf "$OUT"
mkdir -p "$OUT"
Xvfb "$DISPLAY_NUM" -screen 0 1600x900x24 >"$OUT/xvfb.log" 2>&1 &
XVFB_PID=$!
GAME_PID=""
cleanup() {
  if [ -n "$GAME_PID" ]; then kill "$GAME_PID" 2>/dev/null || true; wait "$GAME_PID" 2>/dev/null || true; fi
  kill "$XVFB_PID" 2>/dev/null || true
  wait "$XVFB_PID" 2>/dev/null || true
}
trap cleanup EXIT
sleep 1
# Cena principal directa: runtime real com autoloads, sem depender do foco do menu Xvfb.
DISPLAY="$DISPLAY_NUM" ORIGEM_QA_STATE_TRANSITION=1 ORIGEM_QA_CINE48_HANDOFF=1 GODOT_SILENCE_ROOT_WARNING=1 "$GODOT_BIN" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" res://scenes/main.tscn >"$OUT/runtime.log" 2>&1 &
GAME_PID=$!
sleep 30
DISPLAY="$DISPLAY_NUM" xwd -root -silent >"$OUT/orion_state_30s.xwd"
convert "$OUT/orion_state_30s.xwd" "$OUT/orion_state_30s.png"
# O runner interno fecha no segundo 33; não manter renderer llvmpipe acima da janela segura.
for _ in 1 2 3 4 5 6 7 8; do
  if ! kill -0 "$GAME_PID" 2>/dev/null; then break; fi
  sleep 1
done
if kill -0 "$GAME_PID" 2>/dev/null; then
  echo '[QA-STATE-01] runner não concluiu na janela segura' >&2
  exit 3
fi
wait "$GAME_PID" || true
GAME_PID=""
grep '\[QA-STATE-01-RESULT\]' "$OUT/runtime.log"
test -s "$OUT/orion_state_30s.png"
printf '[QA-STATE-01] captura=%s\n' "$OUT/orion_state_30s.png"
