# CP-D5-279 — Auditoria final de orçamento de malha

## Resultado

A cena `MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O conjunto de activos Dev5 permanece dentro do orçamento técnico para GTX 1050 Ti, sem nós de colisão ou luzes dinâmicas adicionadas.

| Activo | Triângulos | Nós de malha | Materiais | Colisões |
|---|---:|---:|---:|---:|
| `bridge_stone.glb` | 252 | 1 | 2 | 0 |
| `stone_largeA.glb` | 80 | 1 | 1 | 0 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 |
| **Total** | **20.390** | **9** | **12** | **0** |

| Contrato | Resultado |
|---|---|
| Luzes dinâmicas | 0 |
| Compatibilidade | GTX 1050 Ti / OpenGL Compatibility |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer Compatibility em headless. O log está em `CP-D5-279_MESH_BUDGET_RUNTIME.log`.
