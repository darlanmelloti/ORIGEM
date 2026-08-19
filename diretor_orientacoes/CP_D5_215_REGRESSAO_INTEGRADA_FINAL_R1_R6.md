# CP-D5-215 — Regressão integrada final R1→R6 com Elias

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A sequência cartográfica completou os oito checkpoints sem saltos de âncora, manteve o desvio lateral Majestic e alcançou as Ruínas com continuidade para o marcador R7.

| Checkpoint | World X/Z | Próximo | Leitura |
|---|---|---:|---|
| R1 Casa Voss | `(−22,8)` | 2 | Estrada do Rio |
| R2 saída da estrada | `(−21,25)` | 3 | Arco |
| R3 corredor | `(−16,741,70)` | 4 | Floresta |
| R4 floresta | `(−9,140)` | 5 | Majestic |
| R5 aproximação leste | `(0,178)` | 5 | Majestic |
| R5 Majestic oeste | `(−88,178)` | 6 | Ruínas |
| R6 aproximação | `(60,230)` | 6 | Chegada às Ruínas |
| R6 chegada | `(60,252)` | 7 | Vila Elevada |

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Checks | 8 |
| Salto de âncora | `false` |
| Desvio Majestic lateral | `true` |
| Chegada R6 | `true` |
| Próximo marcador | R7 / Vila Elevada |
| Produção alterada | `false` |

A regressão integrada aprova a sequência navegável R1→R6 de Elias, com apresentação third-person e fronteira marker-only no handoff R6→R7. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-215_INTEGRATED_FINAL_RUNTIME.log`.
