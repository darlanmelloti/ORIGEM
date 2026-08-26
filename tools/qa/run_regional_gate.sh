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

if [[ "$REGION" == "R4" ]]; then
  printf '[GATE:%s] prova de mundo DEV4-R4-CLEARING-SIGHTLINE-001\n' "$REGION"
  R4_CLEARING_LOG="/tmp/origem_${REGION}_clearing_$$.log"
  set +e
  ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_R4_CLEARING=1 GODOT_SILENCE_ROOT_WARNING=1 timeout 30s "$GODOT" --headless --path . --rendering-driver opengl3 >"$R4_CLEARING_LOG" 2>&1
  r4_clearing_status=$?
  set -e
  if [[ "$r4_clearing_status" -ne 0 ]]; then
    cat "$R4_CLEARING_LOG"
    exit 14
  fi
  if ! grep -q '\[ORIGEM_R4_CLEARING_OK\]' "$R4_CLEARING_LOG"; then
    cat "$R4_CLEARING_LOG"
    exit 14
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R4_CLEARING_ERROR' "$R4_CLEARING_LOG"; then
    cat "$R4_CLEARING_LOG"
    exit 14
  fi
  printf '[GATE:%s] clareira R4 e orçamento de baliza aprovados\n' "$REGION"

  printf '[GATE:%s] prova DEV4-R4-ORION-CLEARING-LORE-003\n' "$REGION"
  R4_LORE_LOG="/tmp/origem_${REGION}_lore_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r4_clearing_lore.gd >"$R4_LORE_LOG" 2>&1
  r4_lore_status=$?
  set -e
  if [[ "$r4_lore_status" -ne 0 ]]; then
    cat "$R4_LORE_LOG"
    exit 18
  fi
  if ! grep -q '\[ORIGEM_R4_LORE_OK\]' "$R4_LORE_LOG"; then
    cat "$R4_LORE_LOG"
    exit 18
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R4_LORE_ERROR' "$R4_LORE_LOG"; then
    cat "$R4_LORE_LOG"
    exit 18
  fi
  printf '[GATE:%s] leitura arqueológica R4 e clareira aberta aprovadas\n' "$REGION"

  printf '[GATE:%s] prova DEV4-R4-CANOPY-CADENCE-004\n' "$REGION"
  R4_CANOPY_LOG="/tmp/origem_${REGION}_canopy_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r4_canopy_cadence.gd >"$R4_CANOPY_LOG" 2>&1
  r4_canopy_status=$?
  set -e
  if [[ "$r4_canopy_status" -ne 0 ]]; then
    cat "$R4_CANOPY_LOG"
    exit 20
  fi
  if ! grep -q '\[ORIGEM_R4_CANOPY_OK\]' "$R4_CANOPY_LOG"; then
    cat "$R4_CANOPY_LOG"
    exit 20
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R4_CANOPY_ERROR' "$R4_CANOPY_LOG"; then
    cat "$R4_CANOPY_LOG"
    exit 20
  fi
  printf '[GATE:%s] cadência de copas R4 aprovada\n' "$REGION"

  declare -a r4_cumulative_proofs=(
    'verify_r4_understory_edge.gd|[ORIGEM_R4_UNDERSTORY_OK]|sub-bosque lateral'
    'verify_r4_orion_vista_framing.gd|[ORIGEM_R4_VISTA_OK]|enquadramento da vista Orion'
    'verify_r4_forest_approach_rhythm.gd|[ORIGEM_R4_APPROACH_OK]|cadência da aproximação florestal'
    'verify_r4_majestic_edge_balance.gd|[ORIGEM_R4_EDGE_OK]|equilíbrio da margem Majestic'
    'verify_r4_silhouette_continuity.gd|[ORIGEM_R4_SILHOUETTE_OK]|continuidade da silhueta'
    'verify_r4_forest_depth_balance.gd|[ORIGEM_R4_DEPTH_OK]|equilíbrio de profundidade lateral'
    'verify_r4_approach_readability.gd|[ORIGEM_R4_READABILITY_OK]|legibilidade da aproximação Orion'
    'verify_r4_trail_pacing.gd|[ORIGEM_R4_PACING_OK]|ritmo visual do trilho'
    'verify_r4_margin_continuity.gd|[ORIGEM_R4_MARGIN_OK]|continuidade da margem ambiental'
    'verify_r4_approach_composition.gd|[ORIGEM_R4_COMPOSITION_OK]|composição da aproximação'
    'verify_r4_edge_rhythm.gd|[ORIGEM_R4_EDGE_RHYTHM_OK]|cadência da borda florestal'
  )
  for proof in "${r4_cumulative_proofs[@]}"; do
    IFS='|' read -r r4_qa_file r4_marker r4_label <<< "$proof"
    printf '[GATE:%s] prova R4 %s\n' "$REGION" "$r4_label"
    R4_CUMULATIVE_LOG="/tmp/origem_${REGION}_$(basename "$r4_qa_file" .gd)_$$.log"
    set +e
    GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script "res://qa/regions/$r4_qa_file" >"$R4_CUMULATIVE_LOG" 2>&1
    r4_cumulative_status=$?
    set -e
    if [[ "$r4_cumulative_status" -ne 0 ]]; then
      cat "$R4_CUMULATIVE_LOG"
      exit 21
    fi
    if ! grep -Fq "$r4_marker" "$R4_CUMULATIVE_LOG"; then
      cat "$R4_CUMULATIVE_LOG"
      exit 21
    fi
    if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R4_[A-Z_]+_ERROR' "$R4_CUMULATIVE_LOG"; then
      cat "$R4_CUMULATIVE_LOG"
      exit 21
    fi
  done
  printf '[GATE:%s] sequência cumulativa R4 aprovada\n' "$REGION"
