# CP-D5-237 — Auditoria LOD vegetal

## Resultado

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria confirma limites de LOD compatíveis com a apresentação de Elias e com o alvo GTX 1050 Ti.

| Activo | Triângulos | Colisões |
|---|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 0 |
| `tree_detailed_dark.glb` | 402 | 0 |
| `fern_02_1k.gltf` | 6.232 | 0 |
| `tree_default_dark.glb` | 114 | 0 |

| Contrato | Limite |
|---|---:|
| Vegetação focal PBR | 1 árvore |
| Vegetação média detalhada | 3 árvores |
| Folhagem distante leve | 8 elementos |
| Luzes dinâmicas | 0 |

A auditoria aprova os limites sem alterar módulos de produção. O log está em `CP-D5-237_LOD_RUNTIME.log`.
