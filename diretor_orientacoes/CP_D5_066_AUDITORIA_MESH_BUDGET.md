# CP-D5-066 — Auditoria de orçamento de malha Dev5

## Resultado

O preview `MeshBudgetAuditPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless e inventariou cinco activos representativos de landmarks e vegetação.

| Métrica | Resultado |
|---|---:|
| Triângulos totais | 20.390 |
| Nós de malha | 9 |
| Slots de material | 12 |
| Nós de colisão | 0 |
| Luzes dinâmicas | 0 |

| Activo | Triângulos | Nós | Materiais |
|---|---:|---:|---:|
| `bridge_stone.glb` | 252 | 1 | 2 |
| `stone_largeA.glb` | 80 | 1 | 1 |
| `tree_detailed_dark.glb` | 402 | 1 | 3 |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 |

O resultado permanece compatível com o alvo GTX 1050 Ti no harness isolado: zero luzes dinâmicas e zero colisores duplicados. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-066_MESH_BUDGET_RUNTIME.log`.
