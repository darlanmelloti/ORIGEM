# CP-D5-151 — Regressão final de LOD vegetal GTX 1050 Ti

## Resultado

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O orçamento de LOD vegetal foi confirmado com limites explícitos para cada distância.

| Activo | Triângulos | Malhas | Materiais | Colisores |
|---|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 |

| Limite | Contrato |
|---|---|
| Focal | 1 árvore PBR |
| Médio | 3 árvores detalhadas |
| Distante | 8 elementos de folhagem leve |
| Luzes dinâmicas | 0 |

A regressão confirma o orçamento GTX 1050 Ti, sem colisores importados ou luzes dinâmicas adicionais. O log está em `CP-D5-151_VEGETATION_LOD_RUNTIME.log`.
