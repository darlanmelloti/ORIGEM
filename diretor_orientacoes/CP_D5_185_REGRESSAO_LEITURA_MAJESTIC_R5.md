# CP-D5-185 — Regressão de leitura Majestic R5 por Elias

## Resultado

A cena `MajesticEliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A vegetação e o pavilhão permaneceram legíveis e aterrados no desvio lateral de Elias.

| Verificação | Resultado |
|---|---|
| Pavilhão aterrado | `true` em `(−88.00,178.00)` |
| Vegetação aterrada | 5 elementos |
| Rota X | `−80.00` |
| Clearance | 5,45 m |
| Ciclos limpos | 2 |
| Pavilhão visível | `true` |
| Parede de árvores | `false` |
| Viewport QA | `CameraQAMajesticLeitura` |
| Câmara Elias de produção | `false` |
| Actor | Elias |
| Módulos de produção alterados | `false` |

A regressão aprova a leitura third-person do desvio Majestic sem assumir a câmara de produção. O log está em `CP-D5-185_MAJESTIC_VEGETATION_READ_RUNTIME.log`.
