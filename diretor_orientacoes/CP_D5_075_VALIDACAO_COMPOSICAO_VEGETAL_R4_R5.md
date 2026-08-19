# CP-D5-075 — Validação de composição vegetal intermediária R4/R5

## Resultado

O preview `MediumVegetationCompositionPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless e confirmou a composição equilibrada de Floresta Densa R4 e Acampamento Majestic R5.

| Composição | Âncora | X/Z | PBR | Médio | Distante |
|---|---:|---|---:|---:|---:|
| Floresta Densa | 4 | `(-9,116)` | 1 | 3 | 4 |
| Acampamento Majestic | 5 | `(-88,178)` | 1 | 3 | 4 |

A telemetria confirmou `pbr_per_composition=1`, `medium_per_composition=3`, `distant_per_composition=4`, `wall_of_trees=false` e `production_script=false`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-075_MEDIUM_VEGETATION_RUNTIME.log`.
