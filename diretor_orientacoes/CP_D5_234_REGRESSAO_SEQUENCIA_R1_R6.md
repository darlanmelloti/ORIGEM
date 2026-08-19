# CP-D5-234 — Regressão da sequência cartográfica integrada R1–R6

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A sequência validou oito checkpoints de Elias, sem saltar âncoras, incluindo as transições R1→R2, R2→R3, R3→R4, R4→R5, aproximação lateral do Majestic, R5→R6 e chegada às Ruínas com handoff para R7.

| Checkpoint | X/Z | Próximo | Resultado |
|---|---:|---:|---|
| R1 Casa Voss | `(−22,8)` | 2 | válido |
| R2 saída estrada | `(−21,4;25)` | 3 | válido |
| R3 arco/corredor | `(−16,741;70)` | 4 | válido |
| R4 floresta | `(−9,140)` | 5 | válido |
| R5 aproximação leste | `(0,178)` | 5 | válido |
| R5 Majestic oeste | `(−88,178)` | 6 | válido |
| R6 aproximação | `(60,230)` | 6 | válido |
| R6 chegada | `(60,252)` | 7 | válido |

A telemetria final confirmou `status=approved`, `checks=8`, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`. Os avisos `FSR1 is only available when using the Forward+ renderer` pertencem à configuração headless OpenGL Compatibility e não produziram `SCRIPT ERROR` ou `Parse Error`; o contrato Dev5 permanece aprovado. O log está em `CP-D5-234_R1_R6_SEQUENCE_RUNTIME.log`.