fi

if [[ "$REGION" == "R5" ]]; then
  printf '[GATE:%s] prova de mundo DEV5-R5-ARTEFACT-TRAIL-001\n' "$REGION"
  R5_ARTEFACT_LOG="/tmp/origem_${REGION}_artefact_$$.log"
  set +e
  ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_R5_ARTEFACT=1 GODOT_SILENCE_ROOT_WARNING=1 timeout 30s "$GODOT" --headless --path . --rendering-driver opengl3 >"$R5_ARTEFACT_LOG" 2>&1
  r5_artefact_status=$?
  set -e
  if [[ "$r5_artefact_status" -ne 0 ]]; then
    cat "$R5_ARTEFACT_LOG"
    exit 15
  fi
  if ! grep -q '\[ORIGEM_R5_ARTEFACT_OK\]' "$R5_ARTEFACT_LOG"; then
    cat "$R5_ARTEFACT_LOG"
    exit 15
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R5_ARTEFACT_ERROR' "$R5_ARTEFACT_LOG"; then
    cat "$R5_ARTEFACT_LOG"
    exit 15
  fi
  printf '[GATE:%s] artefacto, pistas e orçamento R5 aprovados\n' "$REGION"

  printf '[GATE:%s] prova DEV5-R5-CAMP-WIND-READING-002\n' "$REGION"
  R5_WIND_LOG="/tmp/origem_${REGION}_wind_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r5_camp_wind_reading.gd >"$R5_WIND_LOG" 2>&1
  r5_wind_status=$?
  set -e
  if [[ "$r5_wind_status" -ne 0 ]]; then
    cat "$R5_WIND_LOG"
    exit 19
  fi
  if ! grep -q '\[ORIGEM_R5_WIND_OK\]' "$R5_WIND_LOG"; then
    cat "$R5_WIND_LOG"
    exit 19
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R5_WIND_ERROR' "$R5_WIND_LOG"; then
    cat "$R5_WIND_LOG"
    exit 19
  fi
  printf '[GATE:%s] leitura de vento R5 aprovada\n' "$REGION"
fi

