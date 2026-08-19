# CP-D5-209 — Regressão da composição vegetal média R4→R5

## Resultado

A cena `MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). As composições das âncoras R4 e R5 mantiveram a distribuição LOD vegetal prevista sem formar uma parede de árvores.

| Região | Âncora | World X/Z | PBR | Médio | Distante | Offset |
|---|---:|---|---:|---:|---:|---|
| Floresta Densa | 4 | `(−9,116)` | 1 | 3 | 4 | `(0,0)` |
| Acampamento Majestic | 5 | `(−88,178)` | 1 | 3 | 4 | `(0,0)` |

| Verificação | Resultado |
|---|---|
| PBR por composição | 1 |
| Médio por composição | 3 |
| Distante por composição | 4 |
| Parede de árvores | `false` |
| Scripts de produção | `false` |
| Estado | `approved` |

A regressão aprova a composição vegetal média R4→R5 com LOD e offsets canónicos, preservando o corredor jogável e a produção. O log está em `CP-D5-209_MEDIUM_VEGETATION_RUNTIME.log`.
