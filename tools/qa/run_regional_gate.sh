#!/usr/bin/env bash
# ORIGEM — Porta de qualidade para entregas regionais.
# Uso: tools/qa/run_regional_gate.sh R3 [base-ref]
# Requer: Git e Godot 4.x. Pode definir GODOT_BIN com o caminho do executável.

set -euo pipefail

REGION="${1:-}"
BASE_REF="${2:-origin/integration/r1-r6-sprint1}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"

if [[ ! "$REGION" =~ ^R[2-6]$ ]]; then
  echo "Uso: $0 R2|R3|R4|R5|R6 [base-ref]" >&2
  exit 2
fi

case "$REGION" in
  R2) ROUTES=(road_to_arch positive_bridge road_return_voss); MODULE='levels/regions/R2_RiverRoad.gd' ;;
  R3) ROUTES=(road_to_arch arch_to_forest); MODULE='levels/regions/R3_ArchRuins.gd' ;;
  R4) ROUTES=(arch_to_forest forest_to_majestic forest_to_ruins); MODULE='levels/regions/R4_DenseForest.gd' ;;
  R5) ROUTES=(forest_to_majestic majestic_to_lake); MODULE='levels/regions/R5_MajesticCamp.gd' ;;
  R6) ROUTES=(forest_to_ruins majestic_to_lake ruins_arrival); MODULE='levels/regions/R6_SubmergedRuins.gd' ;;
esac

if ! git rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
  echo "[GATE:$REGION] Base não encontrada: $BASE_REF" >&2
  exit 3
fi

if [[ -n "${GODOT_BIN:-}" ]]; then
  GODOT="$GODOT_BIN"
elif command -v godot >/dev/null 2>&1; then
  GODOT="$(command -v godot)"
else
  echo "[GATE:$REGION] GODOT_BIN não definido e 'godot' não está no PATH." >&2
  exit 4
fi

if [[ ! -f "$MODULE" ]]; then
  echo "[GATE:$REGION] Módulo contratual em falta: $MODULE" >&2
  exit 5
fi

printf '[GATE:%s] Base=%s\n' "$REGION" "$BASE_REF"
printf '[GATE:%s] 1/4 diff --check\n' "$REGION"
git diff --check "$BASE_REF"...HEAD

printf '[GATE:%s] 2/4 auditoria de escopo\n' "$REGION"
CHANGED_FILES="$(git diff --name-only "$BASE_REF"...HEAD)"
printf '%s\n' "$CHANGED_FILES" | sed '/^$/d' > /tmp/origem_gate_files_$$.txt
if grep -Eq '^(scripts/main\.gd|entities/player/Player\.gd|levels/CartographicAnchors\.gd|core/timeline/TimelineManager\.gd|ui/menus/CartographicMapUI\.gd)$' /tmp/origem_gate_files_$$.txt; then
  echo "[GATE:$REGION] AVISO: houve alteração transversal; requer revisão explícita de Dev1."
  grep -E '^(scripts/main\.gd|entities/player/Player\.gd|levels/CartographicAnchors\.gd|core/timeline/TimelineManager\.gd|ui/menus/CartographicMapUI\.gd)$' /tmp/origem_gate_files_$$.txt
fi
rm -f /tmp/origem_gate_files_$$.txt

printf '[GATE:%s] 3/4 parser Godot\n' "$REGION"
PARSER_LOG="/tmp/origem_${REGION}_parser_$$.log"
GODOT_SILENCE_ROOT_WARNING=1 "$GODOT" --headless --editor --quit >"$PARSER_LOG" 2>&1
if grep -Eqi 'parse error|parser error|script error|fatal error' "$PARSER_LOG"; then
  cat "$PARSER_LOG"
  exit 6
fi

