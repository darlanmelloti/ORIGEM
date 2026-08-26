#!/usr/bin/env bash
set -euo pipefail

OUT="${1:?uso: extract_r6_route_telemetry.sh <directorio_da_matriz>}"
ROUTES=(forest_to_ruins majestic_to_lake ruins_arrival)
TSV="$OUT/route_telemetry.tsv"
MARKDOWN="$OUT/route_telemetry.md"

printf 'route\tspawn_x\tspawn_y\tspawn_z\ttarget_x\ttarget_y\ttarget_z\tdelta_x\tdelta_z\thorizontal_distance\n' >"$TSV"
for route in "${ROUTES[@]}"; do
  log="$OUT/$route/runtime.log"
  if [ ! -s "$log" ]; then
    echo "Log ausente para a rota $route: $log" >&2
    exit 1
  fi
  line="$(grep -F '[ORIGEM_QA_ROUTE] Spawn ' "$log" | tail -n 1 || true)"
  if [ -z "$line" ]; then
    echo "Telemetria de spawn ausente para a rota $route." >&2
    exit 1
  fi
  pair="$(printf '%s\n' "$line" | sed -E 's/.*ativo em \(([^)]*)\); (alvo|primeira_perna)=\(([^)]*)\).*/\1|\3/')"
  if [[ "$pair" != *'|'* ]]; then
    echo "Telemetria de alvo inválida para a rota $route: $line" >&2
    exit 1
  fi
  spawn="${pair%%|*}"
  target="${pair#*|}"
  awk -F',' -v route="$route" -v spawn="$spawn" -v target="$target" '
    BEGIN {
      split(spawn, s, ","); split(target, t, ",");
      sx=s[1]+0; sy=s[2]+0; sz=s[3]+0;
      tx=t[1]+0; ty=t[2]+0; tz=t[3]+0;
      dx=tx-sx; dz=tz-sz; distance=sqrt(dx*dx + dz*dz);
      if (distance <= 0.01) exit 2;
      printf "%s\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\n", route, sx, sy, sz, tx, ty, tz, dx, dz, distance;
    }
  ' >>"$TSV" || {
    echo "Vetor horizontal inválido para a rota $route." >&2
    exit 1
  }
done
{
  printf '# Telemetria de Vetores R6\n\n'
  printf '| Rota | Spawn `(x, y, z)` | Alvo `(x, y, z)` | Δx | Δz | Distância horizontal |\n'
  printf '|---|---:|---:|---:|---:|---:|\n'
  tail -n +2 "$TSV" | while IFS=$'\t' read -r route sx sy sz tx ty tz dx dz distance; do
    printf '| `%s` | `(%.3f, %.3f, %.3f)` | `(%.3f, %.3f, %.3f)` | %.3f | %.3f | %.3f m |\n' "$route" "$sx" "$sy" "$sz" "$tx" "$ty" "$tz" "$dx" "$dz" "$distance"
  done
} >"$MARKDOWN"
cat "$MARKDOWN"
