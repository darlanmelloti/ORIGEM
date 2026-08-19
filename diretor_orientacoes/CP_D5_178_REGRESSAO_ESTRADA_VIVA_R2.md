# CP-D5-178 — Regressão da estrada viva R2

## Resultado

A cena `R2LivingRiverRoadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A estrada viva preservou a travessia pela ponte modular e manteve a composição natural sem reintroduzir o candidato GLB rejeitado.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 4 elementos |
| Partes de abrigo | 2 |
| Elementos aterrados | 9 |
| Ponte modular | `true` |
| Ponte GLB | `false` |
| Travessia da ponte | `true` em 5 ciclos |
| Distância fauna | 12,08–12,93 m |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |

A regressão aprova a estrada viva R2 e preserva a ponte modular QA, mantendo o GLB rejeitado fora da sequência. O log está em `CP-D5-178_R2_LIVING_ROAD_RUNTIME.log`.
