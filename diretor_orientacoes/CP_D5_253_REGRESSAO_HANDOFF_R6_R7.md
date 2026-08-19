# CP-D5-253 — Regressão handoff R6→R7

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias alcançou o marcador R7 em modo exclusivamente cartográfico, sem criar geometria da Região 7 nem instanciar a câmara de produção.

| Verificação | Resultado |
|---|---|
| R6 X/Z | `(60.00,252.00)` |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` |
| ID do marcador | 7 |
| R7 X/Z | `(140.00,352.00)` |
| Marcador alcançado | `true` |
| Modo | `marker_only=true` |
| Câmara Elias de produção | `false` |
| Geometria Dev2 criada | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova o handoff R6→R7 e mantém a fronteira de escopo: Dev5 fornece apenas o marcador técnico, sem alterar Região 7 ou criar geometria canónica. O log está em `CP-D5-253_R6_R7_HANDOFF_RUNTIME.log`.
