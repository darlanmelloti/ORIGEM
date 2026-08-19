# CP-D5-255 — Auditoria integrada de orçamento de malha

## Resultado

A cena `MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O orçamento Dev5 permanece compatível com a meta técnica GTX 1050 Ti e não adiciona luzes dinâmicas.

| Activo | Triângulos | Nós de malha | Materiais | Colisões |
|---|---:|---:|---:|---:|
| `bridge_stone.glb` | 252 | 1 | 2 | 0 |
| `stone_largeA.glb` | 80 | 1 | 1 | 0 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 |
| **Total** | **20.390** | **9** | **12** | **0** |

| Contrato | Resultado |
|---|---:|
| Luzes dinâmicas adicionadas | 0 |
| Estado | `approved` |
| Target | GTX 1050 Ti / OpenGL Compatibility |

Os avisos FSR1 do renderer Compatibility não afectam a auditoria de orçamento. O log está em `CP-D5-255_MESH_BUDGET_RUNTIME.log`.
