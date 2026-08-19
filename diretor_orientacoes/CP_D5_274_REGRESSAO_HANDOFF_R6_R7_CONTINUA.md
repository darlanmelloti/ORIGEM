# CP-D5-274 — Regressão handoff R6→R7 contínua

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias percorreu o handoff final a partir de R6 e alcançou o marcador `PASSAGEM: VILA ELEVADA`, id 7, sem criar geometria Dev2 ou alterar módulos de produção.

| Verificação | Resultado |
|---|---|
| R6 X/Z | `(60,252)` |
| Marcador seguinte | `PASSAGEM: VILA ELEVADA` |
| Id do marcador | 7 |
| R7 X/Z | `(140,352)` |
| Marcador R7 alcançado | `true` |
| Elias camera current | `false` |
| Modo | `marker_only=true` |
| Geometria Dev2 criada | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-274_HANDOFF_R6_R7_RUNTIME.log`.
