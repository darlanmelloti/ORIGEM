#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCENE="$ROOT/levels/Region12TraversalScene.gd"
ORION="$ROOT/levels/OrionDestinationRegion.gd"
for token in \
  'HandoffCubeR11' \
  'HandoffSoleiraR12' \
  'HandoffHubR12' \
  'CollidersAproximacaoHubR12' \
  'MarcadorRotaFisicaR12_' \
  'ColisaoSoleiraGatewayCupula' \
  'ColisaoDegrauCupulaFinal_' \
  'collision_layer = 1' \
  'collision_mask = 1'; do
  if ! grep -Fq "$token" "$SCENE" "$ORION"; then
    printf 'HANDOFF_CONTRACT_FAIL missing=%s\n' "$token" >&2
    exit 1
  fi
done
if grep -nE 'Region(0?[1-6])|Take ?([1-9]|10|11)' "$SCENE" "$ORION" | grep -vE 'Region(9|10|11|12)|Take ?(10|11|12|22)' >/tmp/cp-d2-037-scope-leaks.log; then
  cat /tmp/cp-d2-037-scope-leaks.log >&2
  exit 1
fi
printf 'HANDOFF_CONTRACT=PASS\n'
