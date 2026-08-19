# CP-D5-162 — Regressão de heading R5→R6 de Elias

## Resultado

A cena `EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A orientação de Elias desde R5 conduziu à chegada R6 e expôs o próximo marcador sem activar a câmara de produção.

| Verificação | Resultado |
|---|---|
| Origem XZ | `(-80.00,190.00)` |
| Destino | `RUMO ÀS RUÍNAS` id 6 |
| Chegada R6 | `true` |
| Próximo marco | `PASSAGEM: VILA ELEVADA` id 7 |
| Mapa início | `(195.6,261.4)` |
| Mapa R6 | `(408.0,351.0)` |
| Câmara Elias de produção | `false` |
| Estado | `approved` |
| Produção | Inalterada |

A regressão confirma a orientação cartográfica R5→R6 e a continuidade para o marcador R7 sem modificar módulos regionais. O log está em `CP-D5-162_R5R6_HEADING_RUNTIME.log`.
