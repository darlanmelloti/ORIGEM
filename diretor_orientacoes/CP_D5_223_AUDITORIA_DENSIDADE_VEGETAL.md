# CP-D5-223 — Auditoria de densidade vegetal GTX 1050 Ti

## Resultado

A cena `VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição vegetal manteve densidade controlada e não formou parede de árvores.

| Componente | Quantidade |
|---|---:|
| `pine_focal` | 1 |
| `dark_tree_medium` | 3 |
| `tree_light` | 1 |
| `fern_foreground` | 2 |
| Total de elementos | 7 |
| Total de triângulos | 27.208 |

| Verificação | Resultado |
|---|---|
| Luzes dinâmicas | 0 |
| Densidade em parede | `false` |
| Estado | `approved` |
| Alvo técnico | GTX 1050 Ti |

A auditoria aprova a densidade vegetal Dev5, mantendo composição focal/média/distante, carga de triângulos controlada e ausência de luzes ou paredes de árvores. O log está em `CP-D5-223_VEGETATION_DENSITY_RUNTIME.log`.
