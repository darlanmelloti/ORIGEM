# CP-D5-192 — Regressão de leitura de vegetação R6 por Elias

## Resultado

A cena `R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito e os três elementos de vegetação foram aterrados sem introduzir linguagem de cais estrutural.

| Verificação | Resultado |
|---|---|
| Monólito aterrado | `true` em `(52.00,260.00)` |
| Vegetação aterrada | 3 elementos |
| Clearance | 6,05 m |
| Rota X | 60,00 |
| Ciclos limpos | 2 |
| Actor | Elias |
| Viewport QA | `CameraQAR6Leitura` |
| Câmara Elias de produção | `false` |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a leitura de vegetação R6 na apresentação third-person, mantendo o monólito orgânico e o escopo Dev5. O log está em `CP-D5-192_R6_VEGETATION_READ_RUNTIME.log`.
