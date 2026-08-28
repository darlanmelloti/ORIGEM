# ORIGEM — Contrato de Trabalho Dev7

| Campo | Estado |
|---|---|
| **Responsável** | Dev7 — Direção Visual, Legibilidade Ambiental e Física Jogável |
| **Branch canónica** | `dev7/visual-playable-physics` |
| **Base de integração** | `origin/integration/r1-r6-sprint1` |
| **Itens governados no quadro** | **1** |
| **Tarefas com execução material em curso** | **0** |
| **Estado de máquina vigente** | **READY_FOR_HYPOTHESIS — reconciliação 024 concluída; pausa controlada** |
| **Estado da frente** | **ABERTA — QA documental somente de leitura após o intake 024** |
| **Bilhete aplicável** | `DEV7-ENVIRONMENT-BASELINE-INTAKE-024` |
| **Classificação de marco** | Intake 024 validado contra a baseline Dev1/Dev8 integrada em `d3bbf0daa960` |
| **Fonte de autoridade operacional** | `diretor_orientacoes/DEV7_VISUAL_PLAYABLE_PHYSICS_CONTINUOUS_WORK.md` |
| **Modo operacional aprovado** | Verificações pontuais exclusivamente nos marcos de publicação, reconciliação e CI; não manter monitor contínuo entre tarefas. |
| **Integração** | Sem bypass administrativo e sem auto-merge; observar a política da branch base. |

> O intake 024 atingiu **READY_FOR_DEV7_RECONCILIATION** e a reconciliação documental foi publicada. O estado vigente regressa a **READY_FOR_HYPOTHESIS**: não é uma paragem técnica, mas a condição correcta quando a entrada foi consumida e nenhuma hipótese R6 autorizada existe. A frente permanece aberta, sem autorizar produção, variante visual ou nova captura R6.

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
| `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` | **CONCLUÍDA — referência disponibilizada** | A baseline Dev1 e a matriz cartográfica de seis vistas foram localizadas na integração canónica; a sucessora 024 recebeu os caminhos e limites de intake. |
| `DEV7-ENVIRONMENT-BASELINE-INTAKE-024` | **CONCLUÍDA — reconciliação documental publicada** | Intake autossuficiente aprovado como `READY_FOR_DEV7_RECONCILIATION`; decisões por rota, gate R6 e auditoria de luz preservados, sem captura ou produção nova. |

## Item governado único

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-ENVIRONMENT-BASELINE-INTAKE-024` |
| **Estado de máquina** | **READY_FOR_HYPOTHESIS — intake concluído; pausa controlada** |
| **Continuidade da frente** | O bilhete mantém a frente Dev7 aberta após o checkpoint. Não cria sucessora cosmética; aguarda somente um novo marco verificável ou autorização R6 explicitamente completa. |
| **Região dona** | R6 — Ruínas Submersas / Dev6, em coordenação de evidência com Dev1. |
| **Objetivo** | Relacionar as vistas integradas `forest_to_ruins` e `ruins_arrival` com os invariantes R6, sem duplicar a auditoria Dev1 ou a baseline cartográfica Dev8. |
| **Baseline canónica** | `qa/environment/ENVIRONMENT_PLAYER_VIEW_BASELINE_002.md` (Dev1), `reports/dev8/cartographic_fidelity_baseline_001/CAPTURE_MATRIX_001.md`, a folha de contacto e os seis PNG/logs 1600×900 em `reports/dev8/cartographic_fidelity_baseline_001/routes_1600x900/`. |
| **Referência de integração** | `d3bbf0daa960140dedff1a980c7f345c7561aacf`. |
| **Permitido** | Inventário documental de referências, artefactos QA existentes, estados de gates/CI já reportados, invariantes e classificação `PASS_LEITURA`, `OBSERVAR_SEM_PRODUCAO` ou `HIPOTESE_CAUSAL_REQUERIDA`. |
| **Proibido** | Nova captura comparativa, variante de material, produção, cenas, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, ancoragem, Player ou câmara; bypass, force-push ou novo disparo agressivo de CI. |
| **Saída do intake** | Publicada em `reports/dev7/environment_baseline_intake_024/`: `READY_FOR_DEV7_RECONCILIATION`, quatro `PASS_LEITURA` e duas `OBSERVAR_SEM_PRODUCAO`, sem `HIPOTESE_CAUSAL_REQUERIDA`. |
| **Saída para teste futuro R6** | Decisão explícita Dev6/R6 com **hipótese visual falsificável**, **conjunto de alvos por `NodePath`** e **enquadramento de prova**. Os checkpoints 015 e 016, por si só, não autorizam teste. |
| **Validação posterior obrigatória** | Parser, `git diff --check`, gate R6, rota `forest_to_ruins` e auditoria de quatro luzes, quando houver delta de teste autorizado. |
| **Handoff** | R6→R7 permanece protegido; o intake não antecipa conteúdo R7. |

> O intake 024 consome evidência já integrada e não cria variante visual nem alteração de produção. O resultado rejeitado da captura 003 mantém-se vinculativo até decisão regional explícita.

## Semântica de estado e cadência

| Estado de máquina | Significado no quadro Dev7 | Ação Dev7 permitida |
|---|---|---|
| `READY_FOR_HYPOTHESIS` | Não há hipótese R6 autorizada nem baseline publicada para processar. | Preservar o contrato e consumir o próximo marco publicado. |
| `READY_FOR_DEV7_RECONCILIATION` | Baseline integrada, estruturalmente verificável e limitada ao intake QA. | Executar somente a reconciliação documental focada nos invariantes R6. |
| `PENDING` | Resultado possível do verificador de intake quando faltar uma referência necessária. | Registar um único défice verificável; não criar captura nem corrigir produção. |
| `INVALID_INPUT` | Entrada publicada contraditória ou estruturalmente inválida. | Documentar o défice sem corrigir produção ou repetir a auditoria Dev1. |
| `ACTIVE` | Ação rastreável explicitamente limitada pelo bilhete atual. | Executar exclusivamente o escopo autorizado; nunca criar sucessora cosmética. |

Dev7 executa uma verificação pós-tarefa após 10 segundos e, então, uma consulta pontual a Git/PR/orientação. Sem novo marco verificável, não existe serviço persistente, polling infinito ou CI repetida. Novos comparativos R6 e qualquer mutação de produção permanecem proibidos até autorização explícita de Dev6/R6.
