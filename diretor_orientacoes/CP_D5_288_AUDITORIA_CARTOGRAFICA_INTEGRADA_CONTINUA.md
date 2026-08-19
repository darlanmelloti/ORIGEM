# CP-D5-288 — Auditoria cartográfica integrada contínua

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria integrada confirmou seis candidatos Dev5, anchors e offsets nulos, com contratos de colisão específicos e sem scripts de produção ou luzes dinâmicas adicionadas.

| Candidato | Anchor | Mundo X/Z | Offset | Colisões | Script de produção |
|---|---:|---|---|---:|---|
| Casa Voss | 1 | `(-22,8)` | `(0,0)` | 12 | `false` |
| Ponte Marco 2 | 2 | `(-21,4;12)` | `(0,0)` | 14 | `false` |
| Floresta Densa | 4 | `(-9,116)` | `(0,0)` | 20 | `false` |
| Majestic | 5 | `(-88,178)` | `(0,0)` | 4 | `false` |
| Ruínas Submersas | 6 | `(60,252)` | `(0,0)` | 18 | `false` |
| Vegetação média | 4 | `(-9,116)` | `(0,0)` | 0 | `false` |

| Contrato | Resultado |
|---|---|
| Candidatos | 6 |
| Scripts de produção | 0 |
| Luzes dinâmicas adicionadas | 0 |
| Parede de árvores | `false` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-288_CARTOGRAPHIC_AUDIT_RUNTIME.log`.
