# CP-D5-287 — Regressão placement cartográfico contínua

## Resultado

A cena `CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os seis anchors canónicos foram mapeados entre coordenadas mundo X/Z e posições de canvas sem salto ou alteração de produção.

| Anchor | Região | Mundo X/Z | Canvas |
|---:|---|---|---|
| 1 | Casa Voss | `(-22,8)` | `(80,452)` |
| 2 | Estrada do Rio | `(-21,4;12)` | `(234,462)` |
| 3 | Arco das Ruínas | `(-16,741;48)` | `(362,463)` |
| 4 | Floresta Densa | `(-9,116)` | `(334,244)` |
| 5 | Acampamento Majestic | `(-88,178)` | `(187,258)` |
| 6 | Ruínas Submersas | `(60,252)` | `(408,351)` |

| Contrato | Resultado |
|---|---|
| Anchors validados | 6 |
| Coordenadas mundo preservadas | `true` |
| Posições canvas calculadas | 6 |
| Offsets não autorizados | 0 |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Produção alterada | `false` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-287_PLACEMENT_RUNTIME.log`.
