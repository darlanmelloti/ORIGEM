# CP-D5-199 — Auditoria de placement cartográfico R1→R6

## Resultado

A cena `CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A sessão foi executada explicitamente com o recurso da cena para garantir que os seis marcadores fossem instanciados no modo headless.

| Âncora | Região | World X/Z | Canvas X/Y |
|---:|---|---|---|
| 1 | Casa Voss | `(−22.000,8.000)` | `(80,452)` |
| 2 | Estrada do Rio | `(−21.400,12.000)` | `(234,462)` |
| 3 | Arco das Ruínas | `(−16.741,48.000)` | `(362,463)` |
| 4 | Floresta Densa | `(−9.000,116.000)` | `(334,244)` |
| 5 | Acampamento Majestic | `(−88.000,178.000)` | `(187,258)` |
| 6 | Ruínas Submersas | `(60.000,252.000)` | `(408,351)` |

| Verificação | Resultado |
|---|---|
| Âncoras emitidas | 6/6 |
| Offsets QA | `(0,0)` |
| Parser | Aprovado |
| QA | 36 s, timeout controlado |
| Estado | `approved` |
| Produção alterada | `false` |

A auditoria confirma a colocação cartográfica canónica R1→R6 sem deslocamentos e sem modificar módulos de produção. O log está em `CP-D5-199_CARTOGRAPHIC_PLACEMENT_RUNTIME.log`.
