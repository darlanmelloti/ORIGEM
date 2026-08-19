# CP-D5-183 — Regressão final de clearance R6 de Elias

## Resultado

A cena `EliasR6ClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A aproximação às Ruínas manteve o monólito aterrado e margem de passagem superior ao mínimo contratado.

| Verificação | Resultado |
|---|---|
| Monólito aterrado | `true` |
| Monólito XZ | `(52.00,260.00)` |
| Rota X | `60.00` |
| Clearance | 6,05 m |
| Mínimo requerido | 4,00 m |
| Colisor | `CorredorMargemR6EliasQA` |
| Ciclos limpos | 2 |
| Actor | Elias |
| Apresentação | `EliasThirdPersonPresentation` |
| Câmara de produção | `false` |
| Estado | `approved` |

A regressão final confirma o corredor R6 para Elias, sem alterar produção. O log está em `CP-D5-183_R6_CLEARANCE_RUNTIME.log`.
