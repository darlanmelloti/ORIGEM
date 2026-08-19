# CP-D5-285 — Regressão aterramento global contínua

## Resultado

A cena `CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os contratos globais de aterramento para os dois anexos de referência foram confirmados pelo collider QA, com coordenadas X/Z preservadas.

| Elemento | Y desejado | Impacto Y | Aterramento | X/Z preservado | Collider |
|---|---:|---:|---|---|---|
| Anexo Casa Voss | 15,00 | -2,78 | `true` | `true` | `TerrenoColisorQA` |
| Ponte Marco 2 | 18,00 | -2,71 | `true` | `true` | `TerrenoColisorQA` |

| Contrato | Resultado |
|---|---|
| Elementos validados | 2 |
| Coordenadas preservadas | `true` |
| Collider QA | `TerrenoColisorQA` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-285_GLOBAL_GROUNDING_RUNTIME.log`.
