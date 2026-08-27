# ORIGEM — Dev7: Atestação de CI Regular da PR #503

## Resultado do checkpoint

| Campo | Estado verificado |
|---|---|
| **PR** | [#503 — `docs(dev7): disponibilizar intake da baseline ambiental integrada`](https://github.com/darlanmelloti/ORIGEM/pull/503) |
| **Branch de origem** | `dev7/visual-playable-physics` |
| **Base** | `integration/r1-r6-sprint1` |
| **Estado da PR** | `OPEN`, não draft, `CLEAN` |
| **Workflow consultado** | `ORIGEM Regional Continuous Gate`, execução [33115534481](https://github.com/darlanmelloti/ORIGEM/actions/runs/33115534481) |
| **Estado dos checks** | Todos os checks exibidos pela PR estão `COMPLETED` com conclusão `SUCCESS`. |
| **Ação sobre CI** | Somente consulta pontual; não houve cancelamento, reexecução, despacho manual, bypass ou auto-merge. |
| **Bilhete Dev7** | `DEV7-ENVIRONMENT-BASELINE-INTAKE-024` |
| **Estado de máquina Dev7** | `READY_FOR_HYPOTHESIS — reconciliação 024 concluída; pausa controlada` |
| **Produção R6** | `production_mutations=0` |

A condição imediata definida para Dev7 — conclusão normal da CI da PR #503 — foi satisfeita pela execução regular já associada à PR. A conclusão confirma a elegibilidade técnica do conjunto submetido, incluindo a porta regional R6 e o orçamento global de luzes. Ela não muda o escopo artístico, não autoriza candidata visual e não permite qualquer mutação R6.

> A CI aprovada confirma a integridade técnica do intake e dos contratos, mas não substitui a autorização regional. Uma variante, captura comparativa ou alteração de produção R6 continua a exigir, cumulativamente, hipótese visual falsificável, alvos identificados por `NodePath` e enquadramento de prova aprovados por Dev6/R6.

## Evidência de checks concluídos

| Grupo de validação | Estado |
|---|---|
| Determinação das regiões afetadas | `SUCCESS` |
| Orçamento global de luz | `SUCCESS` |
| Portas regionais R2 a R6 | `SUCCESS` |
| Próxima tarefa ativa Dev2 a Dev6 | `SUCCESS` |
| ORIGEM Regional Gate | `SUCCESS` |

## Limites preservados

| Limite | Estado |
|---|---|
| Baseline Dev1/Dev8 | Consumida apenas por referências e intake Dev7; nenhuma captura duplicada. |
| Evidência do intake 024 | Preservada em `reports/dev7/environment_baseline_intake_024/`. |
| Água, luzes, materiais, cena e nós R6 | Sem alteração. |
| Rota, Player, câmara, física, colisores, áreas e ancoragens | Sem alteração. |
| Handoff R6→R7 | Protegido. |
| Política de integração e CI | Sem bypass, force-push, auto-merge, cancelamento ou reexecução agressiva. |

## Continuidade

A frente Dev7 permanece aberta em QA documental e de leitura. Este checkpoint não encerra o bilhete 024 nem cria tarefa sucessora cosmética. Até haver novo marco verificável, a condição operacional é `READY_FOR_HYPOTHESIS`; não existe candidata visual ou mutação R6 autorizada.
