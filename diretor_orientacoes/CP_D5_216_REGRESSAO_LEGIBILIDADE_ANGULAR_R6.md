# CP-D5-216 — Regressão da legibilidade angular R6

## Resultado

A cena `R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os três enquadramentos mantiveram Elias, o monólito e o corredor visíveis, com dois ciclos de rota limpos.

| Verificação | Resultado |
|---|---|
| Ângulos auditados | 3 |
| Elias visível | `true` em todos |
| Monólito visível | `true` em todos |
| Corredor visível | `true` em todos |
| Monólito X/Z | `(52.00,260.00)` |
| Rota X | `60.00` |
| Câmara Elias de produção | `false` |
| Ciclos limpos | 2 |
| Monólito aterrado | `true` |
| Módulos de produção alterados | `false` |

A regressão aprova a legibilidade angular R6 e a apresentação third-person de Elias, preservando a produção. O log está em `CP-D5-216_R6_READABILITY_RUNTIME.log`.
