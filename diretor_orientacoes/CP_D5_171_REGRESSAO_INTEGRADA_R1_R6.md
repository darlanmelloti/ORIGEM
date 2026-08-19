# CP-D5-171 — Regressão integrada R1→R6 com Elias

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A sequência completa manteve oito checks, sem saltos de âncora, preservando o desvio lateral Majestic e a chegada às Ruínas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Checks | 8 |
| Saltos de âncora | Nenhum (`no_anchor_skip=true`) |
| Desvio Majestic | Preservado (`majestic_lateral=true`) |
| Chegada R6 | Confirmada (`ruins_arrival=true`) |
| Último marcador | `PASSAGEM: VILA ELEVADA` id 7 |
| R1→R6 | Completa |
| Produção | Inalterada |

Os avisos FSR1 observados no renderer Compatibility são conhecidos e não constituem erro de parser ou de script Dev5. O log está em `CP-D5-171_FULL_SEQUENCE_RUNTIME.log`.
