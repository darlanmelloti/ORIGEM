# CP-D5-196 — Regressão da margem viva R6

## Resultado

A cena `R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A margem orgânica manteve uma ruína colapsada e shoreline natural, sem reintroduzir cais estrutural.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 4 elementos |
| Partes de ruína | 3 |
| Elementos aterrados | 9 |
| Ruína colapsada | `true` |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Clearance fauna | 20,08 m |
| Ciclos limpos | 1 |
| Módulos de produção alterados | `false` |

A regressão aprova a margem viva R6 e preserva a substituição orgânica do cais rejeitado. O log está em `CP-D5-196_R6_LIVING_SHORE_RUNTIME.log`.
