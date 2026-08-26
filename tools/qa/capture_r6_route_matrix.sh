#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="${1:?uso: capture_r6_route_matrix.sh <directorio_evidencia>}"
CAPTURE="$ROOT/tools/qa/capture_r6_arrival_runtime.sh"
ROUTES=(forest_to_ruins majestic_to_lake ruins_arrival)

mkdir -p "$OUT"
for index in "${!ROUTES[@]}"; do
  route="${ROUTES[$index]}"
  display_num=":$((125 + index))"
  ORIGEM_QA_DISPLAY="$display_num" "$CAPTURE" "$OUT/$route" "$route"
  test -s "$OUT/$route/${route}_postload.png"
  grep -q '\[ORIGEM_R6_RUNTIME_COMPOSITION\]' "$OUT/$route/composition.log"
done

{
  printf 'routes='
  printf '%s ' "${ROUTES[@]}"
  printf '\n'
  for route in "${ROUTES[@]}"; do
    printf '%s: ' "$route"
    grep '\[ORIGEM_R6_RUNTIME_COMPOSITION\]' "$OUT/$route/composition.log"
  done
} | tee "$OUT/summary.txt"
