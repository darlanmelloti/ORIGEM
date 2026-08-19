# CP-D5-191 — Regressão de legibilidade angular R6

## Resultado

A cena `R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os três ângulos mantiveram Elias, o monólito e o corredor simultaneamente visíveis.

| Verificação | Resultado |
|---|---|
| Ângulos auditados | 3 |
| Elias visível | `true` nos 3 |
| Monólito visível | `true` nos 3 |
| Corredor visível | `true` nos 3 |
| Monólito XZ | `(52.00,260.00)` |
| Rota X | `60.00` |
| Ciclos limpos | 2 |
| Monólito aterrado | `true` |
| Câmara Elias de produção | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a legibilidade angular R6 para a apresentação third-person de Elias. O log está em `CP-D5-191_R6_READABILITY_RUNTIME.log`.
