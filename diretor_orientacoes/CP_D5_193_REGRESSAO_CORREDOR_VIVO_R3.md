# CP-D5-193 — Regressão do corredor vivo R3

## Resultado

A cena `R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O corredor vivo substituiu a leitura estrutural rejeitada por ruínas compactas e paisagem orgânica, mantendo a passagem aberta.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 4 elementos |
| Partes de ruína | 2 |
| Elementos aterrados | 8 |
| Arco estrutural | `false` |
| Escala comprimida | `false` |
| Clearance | 4 ciclos `clear=true` |
| Distância fauna | 11,49–12,26 m |
| Módulos de produção alterados | `false` |

A regressão aprova o corredor vivo R3, preservando a substituição orgânica e sem reintroduzir o arco estrutural rejeitado. O log está em `CP-D5-193_R3_LIVING_CORRIDOR_RUNTIME.log`.
