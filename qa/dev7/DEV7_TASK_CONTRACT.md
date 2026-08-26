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
| `DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003` | **CONCLUÍDA — variante rejeitada para produção** | Par 1600×900 executado na cena de jogo; quatro overrides temporários, quatro luzes R6, rota e transformações preservadas. A diferença é tecnicamente mensurável, mas não cria ganho visual suficientemente legível. Evidência em `reports/dev7/r6_archaeology_override_capture_003/`. |

## Tarefa ativa única

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-EVIDENCE-REVIEW-004` |
| **Estado** | **ACTIVE — revisão QA contínua, sem mutação de produção** |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Objetivo** | Reconciliar a divergência entre os quatro marcos do contrato ativo e os cinco vestígios da proposta arquivada, avaliando apenas a suficiência da evidência e do enquadramento para decisão futura. |
| **Entrada obrigatória** | `reports/dev7/r6_archaeology_override_capture_003/VISUAL_AUDIT.md`, que rejeitou a variante temporária como recomendação de produção por falta de ganho visual legível. |
| **Escopo permitido em QA** | Inventário de referências, revisão de enquadramento, comparação documental e roteiro de validação; não criar uma segunda variante de produção. |
| **Limites de produção** | Nenhuma cena, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, ancoragem, Player ou câmara pode ser alterado por Dev7. |
| **Condição para eventual implementação regional** | Apenas decisão explícita posterior de Dev6/R6, com escopo de alvos inequívoco, evidência visual legível e parser Godot 4.7.1, `git diff --check`, gate R6, rota `forest_to_ruins` e auditoria R6 de quatro luzes. |
| **Handoff** | R6→R7 permanece protegido; a tarefa não antecipa conteúdo R7. |

> A tarefa ativa é uma **revisão QA contínua**, não uma espera por produção. Dev7 avança apenas com análise de evidência e fronteira de propriedade R6 preservada.
