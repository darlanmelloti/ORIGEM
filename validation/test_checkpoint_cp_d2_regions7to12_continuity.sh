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
if [[ "${QA_PARITY_CONTRACT:-0}" == "1" ]]; then
  PARITY_SCRIPT="$ROOT/validation/test_cp_d2_241_qa_parity.sh"
  [[ -x "$PARITY_SCRIPT" ]] || { echo 'QA FAIL: CP-D2-241 parity contract missing or not executable' >&2; exit 1; }
  printf '%s\n' 'QA_PARITY_CONTRACT=CP-D2-241_PRESENT'
fi
if [[ "${QA_FINAL_PACKAGE_CHECK:-0}" == "1" ]]; then
  QA_SOURCE="$ROOT/levels/CartographicMirrorQA.gd"
  QA_MAIN="$ROOT/scripts/main.gd"
  QA_SCENE_FILE="$ROOT/scenes/main.tscn"
  test -f "$QA_SOURCE" || { echo 'QA FAIL: QA source missing' >&2; exit 1; }
  test -f "$QA_MAIN" || { echo 'QA FAIL: main script missing' >&2; exit 1; }
  test -f "$QA_SCENE_FILE" || { echo 'QA FAIL: main scene missing' >&2; exit 1; }
  grep -q 'MAP_MIRROR_VALIDATION' "$QA_SOURCE" || { echo 'QA FAIL: QA activation gate missing' >&2; exit 1; }
  grep -q 'queue_free()' "$QA_SOURCE" || { echo 'QA FAIL: QA shutdown gate missing' >&2; exit 1; }
  ! grep -q 'CartographicMirrorQA' "$QA_SCENE_FILE" || { echo 'QA FAIL: persistent QA overlay reference in main scene' >&2; exit 1; }
  grep -q '_init_cartographic_mirror_qa' "$QA_MAIN" || { echo 'QA FAIL: runtime QA initializer missing' >&2; exit 1; }
  grep -q 'load("res://levels/CartographicMirrorQA.gd")' "$QA_MAIN" || { echo 'QA FAIL: dynamic QA script load missing' >&2; exit 1; }
  printf '%s\n' 'QA_FINAL_PACKAGE_CHECK=PASS runtime-gated-dynamic-overlay'
fi
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
if [[ "${MAP_MIRROR_VALIDATION:-0}" == "1" ]]; then
  grep -q 'MAP_MIRROR_ANCHOR_CONTRACT chain=R9->R10->R11->R12 count=3 state=RUNTIME_QA_ONLY' "$OUT/gameplay.log" || { echo 'QA FAIL: runtime cartographic anchor contract missing' >&2; exit 1; }
  for handoff_id in R07_R08 R08_R09 R09_R10 R10_R11 R11_R12; do
    grep -q "MAP_MIRROR_HANDOFF_CONTRACT id=${handoff_id} authority=mapaorigem.webp" "$OUT/gameplay.log" || { echo "QA FAIL: handoff contract missing: ${handoff_id}" >&2; exit 1; }
  done
fi

printf '%s\n' '[QA] PASS: headless clean, gameplay 30s present, print 1600x900 present'
