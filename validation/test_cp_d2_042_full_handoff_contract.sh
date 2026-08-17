#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$ROOT/validation/test_cp_d2_037_handoff_contract.sh"
"$ROOT/validation/test_cp_d2_038_handoff_order.sh"
printf 'FULL_HANDOFF_CONTRACT=PASS\n'
