# CP-D5-243 — Regressão de clearance R6 por Elias

## Resultado

A cena `EliasR6ClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito R6 está aterrado no corredor QA e mantém margem suficiente para a passagem de Elias rumo ao handoff R7.

| Verificação | Resultado |
|---|---|
| Monólito aterrado | `true` |
| Monólito X/Z | `(52.00,260.00)` |
| Colisor | `CorredorMargemR6EliasQA` |
| Rota X | `60.00` |
| Clearance medido | 6,05 m |
| Clearance exigido | 4,00 m |
| Ciclos de rota | 2, ambos `clear=true` |
| Actor | `Elias` |
| Apresentação | `EliasThirdPersonPresentation` |
| Câmara de produção | `false` |
| Estado | `approved` |

A regressão aprova o corredor R6 de Elias e preserva a transição para R7 sem alterar módulos de produção. O log está em `CP-D5-243_R6_CLEARANCE_RUNTIME.log`.
