# CP-D5-168 — Regressão de leitura de vegetação R6 por Elias

## Resultado

A cena `R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição mantém o monólito e a vegetação legíveis na apresentação third-person, com aterramento e margem de passagem.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Monólito aterrado | `true` em `(52.00,260.00)` |
| Vegetação aterrada | 3 elementos |
| Clearance da rota | 6,05 m |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Câmara Elias de produção | `false` |
| Viewport QA | `CameraQAR6Leitura` |
| Ciclos limpos | 2 |
| Actor | Elias |
| Módulos de produção alterados | `false` |

A regressão aprova a leitura da margem R6 sem repetir a linguagem de cais e sem alterar produção. O log está em `CP-D5-168_R6_ELIAS_VEGETATION_RUNTIME.log`.
