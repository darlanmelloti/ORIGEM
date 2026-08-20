# CP-D5-577 — Regressão técnica de grounding e transformação cartográfica

## Resultado

A regressão repetida do preview isolado confirmou a estabilidade do grounding de R2, R3 e R6 após a auditoria de sequência cartográfica. Os três raycasts continuam válidos, o erro vertical permanece `0.000 m`, Elias conserva clearance de `0.020 m` e a sequência `R2>R3>R6` permanece válida.

O backup mais recente é `BK_20260820_201625_CP-D5-572`. Como a janela de quatro horas ainda não venceu nesta execução, nenhum backup adicional foi criado; o existente não foi sobrescrito.

| Critério | Resultado |
|---|---|
| Parser/execução | Sem `SCRIPT ERROR`, `Parse Error` ou falha de carregamento |
| R2/R3/R6 | `grounded=true`, `3/3` |
| Erro vertical | `0.000 m` |
| Consistência | `3/3` |
| Sequência | `R2>R3>R6 valid=true` |
| QA | `36 s`, `QA_EXIT=124` por término controlado |
| Estado Git antes deste artefacto | `HEAD=381d2b3`, remoto igual, `0 0` |

**STATUS_CODE: PASSED / GROUNDING_REGRESSION / BACKUP_WINDOW_NOT_DUE.**
