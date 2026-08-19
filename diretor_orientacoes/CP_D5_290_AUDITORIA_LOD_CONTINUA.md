# CP-D5-290 — Auditoria LOD vegetal contínua

## Resultado

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os quatro activos auditados permanecem dentro dos limites LOD definidos para a GTX 1050 Ti, sem colisões e sem luzes dinâmicas adicionadas.

| Activo | Triângulos | Malhas | Materiais | Colisões | Bytes |
|---|---:|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 | 1.211.556 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 | 31.416 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 | 6.899 |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 | 9.436 |

| Contrato | Limite/resultado |
|---|---|
| Focal | 1 árvore PBR |
| Médio | 3 árvores detalhadas |
| Distante | 8 folhagens leves |
| Luzes dinâmicas | 0 |
| Compatibilidade | GTX 1050 Ti |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-290_LOD_AUDIT_RUNTIME.log`.
