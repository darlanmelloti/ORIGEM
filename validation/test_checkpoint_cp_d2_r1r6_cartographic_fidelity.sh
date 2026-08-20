#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GODOT_BIN="${GODOT_BIN:-/home/ubuntu/godot-4.7.1/Godot_v4.7.1-stable_linux.x86_64}"
OUT="${QA_OUT:-$ROOT/diretor_orientacoes/evidence/cp-d2-r1r6-001}"
mkdir -p "$OUT"

if [[ ! -x "$GODOT_BIN" ]]; then
  echo "QA FAIL: Godot 4.7.1 binary not found: $GODOT_BIN" >&2
  exit 2
fi

"$GODOT_BIN" --headless --path "$ROOT" --script res://validation/CartographicR1R6FidelityQA.gd --quit-after 2 >"$OUT/headless.log" 2>&1

grep -q 'R1R6_CARTOGRAPHIC_FIDELITY_QA=PASS' "$OUT/headless.log"
grep -q 'MAP_MIRROR_VALIDATION chain=R1->R2->R3->R4->R5->R6' "$OUT/headless.log"
grep -q 'R1R6_SCOPE_GUARD=PASS' "$OUT/headless.log"
grep -q 'R1R6_DYNAMIC_LIGHTS_POLICY=NO_INCREMENTAL_LIGHTS' "$OUT/headless.log"

cat >"$OUT/QA_SUMMARY.txt" <<EOF
CP-D2-R1R6-001=HEADLESS_PASS
MAP_MIRROR_CHAIN=R1->R2->R3->R4->R5->R6
BOUNDARY=R6->R7 QA_BOUNDARY_PENDING
LIGHT_POLICY=NO_INCREMENTAL_LIGHTS
OWNER_GUARD=R1-R6 production modules untouched; Dev1 standby
ENGINE=Godot 4.7.1
EOF

sha256sum "$OUT/headless.log" "$OUT/QA_SUMMARY.txt" >"$OUT/SHA256SUMS.txt"
printf '%s\n' 'CP-D2-R1R6-001=PASS'
