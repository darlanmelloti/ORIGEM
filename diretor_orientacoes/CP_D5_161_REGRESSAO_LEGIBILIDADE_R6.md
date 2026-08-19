# CP-D5-161 — Regressão de legibilidade angular R6

## Resultado

A cena `R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os três ângulos da chegada às Ruínas mantiveram Elias, o monólito e o corredor legíveis simultaneamente.

| Verificação | Resultado |
|---|---|
| Ângulos testados | 3 |
| Elias visível | `true` nos três ângulos |
| Monólito visível | `true` nos três ângulos |
| Corredor visível | `true` nos três ângulos |
| Monólito R6 XZ | `(52.00,260.00)` |
| Rota | `x=60.00` |
| Ciclos de rota limpos | 2 (`clear=true`) |
| Monólito aterrado | `true` |
| Câmara Elias de produção | `false` |
| Módulos de produção alterados | `false` |

A regressão aprova a leitura third-person da aproximação R6 sem modificar produção. O log está em `CP-D5-161_R6_READABILITY_RUNTIME.log`.
