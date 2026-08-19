# CP-D5-086 — Auditoria de LOD de vegetação

## Resultado

O preview `VegetationLodAuditPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless e confirmou limites explícitos de vegetação para o alvo GTX 1050 Ti.

| Activo | Triângulos | Malhas | Materiais | Colisores | Memória |
|---|---:|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 | 1.211.556 bytes |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 | 31.416 bytes |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 | 6.899 bytes |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 | 9.436 bytes |

Limites confirmados: 1 árvore PBR focal, 3 árvores detalhadas de médio alcance e 8 elementos leves distantes. A telemetria confirmou zero luzes dinâmicas. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-086_VEGETATION_LOD_RUNTIME.log`.
