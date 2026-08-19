# CP-D5-283 — Regressão multi-marco de aterramento contínua

## Resultado

A cena real `MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os anchors Casa Voss e Ponte Marco 2 foram validados em terreno irregular com aterramento confirmado, coordenadas X/Z preservadas, script de produção intocado e zero luzes dinâmicas.

| Landmark | Anchor | Mapa | Mundo X/Z | Y desejado | Impacto Y | Aterramento |
|---|---:|---|---|---:|---:|---|
| Casa Voss | 1 | `(80,452)` | `(-22,8)` | 15,00 | -2,52 | `true` |
| Ponte Marco 2 | 2 | `(234,462)` | `(-21,4;12)` | 18,00 | -2,52 | `true` |

| Contrato | Resultado |
|---|---|
| Anchors verificados | 1, 2 |
| Terreno irregular | `true` |
| Scripts de produção | 0 |
| Luzes dinâmicas | 0 |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-283_MULTILANDMARK_GROUNDING_RUNTIME.log`.
