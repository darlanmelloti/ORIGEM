#!/usr/bin/env bash
# QA-BUDGET-01 — importa o projecto antes de executar a sonda runtime de luzes.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT_BIN="${GODOT_BIN:-/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64}"
OUT_DIR="${OUT_DIR:-/home/ubuntu/qa_evidence_dev4_budget}"
IMPORT_LOG="$OUT_DIR/qa_budget_import.log"
RUNTIME_LOG="$OUT_DIR/qa_budget_runtime.log"

mkdir -p "$OUT_DIR"
GODOT_SILENCE_ROOT_WARNING=1 timeout 180 "$GODOT_BIN" --headless --path "$ROOT" --editor --quit >"$IMPORT_LOG" 2>&1
if grep -Eqi 'Parse Error|SCRIPT ERROR|Compile Error' "$IMPORT_LOG"; then
  cat "$IMPORT_LOG"
  exit 1
fi
GODOT_SILENCE_ROOT_WARNING=1 timeout 180 "$GODOT_BIN" --headless --path "$ROOT" res://tools/qa/audit_light_budget_runtime.tscn >"$RUNTIME_LOG" 2>&1
if grep -Eqi 'Parse Error|SCRIPT ERROR|Compile Error|budget_exceeded' "$RUNTIME_LOG"; then
  cat "$RUNTIME_LOG"
  exit 1
fi
grep -E '\[QA-BUDGET-01\]' "$RUNTIME_LOG"
