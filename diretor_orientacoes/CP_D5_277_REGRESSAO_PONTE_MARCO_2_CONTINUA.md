# CP-D5-277 — Regressão Ponte Marco 2 contínua

## Resultado

A cena `StoneBridgeLandmarkPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O landmark Ponte Marco 2 mantém construção modular, aterramento, clearance de 0,21 m, rota aberta e ausência do GLB rejeitado.

| Verificação | Resultado |
|---|---|
| Ponte modular | `true` |
| Aterramento | `true` |
| Clearance | 0,21 m |
| Rota | `route_open=true` |
| GLB rejeitado | ausente |
| Lajes/cais rejeitados | não reintroduzidos |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. A instrumentação ficou confinada a `levels/dev5/StoneBridgeLandmarkPreview.gd`; nenhum módulo de produção foi alterado. O log está em `CP-D5-277_STONE_BRIDGE_RUNTIME.log`.
