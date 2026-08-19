# CP-D5-269 — Regressão Casa Voss Waystation

## Resultado

A cena `VossWaystationPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O contrato explícito de QA confirmou o anexo da Casa Voss aterrado, rota aberta e módulos de produção preservados.

| Verificação | Resultado |
|---|---|
| Landmark | `AnexoCasaVoss_QA` |
| Aterramento | `true` |
| Rota | `route_open=true` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. A pequena correção de instrumentação ficou confinada a `levels/dev5/VossWaystationPreview.gd`; nenhum módulo de produção foi alterado. O log está em `CP-D5-269_VOSS_WAYSTATION_RUNTIME.log`.
