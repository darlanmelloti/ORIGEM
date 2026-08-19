# CP-D5-203 — Auditoria LOD vegetal GTX 1050 Ti

## Resultado

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os activos vegetais foram auditados por densidade de malha, materiais e colisores, com limites claros para cada distância.

| Activo | Triângulos | Malhas | Materiais | Colisores | Bytes |
|---|---:|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 | 1.211.556 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 | 31.416 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 | 6.899 |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 | 9.436 |

| Nível | Limite |
|---|---|
| Focal | 1 árvore PBR |
| Médio | 3 árvores detalhadas |
| Distante | 8 folhagens leves |
| Luzes dinâmicas | 0 |

A regressão aprova a distribuição LOD vegetal para o alvo GTX 1050 Ti, sem colisores importados ou luzes dinâmicas adicionais. O log está em `CP-D5-203_LOD_VEGETAL_RUNTIME.log`.
