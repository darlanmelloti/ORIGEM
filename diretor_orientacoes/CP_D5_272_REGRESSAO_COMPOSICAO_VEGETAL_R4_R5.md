# CP-D5-272 — Regressão composição vegetal média R4–R5

## Resultado

A cena `MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). As composições da Floresta Densa R4 e do Acampamento Majestic R5 mantêm o mesmo contrato de densidade, offsets nulos, leitura aberta e sem parede de árvores.

| Composição | Anchor | PBR focal | Vegetação média | Folhagem distante | Offset local |
|---|---:|---:|---:|---:|---|
| Floresta Densa | 4, `(-9,116)` | 1 | 3 | 4 | `(0,0)` |
| Acampamento Majestic | 5, `(-88,178)` | 1 | 3 | 4 | `(0,0)` |

| Contrato | Resultado |
|---|---|
| Anchors | 4, 5 |
| PBR por composição | 1 |
| Médio por composição | 3 |
| Distante por composição | 4 |
| Parede de árvores | `false` |
| Scripts de produção | 0 |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-272_MEDIUM_VEGETATION_RUNTIME.log`.
