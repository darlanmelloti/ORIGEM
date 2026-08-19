# CP-D5-157 — Regressão final da sequência cartográfica R1→R6

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A sequência final confirmou os oito contratos entre Casa Voss, Estrada do Rio, Arco, Floresta, Majestic e Ruínas.

| Verificação | Resultado |
|---|---|
| Checks | 8 |
| Saltos de âncora | Nenhum (`no_anchor_skip=true`) |
| Desvio Majestic | Preservado (`majestic_lateral=true`) |
| Chegada Ruínas | Confirmada (`ruins_arrival=true`) |
| Próximo destino | Âncora 7 — Vila Elevada |
| Estado | `approved` |
| Produção | Inalterada |

A regressão final confirma a navegação cartográfica R1→R6 e a continuidade para trabalho futuro sem criar geometria de produção da Vila Elevada. O log está em `CP-D5-157_SEQUENCE_FINAL_RUNTIME.log`.
