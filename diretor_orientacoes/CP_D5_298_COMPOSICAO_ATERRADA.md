# CP-D5-298 — Regressão da composição multi-marco aterrada

`MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição confirmou os candidatos Casa Voss e Ponte Marco 2 em terreno irregular, com X/Z canónicos preservados e Y resolvido pelo mesmo contacto de terreno.

| Candidato | Âncora | X/Z | Y desejado | Y impacto | Estado |
|---|---:|---|---:|---:|---|
| Casa Voss | 1 | `(-22.0, 8.0)` | 15,00 | -2,52 | `grounded=true` |
| Ponte Marco 2 | 2 | `(-21.4, 12.0)` | 18,00 | -2,52 | `grounded=true` |

Telemetria adicional: `anchors=1,2`, `irregular_ground=true`, `production_script=false`, `dynamic_lights=0`. Evidência completa: `CP-D5-298_MULTILANDMARK_RUNTIME.log`.
