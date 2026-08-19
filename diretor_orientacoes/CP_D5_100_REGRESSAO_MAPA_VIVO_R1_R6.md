# CP-D5-100 — Regressão do mapa vivo R1–R6

## Resultado

A composição `CartographicSequenceR1R6Preview.tscn` foi revalidada depois das fichas de integração R5/R6 e da refactorização da clareira Majestic. O parser terminou com `PARSER_EXIT=0`; a sessão QA atingiu 36 segundos pelo timeout controlado e confirmou os oito contratos cartográficos.

| Verificação | Resultado |
|---|---|
| Parser | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Contratos | 8 checks |
| Saltos de âncora | Nenhum (`no_anchor_skip=true`) |
| Desvio Majestic | Preservado (`majestic_lateral=true`) |
| Chegada R6 | Confirmada (`ruins_arrival=true`) |
| Continuidade | R6→R7, âncora 7 `PASSAGEM: VILA ELEVADA` |
| Produção | Nenhum módulo alterado pela regressão |

A sequência observada foi R1 Voss → R2 Estrada → R3 Arco → R4 Floresta → R5 aproximação → R5 Majestic lateral → R6 aproximação → R6 chegada. A advertência FSR1 do renderer Compatibility, quando presente, não é falha de parser nem de QA.

O log completo está em `CP-D5-100_LIVING_MAP_REGRESSION_RUNTIME.log`.
