# Dev7 — Atestação QA Pós-CI 021

| Campo | Estado atestado |
|---|---|
| **Head Dev7** | `83dbf5f5f669b150b45f8d7416a59ea98d20f39a` |
| **Base canónica** | `origin/integration/r1-r6-sprint1` no checkpoint observado |
| **PR** | #380, aberta e `CLEAN` no último marco verificado |
| **Workflow regular** | `ORIGEM Regional Continuous Gate` — concluído com sucesso |
| **Gates regionais** | R2, R3, R4, R5 e R6 — `SUCCESS` |
| **Orçamento global de luz** | `SUCCESS` |
| **Tarefas sucessoras regionais** | Dev2–Dev6 — `SUCCESS` |
| **Gate regional ORIGEM** | `SUCCESS` |
| **Produção R6 Dev7** | Nenhuma mutação |
| **Comparativo R6 Dev7** | Não executado |

## Declaração de checkpoint

A CI regular do head Dev7 reconciliado concluiu com sucesso em todas as portas de orçamento, regiões e sucessão. A validação local R6 preservada no checkpoint 020 mantém parser, gate regional, rota `forest_to_ruins`, auditoria de luz e formato Git aprovados. Nenhum resultado do workflow autoriza, por si só, hipótese visual nova, captura comparativa ou mudança de produção.

> A atestação consolida elegibilidade técnica do checkpoint, não uma decisão de direção artística. A captura 003 continua rejeitada e a região R6 continua dependente de aprovação explícita Dev6/R6 que defina hipótese falsificável, conjunto de alvos nomeados e enquadramento de prova.

## Invariantes verificados

| Invariante | Estado |
|---|---|
| Uma única tarefa Dev7 ativa | Mantida sob o contrato Dev7. |
| Referências de segurança | Preservadas antes de cada reconciliação. |
| Bypass, force-push e auto-merge | Não utilizados. |
| CI paralela/agressiva | Não utilizada. |
| Água, luz, física, colisores, rota, Player e câmara R6 | Sem escrita Dev7. |
| Handoff R6→R7 | Protegido. |

## Próximo marco permitido

Dev7 volta à cadência de verificações pontuais. A próxima ação somente poderá decorrer de uma nova publicação, reconciliação, conclusão de CI ou autorização explícita Dev6/R6. Na ausência desses marcos, não há monitor persistente.
