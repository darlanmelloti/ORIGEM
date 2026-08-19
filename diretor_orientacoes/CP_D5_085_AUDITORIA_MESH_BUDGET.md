# CP-D5-085 — Auditoria de orçamento de malha

## Resultado

O preview `MeshBudgetAuditPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless e confirmou um orçamento compatível com o alvo GTX 1050 Ti.

| Activo | Triângulos | Nós de malha | Materiais | Colisores |
|---|---:|---:|---:|---:|
| `bridge_stone.glb` | 252 | 1 | 2 | 0 |
| `stone_largeA.glb` | 80 | 1 | 1 | 0 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 |
| **Total** | **20.390** | **9** | **12** | **0** |

A telemetria confirmou zero luzes dinâmicas. A advertência FSR1 pertence ao renderer Compatibility local. O preview não altera módulos de produção.

O log está em `CP-D5-085_MESH_BUDGET_RUNTIME.log`.
