# CP-D5-222 — Auditoria final de orçamento de malha GTX 1050 Ti

## Resultado

A cena `MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os cinco activos auditados mantiveram o orçamento de malha sem colisores importados ou luzes dinâmicas.

| Activo | Triângulos | Nós de malha | Materiais | Colisores |
|---|---:|---:|---:|---:|
| `bridge_stone.glb` | 252 | 1 | 2 | 0 |
| `stone_largeA.glb` | 80 | 1 | 1 | 0 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 |
| **Total** | **20.390** | **9** | **12 slots** | **0** |

| Verificação | Resultado |
|---|---|
| Luzes dinâmicas | 0 |
| Colisores importados | 0 |
| Alvo | GTX 1050 Ti |
| Estado | `approved` |

A auditoria aprova o orçamento de malha Dev5 e mantém o alvo Compatibility/OpenGL sem carga adicional de colisores ou luzes. O log está em `CP-D5-222_MESH_BUDGET_RUNTIME.log`.
