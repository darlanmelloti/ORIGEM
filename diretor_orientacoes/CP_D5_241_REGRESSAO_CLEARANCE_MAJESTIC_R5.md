# CP-D5-241 — Regressão de clearance Majestic R5 por Elias

## Resultado

A cena `EliasMajesticClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O pavilhão Majestic está aterrado e mantém passagem livre para Elias com margem superior ao contrato mínimo.

| Verificação | Resultado |
|---|---|
| Pavilhão aterrado | `true` |
| Pavilhão X/Z | `(−88.00,178.00)` |
| Colisor | `CorredorMajesticEliasQA` |
| Rota X | `−80.00` |
| Clearance medido | 5,45 m |
| Clearance exigido | 4,00 m |
| Ciclos de rota | 2, ambos `clear=true` |
| Actor | `Elias` |
| Apresentação | `EliasThirdPersonPresentation` |
| Câmara de produção | `false` |
| Estado | `approved` |

A regressão aprova o clearance do pavilhão Majestic e a passagem de Elias rumo a R6, sem alterar módulos de produção. O log está em `CP-D5-241_R5_MAJESTIC_CLEARANCE_RUNTIME.log`.
