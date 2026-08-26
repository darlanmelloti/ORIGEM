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
| `DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002` | **CONCLUÍDA** | Inventário espacial, auditoria de contraste e simulação de override QA concluídos sem escrever cenas, recursos R6, luz, água, física, Player, câmara ou ancoragens. A auditoria documenta uma candidata modular, mas não autoriza alteração de produção. |
| `DEV7-R6-ARCHAEOLOGY-CONTRAST-PROPOSAL-003` | **CONCLUÍDA COMO ESPECIFICAÇÃO QA** | Perfil não emissivo e reversível arquivado para eventual decisão do dono R6; não existe implementação de produção nesta entrega. |

## Tarefa ativa única

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003` |
| **Estado** | **ACTIVE — execução QA contínua, sem mutação de produção** |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Objetivo** | Produzir uma comparação 16:9 em cópia de cena QA entre baseline e variante não emissiva de contraste moderado sobre quatro marcos R6 existentes. |
| **Candidata** | Override temporário de material apenas em memória QA; a especificação de cinco pilares foi arquivada como proposta, não como alteração aprovada. |
| **Escopo permitido em QA** | Mockups, captura comparativa, comparação de albedo/rugosidade, inventário de referências e roteiro de validação. |
| **Limites de produção** | Nenhuma cena, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, ancoragem, Player ou câmara pode ser alterado por Dev7. |
| **Condição para eventual implementação regional** | Somente após evidência comparativa aprovada e decisão posterior de Dev6/R6, com parser Godot 4.7.1, `git diff --check`, gate R6, rota `forest_to_ruins` e auditoria R6 de quatro luzes. |
| **Handoff** | R6→R7 permanece protegido; a tarefa não antecipa conteúdo R7. |

> A tarefa ativa é uma **captura QA contínua**, não uma espera por produção. Dev7 avança com a evidência comparativa enquanto preserva a fronteira de propriedade R6.
