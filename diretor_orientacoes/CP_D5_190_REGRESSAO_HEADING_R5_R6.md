# CP-D5-190 — Regressão do heading R5→R6 de Elias

## Resultado

A cena `EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O desvio Majestic conduziu Elias às Ruínas e deixou o próximo marcador R7 correctamente exposto.

| Verificação | Resultado |
|---|---|
| Origem | `(-80.00,190.00)` |
| Destino | `RUMO ÀS RUÍNAS` id 6 |
| Canvas início | `(195.6,261.4)` |
| Canvas R6 | `(408.0,351.0)` |
| Chegada R6 | `true` |
| Próxima âncora | 7 |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão confirma o heading R5→R6 sem saltos e preserva a continuidade para R7. O log está em `CP-D5-190_R5R6_HEADING_RUNTIME.log`.
