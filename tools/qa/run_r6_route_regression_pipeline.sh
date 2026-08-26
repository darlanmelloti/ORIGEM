#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="${1:?uso: run_r6_route_regression_pipeline.sh <diretorio_evidencia> [baseline.tsv] [tolerancia_m]}"
BASELINE="${2:-$ROOT/qa/r6/route_telemetry_baseline.tsv}"
TOLERANCE="${3:-0.050}"
CAPTURE_MATRIX="$ROOT/tools/qa/capture_r6_route_matrix.sh"
EXTRACT="$ROOT/tools/qa/extract_r6_route_telemetry.sh"
VERIFY="$ROOT/tools/qa/verify_r6_route_telemetry_baseline.sh"
PIPELINE_LOG="$OUT/route_regression_pipeline.log"

for tool in "$CAPTURE_MATRIX" "$EXTRACT" "$VERIFY"; do
  if [ ! -x "$tool" ]; then
    printf '[ORIGEM_R6_ROUTE_REGRESSION_ERROR] ferramenta não executável=%s\n' "$tool" >&2
    exit 1
  fi
done

if [ ! -s "$BASELINE" ]; then
  printf '[ORIGEM_R6_ROUTE_REGRESSION_ERROR] baseline ausente=%s\n' "$BASELINE" >&2
  exit 1
fi

mkdir -p "$OUT"
printf '[ORIGEM_R6_ROUTE_REGRESSION] inicio baseline=%s tolerance=%s\n' "$BASELINE" "$TOLERANCE" | tee "$PIPELINE_LOG"

run_phase() {
  local phase="$1"
  shift
  printf '[ORIGEM_R6_ROUTE_REGRESSION] fase=%s inicio\n' "$phase" | tee -a "$PIPELINE_LOG"
  "$@" 2>&1 | tee -a "$PIPELINE_LOG"
  printf '[ORIGEM_R6_ROUTE_REGRESSION] fase=%s PASS\n' "$phase" | tee -a "$PIPELINE_LOG"
}

run_phase capture_matrix "$CAPTURE_MATRIX" "$OUT"
run_phase extract_telemetry "$EXTRACT" "$OUT"
run_phase verify_baseline "$VERIFY" "$BASELINE" "$OUT/route_telemetry.tsv" "$TOLERANCE"

printf '[ORIGEM_R6_ROUTE_REGRESSION] PASS routes=forest_to_ruins,majestic_to_lake,ruins_arrival\n' | tee -a "$PIPELINE_LOG"
