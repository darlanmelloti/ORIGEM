# CP-D5-273 — Auditoria de legibilidade R6 contínua

## Resultado

A cena `R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os três ângulos mantiveram Elias, o monólito e o corredor visíveis, com duas rotas livres e monólito aterrado.

| Ângulo | Elias visível | Monólito visível | Corredor visível |
|---:|---|---|---|
| 1 | `true` | `true` | `true` |
| 2 | `true` | `true` | `true` |
| 3 | `true` | `true` | `true` |

| Contrato | Resultado |
|---|---|
| Anchor R6 / monólito XZ | `(52,260)` |
| Rota R7 X | 60,00 |
| Ângulos auditados | 3 |
| Ciclos de rota | 2, ambos `clear=true` |
| Monólito aterrado | `true` |
| Câmara de produção corrente | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-273_READABILITY_ANGLES_RUNTIME.log`.
