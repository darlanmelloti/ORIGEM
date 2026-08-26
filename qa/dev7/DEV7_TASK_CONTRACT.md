# ORIGEM — Contrato de Trabalho Dev7

| Campo | Estado |
|---|---|
| **Responsável** | Dev7 — Direção Visual, Legibilidade Ambiental e Física Jogável |
| **Branch canónica** | `dev7/visual-playable-physics` |
| **Base de integração** | `origin/integration/r1-r6-sprint1` |
| **Tarefas ACTIVE** | **1** |
| **Fonte de autoridade operacional** | `diretor_orientacoes/DEV7_VISUAL_PLAYABLE_PHYSICS_CONTINUOUS_WORK.md` |

## Trabalho concluído

| Task ID | Estado | Resultado |
|---|---|---|
| `DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001` | **CONCLUÍDA** | Evidência runtime e física preservada em `reports/dev7/visual_playable_physics_baseline_001/`, sem alteração de produção. |
| `DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002` | **CONCLUÍDA** | Inventário espacial, auditoria de contraste e simulação de override QA concluídos sem escrever cenas, recursos R6, luz, água, física, Player, câmara ou ancoragens. A auditoria recomenda uma única candidata modular para decisão do dono R6. |

## Tarefa ativa única

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-CONTRAST-PROPOSAL-003` |
| **Estado** | **ACTIVE — AGUARDA DECISÃO EXPLÍCITA DO DONO R6 PARA PRODUÇÃO** |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Objetivo** | Preparar a proposta modular de `Perfil de Contraste de Entrada da Bacia` apenas como especificação e bundle QA, limitada aos cinco pilares R6 existentes identificados na auditoria. |
| **Candidata** | Override local de material não emissivo, reutilizando texturas arqueológicas existentes e sem alterar materiais partilhados globalmente. |
| **Escopo permitido em QA** | Mockups, comparação de albedo/rugosidade, inventário de referências e roteiro de validação. |
| **Limites de produção** | Nenhuma cena, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, ancoragem, Player ou câmara pode ser alterado por Dev7. |
| **Condição para implementação regional** | Aprovação explícita de Dev6/R6 e execução de parser Godot 4.7.1, `git diff --check`, gate R6, rota `forest_to_ruins` e auditoria R6 de quatro luzes. |
| **Handoff** | R6→R7 permanece protegido; a proposta não antecipa conteúdo R7. |

> A tarefa ativa seguinte é de **proposta**, não de implementação. Dev7 não transforma a recomendação em alteração de produção sem autorização do dono regional.
