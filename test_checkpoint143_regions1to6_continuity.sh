#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cat /home/ubuntu/origem_v2_root.txt)
GODOT=/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64
REPORT=/home/ubuntu/checkpoint143_regions1to6_continuity.log

rm -f "$REPORT"
{
  echo "[ORIGEM_QA_INTEGRATED] Checkpoint 143 — Regiões 1–6"
  echo "[ORIGEM_QA_INTEGRATED] 1/3: validação headless"
  GODOT_SILENCE_ROOT_WARNING=1 timeout 90 "$GODOT" --headless --path "$ROOT" --editor --quit

  echo "[ORIGEM_QA_INTEGRATED] 2/3: prólogo, porta [E] e exterior — 30 segundos"
  /home/ubuntu/test_checkpoint113_twilight_30s.sh

  echo "[ORIGEM_QA_INTEGRATED] 3/3: Acampamento Majestic até Ruínas Submersas — 30 segundos"
  /home/ubuntu/test_checkpoint126_majestic_to_lake_30s.sh

  for artifact in \
    /home/ubuntu/origem_v2_phase113_twilight_stable_30s.png \
    /home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png; do
    test -s "$artifact"
    echo "[ORIGEM_QA_INTEGRATED] artefacto confirmado: $artifact"
  done

  echo "[ORIGEM_QA_INTEGRATED] aprovado: prólogo e rota Majestic–lago estáveis"
} 2>&1 | tee "$REPORT"
