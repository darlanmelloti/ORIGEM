#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
EVIDENCE_ROOT="${1:?uso: run_r6_route_regression_pipeline.sh <diretorio_de_evidencia> [baseline.tsv] [tolerancia_m>}"
BASELINE="${2:-$ROOT/qa/r6/route_telemetry_baseline.tsv}"
TOLERANCE="${3:-0.050}"
CAPTURE="$ROOT/tools/qa/capture_r6_route_matrix.sh"
EXTRACT="$ROOT/tools/qa/extract_r6_route_telemetry.sh"
VERIFY="$ROOT/tools/qa/verify_r6_route_telemetry_baseline.sh"

for tool in "$CAPTURE" "$EXTRACT" "$VERIFY"; do
  if [ ! -x "$tool" ]; then
    echo "Ferramenta QA ausente ou não executável: $tool" >&2
    exit 1
  fi
done

if [ ! -s "$BASELINE" ]; then
  echo "Baseline R6 ausente: $BASELINE" >&2
  exit 1
fi

if ! awk -v value="$TOLERANCE" 'BEGIN { exit !(value ~ /^[0-9]+([.][0-9]+)?$/ && value >= 0) }'; then
  echo "Tolerância inválida: $TOLERANCE" >&2
  exit 1
fi

mkdir -p "$EVIDENCE_ROOT"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
RUN_DIR="$EVIDENCE_ROOT/r6-route-regression-$STAMP"
mkdir -p "$RUN_DIR"
LOG="$RUN_DIR/pipeline.log"

run_stage() {
  local label="$1"
  shift
  printf '[ORIGEM_R6_ROUTE_REGRESSION] stage=%s status=START\n' "$label" | tee -a "$LOG"
  "$@" 2>&1 | tee -a "$LOG"
  printf '[ORIGEM_R6_ROUTE_REGRESSION] stage=%s status=PASS\n' "$label" | tee -a "$LOG"
}

printf '[ORIGEM_R6_ROUTE_REGRESSION] run_dir=%s baseline=%s tolerance=%s\n' "$RUN_DIR" "$BASELINE" "$TOLERANCE" | tee "$LOG"
run_stage capture_matrix "$CAPTURE" "$RUN_DIR"
run_stage extract_telemetry "$EXTRACT" "$RUN_DIR"
run_stage verify_baseline "$VERIFY" "$BASELINE" "$RUN_DIR/route_telemetry.tsv" "$TOLERANCE"

test -s "$RUN_DIR/route_telemetry.tsv"
test -s "$RUN_DIR/route_telemetry.md"
for route in forest_to_ruins majestic_to_lake ruins_arrival; do
  test -s "$RUN_DIR/$route/runtime.log"
  test -s "$RUN_DIR/$route/${route}_postload.png"
done

printf '[ORIGEM_R6_ROUTE_REGRESSION_PIPELINE_OK] run_dir=%s routes=3 tolerance=%s\n' "$RUN_DIR" "$TOLERANCE" | tee -a "$LOG"
