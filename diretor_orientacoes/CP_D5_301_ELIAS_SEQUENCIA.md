# CP-D5-301 — Regressão de Elias na sequência R1–R6

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A sequência reconfirmou os oito handoffs, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`, preservando a fundação de terceira pessoa de Elias sem alteração em `Player.gd` ou módulos de produção.

| Critério | Resultado |
|---|---|
| Elias / terceira pessoa | fundação QA preservada |
| Handoffs | 8 consecutivos |
| Saltos de âncora | `false` |
| Majestic lateral | `true` |
| Chegada às Ruínas | `true` |
| Próxima passagem | Vila Elevada |
| Parser | `PARSER_EXIT=0` |
| QA | 36 s, timeout controlado |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-301_INTEGRATED_ELIAS_RUNTIME.log`.
