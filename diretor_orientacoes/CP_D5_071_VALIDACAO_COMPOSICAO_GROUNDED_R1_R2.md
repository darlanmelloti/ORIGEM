# CP-D5-071 — Validação de composição grounded R1/R2

## Resultado

O preview `MultiLandmarkGroundedPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. Dois landmarks cartográficos foram compostos sobre terreno irregular com grounding confirmado.

| Landmark | Âncora | X/Z mundial | Y desejado | Grounding |
|---|---:|---|---:|---|
| CasaVoss | 1 | `(-22,8)` | 15,00 | `true` |
| PonteMarco2 | 2 | `(-21,4;12)` | 18,00 | `true` |

O terreno irregular produziu impacto Y `-2,52` nos dois candidatos, sem alterar X/Z. A telemetria confirmou `production_script=false` e `dynamic_lights=0`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-071_MULTILANDMARK_RUNTIME.log`.
