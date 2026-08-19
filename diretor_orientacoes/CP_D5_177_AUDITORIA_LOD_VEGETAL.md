# CP-D5-177 — Auditoria LOD vegetal GTX 1050 Ti

## Resultado

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os quatro activos vegetais foram medidos com métricas reais e classificados por distância de leitura.

| Activo | Triângulos | Malhas | Materiais | Colisores importados |
|---|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 |

| Regra | Limite |
|---|---:|
| Árvore PBR focal | 1 |
| Árvores detalhadas médias | 3 |
| Folhagem leve distante | 8 |
| Luzes dinâmicas | 0 |

A auditoria aprova os limites LOD para o alvo GTX 1050 Ti/OpenGL Compatibility sem alterar produção. O log está em `CP-D5-177_VEGETATION_LOD_RUNTIME.log`.
