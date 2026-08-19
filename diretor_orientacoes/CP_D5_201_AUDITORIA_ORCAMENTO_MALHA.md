# CP-D5-201 — Auditoria de orçamento de malha GTX 1050 Ti

## Resultado

A cena `MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os activos cartográficos Dev5 permaneceram dentro do orçamento técnico de malha e sem colisores importados desnecessários.

| Activo | Triângulos | Nós de malha | Materiais | Colisores |
|---|---:|---:|---:|---:|
| `bridge_stone.glb` | 252 | 1 | 2 | 0 |
| `stone_largeA.glb` | 80 | 1 | 1 | 0 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 |
| **Total** | **20.390** | **9** | **12** | **0** |

| Verificação | Resultado |
|---|---|
| Luzes dinâmicas | 0 |
| Estado | `approved` |
| Produção alterada | `false` |

A auditoria aprova o orçamento de malha para o alvo GTX 1050 Ti/OpenGL Compatibility sem modificar módulos de produção. O log está em `CP-D5-201_MESH_BUDGET_RUNTIME.log`.
