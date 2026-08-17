#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for REQUIRED in \
  "$ROOT/levels/HighlandRegion.gd" \
  "$ROOT/levels/OrionDestinationRegion.gd" \
  "$ROOT/levels/Region12TraversalScene.gd" \
  "$ROOT/levels/CartographicAnchors.gd"; do
  test -f "$REQUIRED"
done
grep -q 'REGIONS_7_12_ONLY' "$ROOT/levels/HighlandRegion.gd" "$ROOT/levels/OrionDestinationRegion.gd" "$ROOT/levels/Region12TraversalScene.gd" "$ROOT/levels/CartographicAnchors.gd"
if git -C "$ROOT" diff --name-only HEAD -- | grep -Eq '(^|/)(CasaVoss|DaylightValley|ForestLakeRegion|ForestSector3D|ExplorableMountains)\.gd$'; then
  echo 'SCOPE_GUARD=FAIL'
  exit 1
fi
printf 'SCOPE_GUARD=PASS regions=7-12 map_authority=mapaorigem.webp\n'
