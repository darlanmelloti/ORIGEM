# CP-D5-250 — Regressão costa R6 viva

## Resultado

A cena `R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A costa R6 mantém fauna, vegetação e ruínas colapsadas aterradas, com rota aberta para R7, sem lajes de cais nem parede de árvores.

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
| Módulos de produção alterados | `false` |
| Ciclos de rota | 1, `clear=true` |
| Distância de fauna | 20,08 |

A regressão aprova a composição viva da costa R6 e preserva a linguagem orgânica da margem, sem introduzir cais ou estruturas rejeitadas. O log está em `CP-D5-250_R6_LIVING_SHORE_RUNTIME.log`.
