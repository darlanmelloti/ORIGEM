# CP-D5-148 — Passe técnico de leitura da vegetação R6

## Resultado

A cena `R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O passe técnico confirmou a leitura da margem no nível de Elias, sem promover uma aprovação visual final.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Monólito | Aterrado em `(52,260)` |
| Vegetação aterrada | `tree_light_right`, `fern_left`, `fern_right` |
| Vegetação | 3 elementos |
| Clearance de Elias | 6,05 m |
| Ciclos de rota | 2, ambos `clear=true` |
| Actor | Elias |
| Câmara actual | Falsa; `CameraQAR6Leitura` proprietária |
| Lajes de cais | 0 |
| Parede vegetal | Ausente |
| Produção | Inalterada |

O passe confirma profundidade técnica e legibilidade da vegetação no corredor R6. O log está em `CP-D5-148_R6_VEGETATION_READ_RUNTIME.log`.
