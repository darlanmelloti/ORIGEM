# CP-D5-206 — Regressão do handoff final R6→R7

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias alcançou o marcador da Vila Elevada em modo marker-only, sem criar geometria fora do escopo Dev5.

| Verificação | Resultado |
|---|---|
| R6 X/Z | `(60.00,252.00)` |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` id 7 |
| R7 X/Z | `(140.00,352.00)` |
| Marcador alcançado | `true` |
| Modo | `marker_only=true` |
| Câmara Elias de produção | `false` |
| Geometria Dev2 criada | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova o limite de responsabilidade R6→R7: Dev5 entrega apenas o marcador e não cria geometria da Vila Elevada. O log está em `CP-D5-206_R6_R7_HANDOFF_RUNTIME.log`.
