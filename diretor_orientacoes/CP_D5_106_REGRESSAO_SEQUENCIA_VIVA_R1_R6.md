# CP-D5-106 — Regressão da sequência viva R1–R6

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` foi revalidada após os novos contratos de Casa Voss, Arco R3 e transição Floresta→Majestic. O parser terminou com `PARSER_EXIT=0`; a sessão QA atingiu 36 segundos pelo timeout controlado e confirmou a sequência cartográfica completa.

| Verificação | Resultado |
|---|---|
| Parser | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Contratos | 8 checks |
| Saltos de âncora | Nenhum (`no_anchor_skip=true`) |
| R1→R2 | Voss para Estrada do Rio confirmado |
| R2→R3 | Estrada para Arco confirmado |
| R3→R4 | Arco para Floresta confirmado |
| R4→R5 | Floresta para Majestic confirmado |
| Desvio Majestic | Preservado (`majestic_lateral=true`) |
| R5→R6 | Majestic para Ruínas confirmado |
| Chegada R6 | Confirmada (`ruins_arrival=true`) |
| Continuidade | Âncora 7, Vila Elevada |

A regressão confirma que os handoffs recentes não quebraram a sequência viva do mapa. O log completo está em `CP-D5-106_R1_R4_SEQUENCE_RUNTIME.log`.
