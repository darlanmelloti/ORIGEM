# CP-D5-128 — Regressão da folga Elias R6

## Resultado

A cena `EliasR6ClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias percorreu a margem R6 com o monólito aterrado e folga suficiente para o corredor.

| Verificação | Resultado |
|---|---|
| Monólito | Aterrado em `(52,260)` |
| Colisor | `CorredorMargemR6EliasQA` |
| Rota de Elias | `x=60` |
| Clearance | 6,05 m |
| Clearance mínimo | 4,00 m |
| Ciclos | 2, ambos `clear=true` |
| Câmara de Elias | Inactiva; viewport QA externo |
| Apresentação | `EliasThirdPersonPresentation` |
| Produção | Inalterada |

A regressão confirma que o monólito não invade o corredor de Elias e que o handoff R6 permanece navegável. O log está em `CP-D5-128_R6_CLEARANCE_RUNTIME.log`.
