# ORIGEM — Contrato de Trabalho Dev7

| Campo | Estado |
|---|---|
| **Responsável** | Dev7 — Direção Visual, Legibilidade Ambiental e Física Jogável |
| **Branch canónica** | `dev7/visual-playable-physics` |
| **Base de integração** | `origin/integration/r1-r6-sprint1` |
| **Item governado no quadro** | **1** |
| **Tarefas com execução material em curso** | **0** |
| **Estado de máquina vigente** | **READY_FOR_HYPOTHESIS — pausa controlada** |
| **Estado da frente** | **ABERTA — continuidade QA documental sob o bilhete 022** |
| **Bilhete aplicável** | `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` |
| **Classificação de marco** | `ORIGEM — Classificação dos Relatos Anexados 019` |
| **Fonte de autoridade operacional** | `diretor_orientacoes/DEV7_VISUAL_PLAYABLE_PHYSICS_CONTINUOUS_WORK.md` |
| **Modo operacional aprovado** | Verificações pontuais exclusivamente nos marcos de publicação, reconciliação e CI; não manter monitor contínuo entre tarefas. |
| **Integração** | Sem bypass administrativo e sem auto-merge; observar a política da branch base. |

> **READY_FOR_HYPOTHESIS** é um estado de máquina formal, não uma paragem técnica. Significa que o bilhete permanece rastreável e a fronteira QA somente de leitura está pronta, mas não existe ação material legítima até à entrada regional necessária. Não deve ser reclassificado como `ACTIVE` apenas para aparentar atividade. A frente fica **aberta**: cada verificação ou auditoria finita conclui um checkpoint, nunca encerra o bilhete 022.

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
| `DEV7-R6-POST-CI-CHECKPOINT-ATTESTATION-021` | **CONCLUÍDA — CI e PR #380 integradas** | Atestação técnica publicada e a PR #380 foi integrada na base canónica sem mutação de produção R6. |

## Item governado único

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` |
| **Estado de máquina** | **READY_FOR_HYPOTHESIS — pausa controlada; QA somente de leitura** |
| **Bilhete aplicável** | `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` |
| **Classificação vigente** | Relatos Anexados 019 — Dev7: ausência de hipótese Dev6 é legítima, sem autorização para variante ou captura duplicada. |
| **Região dona** | R6 — Ruínas Submersas / Dev6, em coordenação de evidência com Dev1. |
| **Objetivo preservado** | Consumir a direção ambiental 001 sem duplicar a auditoria Dev1, preservando os contratos R6 e preparando a reconciliação documental de qualquer baseline publicada. |
| **Capacidade imediata** | Verificar somente de modo documental um marco Dev1 publicado ou uma autorização Dev6/R6 completa; não há execução material autónoma. |
| **Continuidade** | O bilhete 022 não é encerrado por uma verificação finita. Após cada checkpoint, Dev7 selecciona a próxima auditoria QA somente de leitura compatível com os limites vigentes, sem monitor persistente. |
| **Permitido** | Inventário documental de referências, artefactos QA, estados de gates/CI já reportados, invariantes e critérios de próximo marco seguro. |
| **Proibido** | Nova captura comparativa, nova variante de material, produção, cenas, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, ancoragem, Player ou câmara; bypass, force-push ou novo disparo agressivo de CI. |
| **Saída para reconciliação documental** | Publicação Dev1 de bundle completo — relatório, seis PNGs 1600×900 e telemetria — validada pelo intake somente de leitura. |
| **Saída para teste futuro R6** | Decisão explícita de Dev6/R6 com **hipótese visual falsificável**, **conjunto de alvos nomeado por identidade/`NodePath`** e **enquadramento de prova**. Os checkpoints/revisões Dev6/R6 015 e 016, por si só, não são autorização. |
| **Validação posterior obrigatória** | Parser, `git diff --check`, gate R6, rota `forest_to_ruins` e auditoria de quatro luzes, quando a autorização e o delta aplicável existirem. |
| **Handoff** | R6→R7 permanece protegido; o bilhete não antecipa conteúdo R7. |

> A tarefa 022 não é uma variante visual nem uma alteração de produção. A auditoria de vistas pertence a Dev1; o resultado rejeitado da captura 003 mantém-se vinculativo até decisão regional explícita. A pausa controlada documenta uma condição de entrada ausente, não uma suspensão de responsabilidade.

## Semântica de estado e cadência

| Estado de máquina | Significado no quadro Dev7 | Ação Dev7 permitida |
|---|---|---|
| `READY_FOR_HYPOTHESIS` | Não há hipótese R6 autorizada nem bundle Dev1 completo para processar. | Preservar o bilhete, consumir o próximo marco publicado e manter QA somente de leitura. |
| `PENDING` | Resultado possível do verificador de intake quando o bundle Dev1 não está completo. Não substitui o estado do bilhete. | Registar apenas um défice verificável; não criar capturas nem corrigir produção. |
| `READY_FOR_DEV7_RECONCILIATION` | Bundle Dev1 completo e estruturalmente válido. Não autoriza produção R6. | Executar reconciliação documental focada nos invariantes R6. |
| `INVALID_INPUT` | Bundle publicado contraditório ou estruturalmente inválido. Não substitui o estado regional Dev6/R6. | Documentar o défice de entrada, sem corrigir produção ou repetir a auditoria Dev1. |
| `ACTIVE` | Só pode ser usado quando existir ação material explícita, permitida e rastreável. | Executar exclusivamente o escopo autorizado; nunca usar para criar uma sucessora cosmética. |

Dev7 executa verificações pontuais quando ocorrer um marco verificável de **publicação**, **reconciliação** ou **CI**. Na ausência desses marcos, não há serviço persistente entre tarefas. Esta decisão não reduz as fronteiras: novos comparativos R6 e qualquer mutação de produção permanecem proibidos até autorização explícita de Dev6/R6.
