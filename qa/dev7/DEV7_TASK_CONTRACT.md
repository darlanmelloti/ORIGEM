# ORIGEM — Contrato de Trabalho Dev7

| Campo | Estado |
|---|---|
| **Responsável** | Dev7 — Direção Visual, Legibilidade Ambiental e Física Jogável |
| **Branch canónica** | `dev7/visual-playable-physics` |
| **Base canónica** | `origin/integration/r1-r6-sprint1` |
| **Contrato atualizado em** | Baseline `DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001` |
| **Tarefas ACTIVE** | **1** |

## Evidência concluída

| Task ID | Estado | Resultado |
|---|---|---|
| `DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001` | **CONCLUÍDA COM RISCO ENCAMINHADO** | Matriz runtime 1600×900 com seis percursos, grounding repetível, prova de transição de estado e diagnóstico visual preservados em `reports/dev7/visual_playable_physics_baseline_001/`. Não foram modificados ativos de produção, iluminação, colisão, ancoragens, câmara ou `levels/ForestLakeRegion.gd`. |

## Tarefa ativa única

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R4-TRAIL-READABILITY-KIT-002` |
| **Estado** | **ACTIVE — BLOQUEADA POR GATE FÍSICO** |
| **Região dona** | R4 — Floresta Densa, com integração obrigatória de Dev4. |
| **Objetivo** | Especificar e, após desbloqueio, implementar um kit modular de leitura de trilho nas margens R4 para ligar visualmente Arco→Floresta→Majestic sem alterar a rota canónica. |
| **Dependência bloqueadora** | `DEV4-R4-ARCH-FOREST-GROUNDING-RECOVERY`: `arch_to_forest` falha `QA-GROUND-01` e `CP_CARTO80_FLOOR`. |
| **Permitido** | Módulos visuais estáticos de baixo perfil, reutilizáveis e limitados à região, após a confirmação de grounding. |
| **Proibido** | Luzes novas; colisores, áreas, obstáculos, personagens ou física nova; alterações a `Player`, câmara, `CartographicAnchors.gd`, rotas canónicas ou `levels/ForestLakeRegion.gd`. |
| **Limites R4** | Clareira Orion Z≈126–151 preservada; corredor exterior mínimo de 8 m; sem parede de árvores; máximo regional de uma luz dinâmica, sem aumento. |
| **Gates de saída** | Parser Godot 4.7.1; `git diff --check`; gate R4; gates de interface R5/R6; rotas afetadas; auditoria global de luz; evidência runtime 1600×900 sem ecrã de arranque. |

> A existência de uma tarefa bloqueada não autoriza correções especulativas. Dev7 mantém a especificação modular pronta enquanto o proprietário regional resolve e comprova a recuperação física.
