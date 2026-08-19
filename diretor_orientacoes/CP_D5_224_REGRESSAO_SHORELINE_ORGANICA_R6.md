# CP-D5-224 — Regressão da shoreline orgânica R6

## Resultado

A cena `R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A margem orgânica manteve o monólito aterrado, terreno natural e passagem limpa sem cubos de shoreline ou lajes de cais.

| Verificação | Resultado |
|---|---|
| Monólito | `(52.00,260.00)` aterrado |
| Terreno orgânico | `true` |
| Elementos de terreno | 10 |
| Folhagens | 4 |
| Afloramentos | 5 |
| Lajes de cais | 0 |
| Cubos de shoreline | `false` |
| Parede de árvores | `false` |
| Ciclos limpos | 2 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a shoreline orgânica R6 e preserva a substituição viva do cais estrutural. O log está em `CP-D5-224_R6_ORGANIC_SHORE_RUNTIME.log`.
