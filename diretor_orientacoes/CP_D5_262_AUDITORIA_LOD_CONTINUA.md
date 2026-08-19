# CP-D5-262 — Auditoria LOD vegetal contínua

## Resultado

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os activos focal, médio e distante permanecem dentro dos limites de triângulos e sem luzes dinâmicas adicionadas.

| Activo | Triângulos | Malhas | Materiais | Colisões | Tamanho |
|---|---:|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 | 1.211.556 bytes |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 | 31.416 bytes |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 | 6.899 bytes |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 | 9.436 bytes |

| Limite | Valor |
|---|---:|
| Árvore PBR focal | 1 |
| Árvores detalhadas médias | 3 |
| Folhagem leve distante | 8 |
| Luzes dinâmicas | 0 |
| Estado | `approved` |
| Plataforma | GTX 1050 Ti / OpenGL Compatibility |

A auditoria aprova o LOD vegetal Dev5 e preserva o orçamento de performance. Os avisos FSR1 pertencem ao renderer Compatibility em headless. O log está em `CP-D5-262_LOD_AUDIT_RUNTIME.log`.
