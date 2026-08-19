# CP-D5-150 — Regressão da composição média de vegetação R4/R5

## Resultado

A cena `MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). As composições de Floresta Densa R4 e Acampamento Majestic R5 mantiveram os contratos de vegetação por distância.

| Região | PBR | Média | Distante | Offset local |
|---|---:|---:|---:|---|
| Floresta Densa R4 | 1 | 3 | 4 | `(0,0)` |
| Acampamento Majestic R5 | 1 | 3 | 4 | `(0,0)` |

A auditoria confirmou `wall_of_trees=false` e `production_script=false`. O passe preserva a legibilidade dos corredores e não promove qualquer aprovação visual rejeitada. O log está em `CP-D5-150_MEDIUM_VEGETATION_RUNTIME.log`.
