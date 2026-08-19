# CP-D5-136 — Regressão de composição multi-landmark

## Resultado

A cena `MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição validou os candidatos de Casa Voss e Ponte Marco 2 em terreno irregular, com grounding separado da produção.

| Verificação | Casa Voss | Ponte Marco 2 |
|---|---:|---:|
| Âncora | 1 | 2 |
| Map X/Z | `(80,452)` | `(234,462)` |
| World X/Z | `(-22,8)` | `(-21,4;12)` |
| Y desejado | 15,00 m | 18,00 m |
| Y impacto | -2,52 m | -2,52 m |
| Grounding | `true` | `true` |

O preview confirmou `irregular_ground=true`, `production_script=false` e `dynamic_lights=0`. A regressão preserva os contratos de posicionamento e grounding sem alterar módulos de produção. O log está em `CP-D5-136_MULTI_LANDMARK_RUNTIME.log`.
