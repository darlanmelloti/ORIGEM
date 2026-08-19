# CP-D5-268 — Regressão sistema de colocação cartográfica

## Resultado

A cena `CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O sistema de colocação confirmou os seis anchors Dev5, mantendo a correspondência entre coordenadas mundo X/Z e posições do mapa de origem.

| Anchor | Marco | Mundo X/Z | Canvas do mapa |
|---:|---|---|---|
| 1 | Casa Voss | `(-22,8)` | `(80,452)` |
| 2 | Estrada do Rio | `(-21,4;12)` | `(234,462)` |
| 3 | Arco das Ruínas | `(-16,741;48)` | `(362,463)` |
| 4 | Floresta Densa | `(-9,116)` | `(334,244)` |
| 5 | Acampamento Majestic | `(-88,178)` | `(187,258)` |
| 6 | Ruínas Submersas | `(60,252)` | `(408,351)` |

| Contrato | Resultado |
|---|---|
| Anchors verificados | 6 |
| Divergências de colocação | 0 |
| Estado | `approved` |
| Produção alterada | `false` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-268_PLACEMENT_SYSTEM_RUNTIME.log`.
