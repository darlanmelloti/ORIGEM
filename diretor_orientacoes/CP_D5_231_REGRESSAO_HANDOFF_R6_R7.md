# CP-D5-231 — Regressão do handoff R6→R7

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias alcançou o marcador da Vila Elevada sem criar geometria R7, mantendo o limite de escopo e a câmara de produção inactiva.

| Verificação | Resultado |
|---|---|
| R6 X/Z | `(60.00,252.00)` |
| Próximo destino | `PASSAGEM: VILA ELEVADA` id 7 |
| Marcador R7 X/Z | `(140.00,352.00)` |
| Marcador alcançado | `true` |
| Câmara Elias de produção | `false` |
| Modo | `marker_only=true` |
| Geometria Dev2 criada | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

O handoff final de R6 para o marcador R7 está aprovado como transição técnica. A futura geometria da Vila Elevada permanece fora do escopo Dev5 e requer o proprietário correspondente. O log está em `CP-D5-231_R6_R7_HANDOFF_RUNTIME.log`.
