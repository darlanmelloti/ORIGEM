# CP-D5-133 — Auditoria de orçamento de malhas GTX 1050 Ti

## Resultado

A cena `MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O conjunto auditado manteve o orçamento técnico do alvo GTX 1050 Ti.

| Verificação | Resultado |
|---|---:|
| Triângulos totais | 20.390 |
| Nós de malha | 9 |
| Slots de material | 12 |
| Nós de colisão importados | 0 |
| Luzes dinâmicas | 0 |
| `bridge_stone.glb` | 252 triângulos |
| `stone_largeA.glb` | 80 triângulos |
| `tree_detailed_dark.glb` | 402 triângulos |
| `ez_pine_tall_pbr.glb` | 13.424 triângulos |
| `fern_02_1k.gltf` | 6.232 triângulos |

A auditoria confirma que os activos permanecem desacoplados de colisores importados e não criam luzes dinâmicas adicionais. O log está em `CP-D5-133_MESH_BUDGET_RUNTIME.log`.
