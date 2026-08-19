# CP-D5-235 — Regressão da leitura vegetal R6 por Elias

## Resultado

A cena `R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição vegetal mantém leitura leve e orgânica no shoreline R6, sem parede de árvores nem repetição das lajes de cais rejeitadas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Monólito aterrado | `true`, `(52,260)` |
| Vegetação | 3 elementos |
| Elementos exemplares | `tree_light_right`, `fern_left`, `fern_right` |
| Rota | `x=60.00` |
| Clearance | 6,05 m |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Câmara Elias de produção | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 2, ambos `clear=true` |
| Actor | `Elias` |

A regressão aprova a leitura vegetal de R6 para Elias e preserva o orçamento orgânico e o handoff para R7. O log está em `CP-D5-235_R6_VEGETATION_RUNTIME.log`.
