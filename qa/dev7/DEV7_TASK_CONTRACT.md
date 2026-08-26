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
| `DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001` | **CONCLUÍDA** | Evidência runtime e física preservada, sem alteração de produção. |
| `DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002` | **CONCLUÍDA** | Auditoria de contraste QA concluída, sem escrita de cenas, recursos R6, luz, água, física, Player, câmara ou ancoragens. |
| `DEV7-R6-ARCHAEOLOGY-CONTRAST-PROPOSAL-003` | **CONCLUÍDA COMO ESPECIFICAÇÃO QA** | Perfil de baixo risco arquivado; nenhuma implementação de produção foi autorizada. |
| `DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003` | **CONCLUÍDA — variante rejeitada** | O par 1600×900 preservou rota, quatro luzes e transformações, mas não demonstrou ganho visual perceptível para recomendar produção. |
| `DEV7-R6-ARCHAEOLOGY-EVIDENCE-REVIEW-004` | **CONCLUÍDA — conjunto não inequívoco** | A revisão distinguiu os cinco vestígios de entrada das quatro categorias por prefixo da captura. A rejeição de produção permanece e nenhuma nova variante é autorizada. |

## Tarefa ativa única

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-TARGET-REGISTRY-005` |
| **Estado** | **ACTIVE — especificação QA documental, sem mutação de produção** |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Objetivo** | Definir um registo inequívoco de alvo e enquadramento para qualquer futura auditoria QA, usando nomes completos e `NodePath`, uma seleção declarada e invariantes de rota/luz. |
| **Permitido** | Inventário documental, matriz de identidade, contrato de câmara, lista de invariantes e roteiro de validação. |
| **Proibido** | Nova captura comparativa, nova variante de material, produção, cenas, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, ancoragem, Player ou câmara. |
| **Condição para qualquer teste futuro** | Decisão explícita de Dev6/R6 sobre a hipótese visual, conjunto exato de alvos e enquadramento; parser, `git diff --check`, gate R6, rota `forest_to_ruins` e auditoria de quatro luzes continuam obrigatórios. |
| **Handoff** | R6→R7 permanece protegido; a tarefa não antecipa conteúdo R7. |

> A tarefa ativa seguinte cria um contrato de evidência, não uma variante visual nem uma alteração de produção. O resultado rejeitado da captura 003 mantém-se vinculativo até decisão regional explícita.
