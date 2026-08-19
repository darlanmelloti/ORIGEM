# CP-D5-120 — Regressão de legibilidade dos ângulos R6

## Resultado

A cena `R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os três ângulos mantiveram Elias, o monólito R6 e o corredor visíveis simultaneamente.

| Verificação | Resultado |
|---|---|
| Ângulos | 3 |
| Elias visível | Sim nos ângulos 1–3 |
| Monólito visível | Sim nos ângulos 1–3 |
| Corredor visível | Sim nos ângulos 1–3 |
| Monólito X/Z | `(52,260)` |
| Câmara de Elias | Inactiva; contrato externo preservado |
| Ciclos de rota | 2, ambos `clear=true` |
| Grounding monólito | Confirmado |
| Produção | Inalterada |

A regressão confirma a legibilidade espacial de R6 sem reintroduzir cais ou alterar módulos de produção. O log está em `CP-D5-120_R6_READABILITY_RUNTIME.log`.