if [[ "$REGION" == "R6" ]]; then
  printf '[GATE:%s] auditoria de quatro luzes das Ruínas Submersas\n' "$REGION"
  R6_LIGHT_LOG="/tmp/origem_${REGION}_light_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 30s "$GODOT" --headless --path . --script res://qa/regions/inspect_r6_light_budget.gd >"$R6_LIGHT_LOG" 2>&1
  r6_light_status=$?
  set -e
  if [[ "$r6_light_status" -ne 0 ]]; then
    cat "$R6_LIGHT_LOG"
    exit 16
  fi
  if ! grep -q '\[ORIGEM_R6_LIGHT_AUDIT\] world=2 lake_omni=2 lake_spot=0 r6_total=4' "$R6_LIGHT_LOG"; then
    cat "$R6_LIGHT_LOG"
    exit 16
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_LIGHT_AUDIT_ERROR' "$R6_LIGHT_LOG"; then
    cat "$R6_LIGHT_LOG"
    exit 16
  fi
  printf '[GATE:%s] orçamento R6 de quatro luzes aprovado\n' "$REGION"

  printf '[GATE:%s] prova DEV6-R6-WATERLINE-READING-003\n' "$REGION"
  R6_WATERLINE_LOG="/tmp/origem_${REGION}_waterline_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_waterline_reading.gd >"$R6_WATERLINE_LOG" 2>&1
  r6_waterline_status=$?
  set -e
  if [[ "$r6_waterline_status" -ne 0 ]]; then
    cat "$R6_WATERLINE_LOG"
    exit 18
  fi
  if ! grep -q '\[ORIGEM_R6_WATERLINE_OK\]' "$R6_WATERLINE_LOG"; then
    cat "$R6_WATERLINE_LOG"
    exit 18
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_WATERLINE_ERROR' "$R6_WATERLINE_LOG"; then
    cat "$R6_WATERLINE_LOG"
    exit 18
  fi
  printf '[GATE:%s] leitura arqueológica da linha de água aprovada\n' "$REGION"

  printf '[GATE:%s] prova DEV6-R6-BASIN-ARRIVAL-READING-004\n' "$REGION"
  R6_ARRIVAL_LOG="/tmp/origem_${REGION}_arrival_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_basin_arrival_reading.gd >"$R6_ARRIVAL_LOG" 2>&1
  r6_arrival_status=$?
  set -e
  if [[ "$r6_arrival_status" -ne 0 ]]; then
    cat "$R6_ARRIVAL_LOG"
    exit 19
  fi
  if ! grep -q '\[ORIGEM_R6_ARRIVAL_OK\]' "$R6_ARRIVAL_LOG"; then
    cat "$R6_ARRIVAL_LOG"
    exit 19
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_ARRIVAL_ERROR' "$R6_ARRIVAL_LOG"; then
    cat "$R6_ARRIVAL_LOG"
    exit 19
  fi
  printf '[GATE:%s] leitura da chegada à bacia aprovada\n' "$REGION"

  printf '[GATE:%s] prova DEV6-R6-BASIN-VISTA-READING-005\n' "$REGION"
  R6_VISTA_LOG="/tmp/origem_${REGION}_vista_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_basin_vista_reading.gd >"$R6_VISTA_LOG" 2>&1
  r6_vista_status=$?
  set -e
  if [[ "$r6_vista_status" -ne 0 ]]; then
    cat "$R6_VISTA_LOG"
    exit 20
  fi
  if ! grep -q '\[ORIGEM_R6_BASIN_VISTA_OK\]' "$R6_VISTA_LOG"; then
    cat "$R6_VISTA_LOG"
    exit 20
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_BASIN_VISTA_ERROR' "$R6_VISTA_LOG"; then
    cat "$R6_VISTA_LOG"
    exit 20
  fi
  printf '[GATE:%s] vista estática da bacia aprovada\n' "$REGION"

  printf '[GATE:%s] prova DEV6-R6-OUTER-WATERLINE-SILHOUETTE-006\n' "$REGION"
  R6_OUTER_WATERLINE_LOG="/tmp/origem_${REGION}_outer_waterline_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_outer_waterline_silhouette.gd >"$R6_OUTER_WATERLINE_LOG" 2>&1
  r6_outer_waterline_status=$?
  set -e
  if [[ "$r6_outer_waterline_status" -ne 0 ]]; then
    cat "$R6_OUTER_WATERLINE_LOG"
    exit 22
  fi
  if ! grep -q '\[ORIGEM_R6_OUTER_WATERLINE_OK\]' "$R6_OUTER_WATERLINE_LOG"; then
    cat "$R6_OUTER_WATERLINE_LOG"
    exit 22
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_OUTER_WATERLINE_ERROR' "$R6_OUTER_WATERLINE_LOG"; then
    cat "$R6_OUTER_WATERLINE_LOG"
    exit 22
  fi
  printf '[GATE:%s] silhueta exterior da linha de água aprovada\n' "$REGION"

  printf '[GATE:%s] prova DEV6-R6-EASTERN-MARGIN-READING-007\n' "$REGION"
  R6_EASTERN_MARGIN_LOG="/tmp/origem_${REGION}_eastern_margin_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_reading.gd >"$R6_EASTERN_MARGIN_LOG" 2>&1
  r6_eastern_margin_status=$?
  set -e
  if [[ "$r6_eastern_margin_status" -ne 0 ]]; then
    cat "$R6_EASTERN_MARGIN_LOG"
    exit 23
  fi
  if ! grep -q '\[ORIGEM_R6_EASTERN_MARGIN_OK\]' "$R6_EASTERN_MARGIN_LOG"; then
    cat "$R6_EASTERN_MARGIN_LOG"
    exit 23
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_EASTERN_MARGIN_ERROR' "$R6_EASTERN_MARGIN_LOG"; then
    cat "$R6_EASTERN_MARGIN_LOG"
    exit 23
  fi
  printf '[GATE:%s] leitura estática da margem oriental aprovada\n' "$REGION"

  printf '[GATE:%s] prova DEV6-R6-EASTERN-MARGIN-DEPTH-008\n' "$REGION"
  R6_EASTERN_DEPTH_LOG="/tmp/origem_${REGION}_eastern_depth_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_depth.gd >"$R6_EASTERN_DEPTH_LOG" 2>&1
  r6_eastern_depth_status=$?
  set -e
  if [[ "$r6_eastern_depth_status" -ne 0 ]]; then
    cat "$R6_EASTERN_DEPTH_LOG"
    exit 24
  fi
  if ! grep -q '\[ORIGEM_R6_EASTERN_DEPTH_OK\]' "$R6_EASTERN_DEPTH_LOG"; then
    cat "$R6_EASTERN_DEPTH_LOG"
    exit 24
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_EASTERN_DEPTH_ERROR' "$R6_EASTERN_DEPTH_LOG"; then
    cat "$R6_EASTERN_DEPTH_LOG"
    exit 24
  fi
  printf '[GATE:%s] profundidade estática da margem oriental aprovada\n' "$REGION"
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_lateral_balance.gd >/tmp/origem_${REGION}_eastern_lateral_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_LATERAL_OK\]' /tmp/origem_${REGION}_eastern_lateral_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_vista.gd >/tmp/origem_${REGION}_eastern_vista_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_VISTA_OK\]' /tmp/origem_${REGION}_eastern_vista_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_rhythm_final.gd >/tmp/origem_${REGION}_eastern_rhythm_final_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_RHYTHM_FINAL_OK\]' /tmp/origem_${REGION}_eastern_rhythm_final_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_closure.gd >/tmp/origem_${REGION}_eastern_closure_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_CLOSURE_OK\]' /tmp/origem_${REGION}_eastern_closure_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_readability_final.gd >/tmp/origem_${REGION}_eastern_readability_final_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_READABILITY_FINAL_OK\]' /tmp/origem_${REGION}_eastern_readability_final_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_observation.gd >/tmp/origem_${REGION}_eastern_observation_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_OBSERVATION_OK\]' /tmp/origem_${REGION}_eastern_observation_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_review.gd >/tmp/origem_${REGION}_eastern_review_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_REVIEW_OK\]' /tmp/origem_${REGION}_eastern_review_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_consolidation.gd >/tmp/origem_${REGION}_eastern_consolidation_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_CONSOLIDATION_OK\]' /tmp/origem_${REGION}_eastern_consolidation_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_stabilization.gd >/tmp/origem_${REGION}_eastern_stabilization_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_STABILIZATION_OK\]' /tmp/origem_${REGION}_eastern_stabilization_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_reconciliation.gd >/tmp/origem_${REGION}_eastern_reconciliation_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_RECONCILIATION_OK\]' /tmp/origem_${REGION}_eastern_reconciliation_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_consistency.gd >/tmp/origem_${REGION}_eastern_consistency_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_CONSISTENCY_OK\]' /tmp/origem_${REGION}_eastern_consistency_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_check.gd >/tmp/origem_${REGION}_eastern_check_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_CHECK_OK\]' /tmp/origem_${REGION}_eastern_check_$$.log
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_eastern_margin_finalization.gd >/tmp/origem_${REGION}_eastern_finalization_$$.log 2>&1
  grep -q '\[ORIGEM_R6_EASTERN_FINALIZATION_OK\]' /tmp/origem_${REGION}_eastern_finalization_$$.log

  printf '[GATE:%s] prova DEV6-R6-SHORE-HANDOFF-002\n' "$REGION"
  R6_HANDOFF_LOG="/tmp/origem_${REGION}_handoff_$$.log"
  set +e
  GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path . --script res://qa/regions/verify_r6_shore_handoff.gd >"$R6_HANDOFF_LOG" 2>&1
  r6_handoff_status=$?
  set -e
  if [[ "$r6_handoff_status" -ne 0 ]]; then
    cat "$R6_HANDOFF_LOG"
    exit 17
  fi
  if ! grep -q '\[ORIGEM_R6_HANDOFF_OK\]' "$R6_HANDOFF_LOG"; then
    cat "$R6_HANDOFF_LOG"
    exit 17
  fi
  if grep -Eqi 'parse error|parser error|script error|shader error|fatal error|ORIGEM_R6_HANDOFF_ERROR' "$R6_HANDOFF_LOG"; then
    cat "$R6_HANDOFF_LOG"
    exit 17
  fi
  printf '[GATE:%s] handoff físico R6→R7 aprovado\n' "$REGION"
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
