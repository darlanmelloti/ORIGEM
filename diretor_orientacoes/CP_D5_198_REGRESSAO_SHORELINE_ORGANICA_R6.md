# CP-D5-198 — Regressão da shoreline orgânica R6

## Resultado

A cena `R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A shoreline orgânica preservou o monólito, afloramentos e folhagem sem reintroduzir cubos ou lajes de cais.

| Verificação | Resultado |
|---|---|
| Monólito aterrado | `true` em `(52.00,260.00)` |
| Y do monólito | 0,09 m |
| Terreno orgânico | `true` |
| Elementos de terreno | 10 |
| Folhagens | 4 |
| Afloramentos | 5 |
| Cubos de shoreline | 0 |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Ciclos limpos | 2 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a shoreline orgânica R6 e mantém a linguagem viva do landmark, sem repetir a geometria estrutural rejeitada. O log está em `CP-D5-198_R6_ORGANIC_SHORE_RUNTIME.log`.
