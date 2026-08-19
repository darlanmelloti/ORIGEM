# CP-D5-131 — Regressão da sequência cartográfica R1→R6

## Resultado

A primeira invocação usou incorrectamente `EliasCartographicSequenceR1R6Preview.tscn`, recurso inexistente, e terminou com `QA_EXIT=1`. A causa foi diagnosticada e corrigida usando a cena existente `CartographicSequenceR1R6Preview.tscn`; a reexecução passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado).

| Verificação | Resultado |
|---|---|
| Checks | 8 |
| Âncoras | R1, R2, R3, R4, R5 oeste, R6 aproximação e R6 chegada |
| Saltos de âncora | Nenhum (`no_anchor_skip=true`) |
| Desvio Majestic | Preservado (`majestic_lateral=true`) |
| Chegada Ruínas | Confirmada (`ruins_arrival=true`) |
| Próxima âncora | 7 — `PASSAGEM: VILA ELEVADA` |
| Estado | `approved` |
| Produção | Inalterada |

O log da tentativa inicial está em `CP-D5-131_FULL_SEQUENCE_RUNTIME.log`; a validação corrigida está em `CP-D5-131_FULL_SEQUENCE_FIXED_RUNTIME.log`.
