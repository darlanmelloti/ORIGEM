# CP-D5-276 — Regressão sequência integrada R1–R6 contínua

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias percorreu oito checkpoints sem salto de âncora, com handoffs legíveis entre Majestic e Ruínas e chegada ao marcador da Vila Elevada.

| Checkpoint | Coordenada X/Z | Próximo | Leitura |
|---|---|---:|---|
| R1 Casa Voss | `(-22,8)` | 2 | Rumo à Estrada do Rio |
| R2 saída da estrada | `(-21,25)` | 3 | Rumo ao Arco |
| R3 Arco | `(-16,741,70)` | 4 | Rumo à Floresta |
| R4 Floresta | `(-9,140)` | 5 | Rumo ao Majestic |
| R5 aproximação leste | `(0,178)` | 5 | Rumo ao Majestic |
| R5 Majestic oeste | `(-88,178)` | 6 | Rumo às Ruínas |
| R6 aproximação | `(60,230)` | 6 | Chegada às Ruínas |
| R6 chegada | `(60,252)` | 7 | Passagem: Vila Elevada |

| Contrato | Resultado |
|---|---|
| Checkpoints verificados | 8 |
| Saltos de âncora | 0 (`no_anchor_skip=true`) |
| Handoff Majestic lateral | `true` |
| Chegada às Ruínas | `true` |
| Próximo marcador | R7 Vila Elevada |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-276_SEQUENCE_INTEGRATED_RUNTIME.log`.
