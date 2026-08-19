# CP-D5-252 — Regressão sequência integrada R1–R6

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A sequência confirmou oito checkpoints, zero saltos de âncora e todos os handoffs cartográficos de R1 até à chegada R6 e abertura do marcador R7.

| Checkpoint | Coordenada X/Z | Próximo | Estado |
|---|---|---:|---|
| R1 Casa Voss | `(−22,8)` | 2 | válido |
| Saída estrada R2 | `(−21,4;25)` | 3 | válido |
| R3 Arco | `(−16,741;70)` | 4 | válido |
| R4 Floresta | `(−9,140)` | 5 | válido |
| Aproximação R5 | `(0,178)` | 5 | válido |
| Majestic oeste R5 | `(−88,178)` | 6 | válido |
| Aproximação R6 | `(60,230)` | 6 | válido |
| Chegada R6 | `(60,252)` | 7 | R7 aberto |

| Contrato | Resultado |
|---|---|
| Checkpoints verificados | 8 |
| Saltos de âncora | `false` |
| Lateral Majestic | `true` |
| Chegada às Ruínas | `true` |
| Handoff R6→R7 | `PASSAGEM: VILA ELEVADA` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility no headless. A regressão não altera módulos de produção, `Player.gd` ou Regiões 7–12. O log está em `CP-D5-252_SEQUENCE_R1_R6_RUNTIME.log`.
