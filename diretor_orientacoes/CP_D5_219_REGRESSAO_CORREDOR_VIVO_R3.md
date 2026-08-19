# CP-D5-219 — Regressão do corredor vivo R3

## Resultado

A cena `R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O corredor orgânico manteve a passagem aberta sem reintroduzir o arco estrutural rejeitado.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 4 elementos |
| Partes de ruína | 2 |
| Elementos aterrados | 8 |
| Ciclos limpos | 4 |
| Distância fauna | 11,49–12,26 m |
| Arco estrutural | `false` |
| Escala comprimida | `false` |
| Módulos de produção alterados | `false` |

A regressão aprova o corredor vivo R3, preservando clearance, leitura natural e fronteira com a produção. O log está em `CP-D5-219_R3_LIVING_CORRIDOR_RUNTIME.log`.
