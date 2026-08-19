# CP-D5-186 — Regressão final do handoff R6→R7

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias alcançou o marcador da Vila Elevada sem criar geometria fora do escopo Dev5.

| Verificação | Resultado |
|---|---|
| Origem R6 XZ | `(60.00,252.00)` |
| Destino R7 XZ | `(140.00,352.00)` |
| Marcador | `PASSAGEM: VILA ELEVADA` id 7 |
| Marcador alcançado | `true` |
| Modo | `marker_only=true` |
| Geometria Dev2 criada | `false` |
| Câmara Elias de produção | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão confirma o limite de integração: Dev5 entrega o marcador técnico da próxima região, sem implementar a geometria da Vila Elevada. O log está em `CP-D5-186_R6R7_HANDOFF_RUNTIME.log`.
