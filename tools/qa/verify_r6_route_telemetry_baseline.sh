#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
BASELINE="${1:-$ROOT/qa/r6/route_telemetry_baseline.tsv}"
ACTUAL="${2:?uso: verify_r6_route_telemetry_baseline.sh [baseline.tsv] <telemetria_atual.tsv> [tolerancia_m>}"
TOLERANCE="${3:-0.050}"

if [ ! -s "$BASELINE" ] || [ ! -s "$ACTUAL" ]; then
  echo 'Baseline ou telemetria atual ausente.' >&2
  exit 1
fi
awk -F'\t' -v tolerance="$TOLERANCE" '
  NR == FNR {
    if (FNR == 1) next
    expected[$1] = $0
    expected_count++
    next
  }
  FNR == 1 { next }
  {
    route = $1
    if (!(route in expected)) {
      printf "[ORIGEM_R6_TELEMETRY_BASELINE_ERROR] rota inesperada=%s\n", route > "/dev/stderr"
      failed = 1
      next
    }
    split(expected[route], baseline, "\t")
    max_delta = 0
    for (column_index = 2; column_index <= 10; column_index++) {
      delta = $column_index - baseline[column_index]
      if (delta < 0) delta = -delta
      if (delta > max_delta) max_delta = delta
    }
    if (max_delta > tolerance) {
      printf "[ORIGEM_R6_TELEMETRY_BASELINE_ERROR] rota=%s max_delta=%.3f tolerance=%.3f\n", route, max_delta, tolerance > "/dev/stderr"
      failed = 1
    } else {
      printf "[ORIGEM_R6_TELEMETRY_BASELINE] rota=%s max_delta=%.3f tolerance=%.3f PASS\n", route, max_delta, tolerance
    }
    seen[route] = 1
  }
  END {
    for (route in expected) {
      if (!(route in seen)) {
        printf "[ORIGEM_R6_TELEMETRY_BASELINE_ERROR] rota ausente=%s\n", route > "/dev/stderr"
        failed = 1
      }
    }
    if (expected_count != length(seen)) {
      printf "[ORIGEM_R6_TELEMETRY_BASELINE_ERROR] contagem de rotas inválida\n" > "/dev/stderr"
      failed = 1
    }
    exit failed
  }
' "$BASELINE" "$ACTUAL"
