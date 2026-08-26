# ORIGEM — Contrato de Trabalho Dev7

| Campo | Estado |
|---|---|
| **Responsável** | Dev7 — Direção Visual, Legibilidade Ambiental e Física Jogável |
| **Branch canónica** | `dev7/visual-playable-physics` |
| **Base de integração** | `origin/integration/r1-r6-sprint1` |
| **Tarefas ACTIVE** | **1** |
| **Fonte de autoridade operacional** | `diretor_orientacoes/DEV7_VISUAL_PLAYABLE_PHYSICS_CONTINUOUS_WORK.md` |
| **Modo operacional aprovado** | Verificações pontuais exclusivamente nos marcos de publicação, reconciliação e CI; não manter monitor contínuo entre tarefas. |
| **Integração** | Sem bypass administrativo e sem auto-merge; observar a política da branch base. |

## Trabalho concluído

| Task ID | Estado | Resultado |
|---|---|---|
| `DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001` | **CONCLUÍDA** | Evidência runtime e física preservada, sem alteração de produção. |
| `DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002` | **CONCLUÍDA** | Auditoria de contraste QA concluída, sem escrita de cenas, recursos R6, luz, água, física, Player, câmara ou ancoragens. |
| `DEV7-R6-ARCHAEOLOGY-CONTRAST-PROPOSAL-003` | **CONCLUÍDA COMO ESPECIFICAÇÃO QA** | Perfil de baixo risco arquivado; nenhuma implementação de produção foi autorizada. |
| `DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003` | **CONCLUÍDA — variante rejeitada** | O par 1600×900 preservou rota, quatro luzes e transformações, mas não demonstrou ganho visual perceptível para recomendar produção. |
| `DEV7-R6-ARCHAEOLOGY-EVIDENCE-REVIEW-004` | **CONCLUÍDA — conjunto não inequívoco** | A revisão distinguiu os cinco vestígios de entrada das quatro categorias por prefixo da captura. A rejeição de produção permanece e nenhuma nova variante é autorizada. |
| `DEV7-R6-ARCHAEOLOGY-TARGET-REGISTRY-005` | **CONCLUÍDA — estável pós-canonização** | O inventário de cinco vestígios de entrada e 15 meshes em quatro categorias históricas foi revalidado por `NodePath`, sem escrita de produção. |
| `DEV7-R6-CHECKPOINT-EVIDENCE-RECONCILIATION-009` | **CONCLUÍDA — checkpoint reconciliado** | Ledger, reconciliações canónicas/remotas e evidências R6 foram preservados; a última CI regular aprovada confirma a elegibilidade técnica, sem autorização de produção. |

## Tarefa ativa única

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R6-POST-CI-CHECKPOINT-ATTESTATION-021` |
| **Estado** | **ACTIVE — atestação QA documental, sem mutação de produção** |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Objetivo** | Atestar o checkpoint Dev7 após CI regular aprovada, consolidando gates, invariantes, referências e condições de próximo marco sem interpretar sucesso técnico como autorização artística. |
| **Permitido** | Inventário documental de hashes, artefactos QA, estados de gates/CI já reportados, invariantes e critérios de próximo marco seguro. |
| **Proibido** | Nova captura comparativa, nova variante de material, produção, cenas, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, ancoragem, Player ou câmara; bypass, force-push ou novo disparo agressivo de CI. |
| **Condição para qualquer teste futuro** | Decisão explícita de Dev6/R6 sobre a hipótese visual, conjunto exato de alvos e enquadramento; os checkpoints/revisões Dev6/R6 015 e 016, por si só, não são autorização. Parser, `git diff --check`, gate R6, rota `forest_to_ruins` e auditoria de quatro luzes continuam obrigatórios. |
| **Handoff** | R6→R7 permanece protegido; a tarefa não antecipa conteúdo R7. |

> A tarefa ativa seguinte é uma atestação de checkpoint, não uma variante visual nem uma alteração de produção. O resultado rejeitado da captura 003 mantém-se vinculativo até decisão regional explícita.

## Cadência de continuidade

Dev7 executa verificações pontuais quando ocorrer um marco verificável de **publicação**, **reconciliação** ou **CI**. Na ausência desses marcos, não há serviço persistente entre tarefas. Esta decisão não reduz as fronteiras: novos comparativos R6 e qualquer mutação de produção permanecem proibidos até autorização explícita de Dev6/R6.
