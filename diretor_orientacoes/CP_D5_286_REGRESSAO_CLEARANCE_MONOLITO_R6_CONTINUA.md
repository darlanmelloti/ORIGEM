# CP-D5-286 — Regressão clearance monólito R6 contínua

## Resultado

A cena `R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito R6 permanece aterrado e o corredor de Elias mantém margem de passagem superior ao mínimo técnico.

| Verificação | Resultado |
|---|---|
| Monólito X/Z | `(52,260)` |
| Collider | `CorredorMargemR6QA` |
| Monólito aterrado | `true` |
| Raio monólito | 1,40 m |
| Raio jogador | 0,55 m |
| Clearance mínimo | 6,05 m |
| Clearance requerido | 4,00 m |
| Rotas livres | 2, ambas `clear=true` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-286_MONOLITH_CLEARANCE_RUNTIME.log`.
