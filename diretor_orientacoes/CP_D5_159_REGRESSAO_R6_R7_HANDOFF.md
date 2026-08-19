# CP-D5-159 — Regressão do handoff R6→R7

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias iniciou na zona R6 e alcançou o marcador da próxima região sem assumir geometria que pertence a Dev2.

| Verificação | Resultado |
|---|---|
| Estado do parser | Aprovado |
| Origem R6 XZ | `(60.00, 252.00)` |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` |
| ID do marcador | `7` |
| Destino R7 XZ | `(140.00, 352.00)` |
| Marcador R7 alcançado | `true` |
| Geometria Dev2 criada | `false` |
| Câmara Elias de produção | `false` |
| Modo | `marker_only=true` |
| Módulos de produção alterados | `false` |

O handoff está aprovado como marcador técnico; a geometria da Vila Elevada permanece fora do escopo Dev5 e não foi criada. O log está em `CP-D5-159_R6R7_HANDOFF_RUNTIME.log`.
