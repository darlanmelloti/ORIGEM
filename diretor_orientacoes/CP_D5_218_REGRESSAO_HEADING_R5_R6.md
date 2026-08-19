# CP-D5-218 — Regressão do heading R5→R6 de Elias

## Resultado

A cena `EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias saiu da aproximação Majestic orientado para as Ruínas, alcançou R6 e recebeu continuidade para o marcador R7.

| Verificação | Resultado |
|---|---|
| Posição inicial X/Z | `(−80.00,190.00)` |
| Destino | `RUMO ÀS RUÍNAS` |
| ID do destino | 6 |
| Map start | `(195.6,261.4)` |
| Map R6 | `(408.0,351.0)` |
| Chegada R6 | `true` |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` id 7 |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova a orientação R5→R6, preservando a câmara third-person externa e o handoff marker-only para R7. O log está em `CP-D5-218_R5_R6_HEADING_RUNTIME.log`.
