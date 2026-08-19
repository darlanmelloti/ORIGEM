# CP-D5-282 — Regressão costa R6 viva contínua

## Resultado

A cena `R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A costa viva R6 mantém fauna, vegetação, ruínas colapsadas e aterramento, com rota aberta e sem reintroduzir cais de lajes ou parede de árvores.

| Verificação | Resultado |
|---|---|
| Fauna | 2 |
| Vegetação | 4 |
| Partes de ruínas | 3 |
| Elementos aterrados | 9 |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Ruína colapsada | `true` |
| Distância de fauna | 20,08 |
| Ciclo de rota | 1, `clear=true` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-282_R6_LIVING_SHORE_RUNTIME.log`.
