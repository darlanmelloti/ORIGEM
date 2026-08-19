# CP-D5-124 — Regressão do rumo Majestic→Ruínas R5→R6

## Resultado

A cena `EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O rumo partiu de `(-80,190)`, apontou para Ruínas id 6 e confirmou a chegada à âncora R6, preservando a continuidade para a âncora 7.

| Verificação | Resultado |
|---|---|
| Início X/Z | `(-80,190)` |
| Destino | `RUMO ÀS RUÍNAS`, id 6 |
| Canvas início | `(195,6;261,4)` |
| Canvas R6 | `(408,351)` |
| Chegada R6 | `arrival_r6=true` |
| Próxima âncora | 7 — `PASSAGEM: VILA ELEVADA` |
| Câmara de Elias | Inactiva; contrato externo preservado |
| Produção | Inalterada |

A regressão confirma o handoff final do percurso cartográfico R5→R6 e a continuidade de navegação para a âncora 7. O log está em `CP-D5-124_R5_R6_HEADING_RUNTIME.log`.
