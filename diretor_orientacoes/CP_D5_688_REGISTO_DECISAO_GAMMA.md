# CP-D5-688 — Registo de Decisão Gamma

## Estado actual

O pacote Gamma está tecnicamente pronto e permanece **pendente de decisão formal**. Este registo separa evidência factual de aprovação: nenhum proprietário ou revisor é considerado aprovado sem uma decisão explícita registada.

| Decisão | Responsável | Estado inicial | Critério |
|---|---|---|---|
| Fidelidade visual R4/R5/R6 | Dev3 | Pendente | ≥85% de correspondência ao storyboard |
| Parser, QA e iluminação | Dev4 | Pendente | Parser `0`, QA contínua e ≤16 luzes |
| Ambiente e adereços | Dev6 | Pendente | Materiais, água, vida e grounding coerentes |
| Promoção regional | Owners R4/R5/R6 | Pendente | Aprovação explícita por região |
| Grounding e fronteiras | Dev5 | Validado | `≤0,05 m`, X/Z preservado, sem dependências indevidas |
| Rollback | Dev5 | Preparado | Commit separado e reversível |

## Regra operacional

Enquanto as decisões estiverem pendentes, `PROMOTION_AUTOMATIC=false` e `PRODUCTION_MODULES_CHANGED=false`. Pedidos de alteração devem gerar uma nova tarefa e nova evidência; não devem reescrever retroactivamente os resultados já publicados.

A decisão futura deve indicar responsável, escopo, commit, evidência, aprovação ou rejeição e impacto no corredor R1–R6. Até lá, os previews permanecem isolados em `levels/dev5/`.

**STATUS_CODE: DECISION_REGISTER_READY / REVIEW_PENDING / CP-D5-688.**