if [[ "$REGION" == "R2" ]]; then
  printf '[GATE:%s] 4/5 estabilidade física R1→R2\n' "$REGION"
  GROUND_LOG="/tmp/origem_${REGION}_grounding_$$.log"
  set +e
  ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_GROUNDING=1 ORIGEM_QA_ROUTE=road_to_arch GODOT_SILENCE_ROOT_WARNING=1 timeout 24s "$GODOT" --headless --path . --rendering-driver opengl3 >"$GROUND_LOG" 2>&1
  grounding_status=$?
  set -e
  if [[ "$grounding_status" -ne 0 ]]; then
    cat "$GROUND_LOG"
    exit 7
  fi
  if ! grep -q '\[QA-GROUND-01-RESULT\].*"passed":true' "$GROUND_LOG"; then
    cat "$GROUND_LOG"
    exit 7
  fi
  printf '[GATE:%s] estabilidade R1→R2 aprovada\n' "$REGION"

  printf '[GATE:%s] marcos físicos DEV2-R2-WORLD-LIFE-001\n' "$REGION"
  WORLD_LIFE_LOG="/tmp/origem_${REGION}_world_life_$$.log"
  set +e
  ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_ROUTE=road_to_arch ORIGEM_QA_R2_WORLD_LIFE=1 GODOT_SILENCE_ROOT_WARNING=1 timeout 22s "$GODOT" --headless --path . --rendering-driver opengl3 >"$WORLD_LIFE_LOG" 2>&1
  world_life_status=$?
  set -e
  if [[ "$world_life_status" -ne 0 && "$world_life_status" -ne 124 ]]; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_WORLD_LIFE_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_ORION_STATION_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_TRAVELLER_REST_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_RIVER_CAIRN_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_RIVER_RETURN_010_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_RIVER_MARKER_011_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_RIVER_QA_012_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_RIVER_APPROACH_009_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if ! grep -q '\[ORIGEM_R2_RIVER_FOOTBRIDGE_OK\]' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R2_WORLD_LIFE_ERROR' "$WORLD_LIFE_LOG"; then
    cat "$WORLD_LIFE_LOG"
    exit 12
  fi
  printf '[GATE:%s] marcos físicos R2 aprovados\n' "$REGION"
fi

if [[ "$REGION" == "R3" ]]; then
  printf '[GATE:%s] prova de mundo DEV3-R3-ARCH-AWAKENING-RECOVERY-001\n' "$REGION"
  R3_ARCH_LOG="/tmp/origem_${REGION}_arch_$$.log"
  set +e
  ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_R3_ARCH=1 GODOT_SILENCE_ROOT_WARNING=1 timeout 30s "$GODOT" --headless --path . --rendering-driver opengl3 >"$R3_ARCH_LOG" 2>&1
  r3_arch_status=$?
  set -e
  if [[ "$r3_arch_status" -ne 0 ]]; then
    cat "$R3_ARCH_LOG"
    exit 13
  fi
  if ! grep -q '\[ORIGEM_R3_ARCH_OK\]' "$R3_ARCH_LOG"; then
    cat "$R3_ARCH_LOG"
    exit 13
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R3_ARCH_ERROR' "$R3_ARCH_LOG"; then
    cat "$R3_ARCH_LOG"
    exit 13
  fi
  printf '[GATE:%s] Arco R3 aprovado\n' "$REGION"
fi

printf '[GATE:%s] 5/5 contratos e rotas\n' "$REGION"
CONTRACT_LOG="/tmp/origem_${REGION}_contract_$$.log"
GODOT_SILENCE_ROOT_WARNING=1 "$GODOT" --headless --path . --script res://qa/regions/verify_region_contracts.gd >"$CONTRACT_LOG" 2>&1
if ! grep -q '\[ORIGEM_REGION_CONTRACT_OK\]' "$CONTRACT_LOG"; then
  cat "$CONTRACT_LOG"
      exit 8
  fi

for route in "${ROUTES[@]}"; do
  ROUTE_LOG="/tmp/origem_${REGION}_${route}_$$.log"
  set +e
  ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_ROUTE="$route" GODOT_SILENCE_ROOT_WARNING=1 timeout 22s "$GODOT" --headless --path . --rendering-driver opengl3 >"$ROUTE_LOG" 2>&1
  route_status=$?
  set -e
  if [[ "$route_status" -ne 0 && "$route_status" -ne 124 ]]; then
    cat "$ROUTE_LOG"
    exit 9
  fi
  if ! grep -q '\[ORIGEM_QA_ROUTE\]' "$ROUTE_LOG"; then
    cat "$ROUTE_LOG"
    exit 10
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error' "$ROUTE_LOG"; then
    cat "$ROUTE_LOG"
    exit 11
  fi
  printf '[GATE:%s] rota %s aprovada\n' "$REGION" "$route"
done

printf '[GATE:%s] PASS\n' "$REGION"
