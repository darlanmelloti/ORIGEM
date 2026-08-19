# CP-D5-221 — Regressão da leitura de vegetação R6 por Elias

## Resultado

A cena `R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias percorreu o corredor R6 junto ao monólito, com vegetação aterrada e leitura third-person preservada.

| Verificação | Resultado |
|---|---|
| Monólito aterrado | `true` em `(52,260)` |
| Vegetação aterrada | 3 elementos |
| Elementos | `tree_light_right`, `fern_left`, `fern_right` |
| Clearance | 6,05 m |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Câmara Elias de produção | `false` |
| Viewport QA | `CameraQAR6Leitura` |
| Ciclos limpos | 2 |
| Actor | Elias |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a leitura de vegetação R6 por Elias e preserva a margem orgânica sem cais estrutural. O log está em `CP-D5-221_R6_VEGETATION_READ_RUNTIME.log`.
