#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GODOT="${GODOT_BIN:-/home/ubuntu/godot-4.7.1/Godot_v4.7.1-stable_linux.x86_64}"
OUT="${QA_OUT:-$ROOT/diretor_orientacoes/evidence/qa-cp-d2-001}"
SCENE="${QA_SCENE:-$ROOT/scenes/Take8Validation.tscn}"
PRINT_AT="${QA_PRINT_AT:-2}"
VALIDATION_TAKE="${QA_VALIDATION_TAKE-8}"
VALIDATION_REGION="${QA_VALIDATION_REGION-}"
VALIDATION_ROUTE="${QA_VALIDATION_ROUTE-}"
mkdir -p "$OUT"
rm -f "$OUT"/headless.log "$OUT"/gameplay-30s.mp4 "$OUT"/print-1600x900.jpg "$OUT"/ffmpeg.log

if [[ ! -x "$GODOT" ]]; then
  echo "QA ERROR: Godot binary not found or not executable: $GODOT" >&2
  exit 2
fi

printf '%s\n' '[QA] parser/headless'
"$GODOT" --headless --path "$ROOT" --editor --quit >"$OUT/headless.log" 2>&1
if grep -E 'SCRIPT ERROR|Parse Error|Invalid assignment|ERROR:' "$OUT/headless.log"; then
  echo 'QA FAIL: headless reported parser/runtime errors' >&2
  exit 1
fi

printf '%s\n' '[QA] 30-second gameplay capture for Regions 7–12'
export ROOT GODOT SCENE VALIDATION_TAKE VALIDATION_REGION VALIDATION_ROUTE
xvfb-run -a -s '-screen 0 1600x900x24' bash -lc '
  set -euo pipefail
  ffmpeg -y -f x11grab -video_size 1600x900 -framerate 30 -i "$DISPLAY+0,0" -t 30 -c:v libx264 -preset ultrafast -pix_fmt yuv420p "'$OUT'/gameplay-30s.mp4" >"'$OUT'/ffmpeg.log" 2>&1 &
  CAP=$!
  sleep 2
  set +e
  ORIGEM_VALIDATION_TAKE="$VALIDATION_TAKE" ORIGEM_VALIDATION_REGION="$VALIDATION_REGION" ORIGEM_REGION8_TRAIL="$VALIDATION_ROUTE" timeout 38s "$GODOT" --path "$ROOT" --rendering-method gl_compatibility --rendering-driver opengl3 "$SCENE" >"'$OUT'/gameplay.log" 2>&1
  GAME_STATUS=$?
  set -e
  wait "$CAP"
  if [[ "$GAME_STATUS" -ne 0 && "$GAME_STATUS" -ne 124 && "$GAME_STATUS" -ne 143 ]]; then
    echo "QA FAIL: gameplay process exited with status $GAME_STATUS" >&2
    exit "$GAME_STATUS"
  fi
'

ffmpeg -y -ss "$PRINT_AT" -i "$OUT/gameplay-30s.mp4" -frames:v 1 -q:v 2 "$OUT/print-1600x900.jpg" >/dev/null 2>&1
[[ -s "$OUT/gameplay-30s.mp4" ]] || { echo 'QA FAIL: gameplay file missing' >&2; exit 1; }
[[ -s "$OUT/print-1600x900.jpg" ]] || { echo 'QA FAIL: print file missing' >&2; exit 1; }
if grep -E 'SCRIPT ERROR|Parse Error|Invalid assignment' "$OUT/gameplay.log"; then
  echo 'QA FAIL: gameplay log reported script errors' >&2
  exit 1
fi

printf '%s\n' '[QA] PASS: headless clean, gameplay 30s present, print 1600x900 present'
