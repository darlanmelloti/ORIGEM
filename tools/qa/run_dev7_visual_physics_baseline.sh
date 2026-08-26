#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT="${GODOT_BIN:-}"
if [ -z "$GODOT" ]; then
  GODOT="$(command -v Godot_v4.7.1-stable_linux.x86_64 || command -v godot || true)"
fi
if [ -z "$GODOT" ] && [ -x /home/ubuntu/tools/godot-4.7.1/Godot_v4.7.1-stable_linux.x86_64 ]; then
  GODOT=/home/ubuntu/tools/godot-4.7.1/Godot_v4.7.1-stable_linux.x86_64
fi
if [ -z "$GODOT" ] || [ ! -x "$GODOT" ]; then
  echo 'Godot 4.7.1 não encontrado; defina GODOT_BIN.' >&2
  exit 2
fi

OUT="${1:-$ROOT/reports/dev7/visual_playable_physics_baseline_001}"
mkdir -p "$OUT"
ROUTES=(road_to_arch arch_to_forest forest_to_majestic forest_to_ruins majestic_to_lake ruins_arrival)

printf '# Baseline Dev7 — Visual e Física Jogável\n\n' > "$OUT/summary.md"
printf '| Rota | Captura runtime | Spawn confirmado | Estado |\n|---|---:|---:|---|\n' >> "$OUT/summary.md"

for route in "${ROUTES[@]}"; do
  route_dir="$OUT/$route"
  rm -rf "$route_dir"
  set +e
  ORIGEM_QA_CAPTURE_SETTLE_SECONDS=12 "$ROOT/tools/qa/capture_regional_runtime.sh" "$route_dir" "$route" > "$route_dir.capture.log" 2>&1
  status=$?
  set -e
  screenshot="$route_dir/${route}_postload.png"
  spawn=0
  [ -f "$route_dir/runtime.log" ] && grep -Fq '[ORIGEM_QA_ROUTE] Spawn ' "$route_dir/runtime.log" && spawn=1
  if [ "$status" -eq 0 ] && [ -f "$screenshot" ] && [ "$spawn" -eq 1 ]; then
    printf '| `%s` | sim | sim | PASS |\n' "$route" >> "$OUT/summary.md"
  else
    printf '| `%s` | %s | %s | FAIL |\n' "$route" "$([ -f "$screenshot" ] && echo sim || echo não)" "$([ "$spawn" -eq 1 ] && echo sim || echo não)" >> "$OUT/summary.md"
    cat "$route_dir.capture.log" >&2
    exit 1
  fi
done

GROUNDING_LOG="$OUT/player_grounding.log"
ORIGEM_QA_AUTOSTART_NEW_GAME=1 ORIGEM_QA_GROUNDING=1 ORIGEM_QA_ROUTE=road_to_arch GODOT_SILENCE_ROOT_WARNING=1 timeout 35s "$GODOT" --headless --path "$ROOT" --rendering-driver opengl3 > "$GROUNDING_LOG" 2>&1
if ! grep -q '\[QA-GROUND-01-RESULT\].*"passed":true' "$GROUNDING_LOG"; then
  cat "$GROUNDING_LOG" >&2
  exit 1
fi
if grep -Eqi 'parse error|script error|fatal error|failed loading resource' "$GROUNDING_LOG"; then
  cat "$GROUNDING_LOG" >&2
  exit 1
fi
printf '\n## Física\n\nA prova de grounding do jogador foi executada pela cena de jogo, sem alterar Player, câmara, colisores ou cenas de produção. Consulte `player_grounding.log`.\n' >> "$OUT/summary.md"
printf '[ORIGEM_DEV7_VISUAL_PHYSICS_BASELINE_OK] routes=%s evidence=%s\n' "${#ROUTES[@]}" "$OUT" | tee "$OUT/baseline.log"
