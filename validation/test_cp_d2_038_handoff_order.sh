#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCENE="$ROOT/levels/Region12TraversalScene.gd"
python3 - "$SCENE" <<'PY'
import re, sys
text = open(sys.argv[1], encoding='utf-8').read()
expected = [('HandoffCubeR11', '171.12'), ('HandoffSoleiraR12', '170.38'), ('HandoffHubR12', '169.40')]
for name, z in expected:
    if name not in text or z not in text:
        raise SystemExit(f'HANDOFF_ORDER_FAIL missing={name}:{z}')
positions = [171.12, 170.38, 169.40]
if not all(a > b for a, b in zip(positions, positions[1:])):
    raise SystemExit('HANDOFF_ORDER_FAIL non_monotonic_z')
print('HANDOFF_ORDER=PASS cube_z=171.12 threshold_z=170.38 hub_z=169.40')
PY
