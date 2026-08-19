# CP-D5-014 — Auditoria real de malhas Dev5

**Cena QA:** `levels/dev5/MeshBudgetAuditPreview.tscn`  
**Motor:** Godot 4.7.1 / OpenGL Compatibility (llvmpipe no ambiente QA)  
**Tempo de sessão:** 36 segundos; captura interna gravada.  
**Luzes dinâmicas do auditor:** 0.

A cena instanciou os activos importados e percorreu todos os `MeshInstance3D`, contando faces (`get_faces() / 3`), nós de malha, slots de material e nós de colisão. Os valores abaixo são provenientes do log da sessão QA, não de estimativas de ficheiro.

| Activo | Triângulos | Nós de malha | Slots de material | Colisores importados | Decisão Dev5 |
|---|---:|---:|---:|---:|---|
| `bridge_stone.glb` | 252 | 1 | 2 | 0 | Adequado para revisão Dev1 no marco 2; adicionar colisão própria no mundo. |
| `stone_largeA.glb` | 80 | 1 | 1 | 0 | Adequado para margens, encontros ou base de marco; colisão selectiva. |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 | Adequado para composição de plano médio; colisão só se interceptar percurso. |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 | Usar como árvore focal isolada; não densificar em corredores GTX 1050 Ti sem LOD. |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 | Não usar como dispersão ampla; reservar para primeiro plano focal ou criar LOD antes de integrar. |
| **Total do lote auditado** | **20.390** | **9** | **12** | **0** | Lote adequado apenas a QA; integração deve escolher subconjuntos por marco. |

## Consequências para o mapa real

1. A proposta prioritária do marco 2 pode usar `bridge_stone.glb`, porque a malha é leve; a colisão será criada pela frente proprietária no momento da integração.
2. O marco 4 não deve receber uma parede de pinheiros PBR nem fetos densos. Árvores PBR ficam limitadas a marcos focais e a vegetação lateral deve usar activos leves ou LOD.
3. Os objectos QA Dev5 continuam a usar colisores explícitos próprios, pois os GLB/GLTF locais auditados não trazem colisores importados.
4. O auditor passa a ser pré-requisito de CP-D5-015 e de toda proposta que introduza activo novo no mundo.

## Próxima tarefa automática: CP-D5-015

Criar uma cena QA de **ponte leve com activo real** no marco 2, usando `bridge_stone.glb` e colisão própria, para comparar directamente a alternativa GLB de 252 triângulos ao candidato procedural QA antes de qualquer revisão Dev1.
