# CP-D5-240 — Regressão heading R5→R6

## Resultado

A cena `EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias iniciou na aproximação Majestic R5, manteve o heading para as Ruínas e chegou a R6 com o próximo marcador R7 correctamente exposto.

| Verificação | Resultado |
|---|---|
| Início X/Z | `(−80.00,190.00)` |
| Destino | `RUMO ÀS RUÍNAS` id 6 |
| Início no mapa | `(195.6,261.4)` |
| R6 no mapa | `(408.0,351.0)` |
| Chegada R6 | `true` |
| Próxima âncora | 7 |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova o heading R5→R6 e confirma a continuidade para R7 sem alterar módulos de produção. O log está em `CP-D5-240_R5_R6_HEADING_RUNTIME.log`.
