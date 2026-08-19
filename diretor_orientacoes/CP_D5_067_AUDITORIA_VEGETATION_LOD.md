# CP-D5-067 — Auditoria de LOD da vegetação

## Resultado

O preview `VegetationLodAuditPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless e confirmou os limites de composição orientados ao alvo GTX 1050 Ti.

| Limite | Valor |
|---|---:|
| Árvore focal PBR | 1 |
| Árvores detalhadas médias | 3 |
| Foliagem distante leve | 8 |
| Luzes dinâmicas | 0 |

| Activo | Triângulos | Malhas | Materiais | Colisões | Bytes |
|---|---:|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 | 1.211.556 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 | 31.416 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 | 6.899 |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 | 9.436 |

A advertência FSR1 é do renderer Compatibility local. O log está em `CP-D5-067_VEGETATION_LOD_RUNTIME.log`.
