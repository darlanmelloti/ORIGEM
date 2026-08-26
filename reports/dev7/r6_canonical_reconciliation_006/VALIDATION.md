# Dev7 — Reconciliação Canónica e Validação R6 006

| Campo | Resultado |
|---|---|
| **Branch Dev7 reconciliada** | `dev7/visual-playable-physics` |
| **Head canónico integrado** | `origin/integration/r1-r6-sprint1` em `b58aadeb` |
| **Registo Dev7 preservado** | `bfafbfb3` preservado em `backup/dev7-target-registry-bfafbfb3` antes do merge |
| **Mutação de produção Dev7** | Zero |
| **Novos testes comparativos** | Zero |
| **Estado de produção R6** | Bloqueada até hipótese visual falsificável e conjunto/enquadramento aprovados por Dev6/R6 |

## Reconciliação

A branch Dev7 estava três commits à frente e dez commits atrás do head canónico. O merge não destrutivo incorporou o head da integração R1–R6 sem conflitos e sem sobrescrever as evidências Dev7, incluindo o registo `R6_ARCHAEOLOGY_TARGET_REGISTRY_005`. A referência de segurança permite recuperar o commit do registo caso uma revisão futura seja necessária.

As alterações recebidas pertencem aos fluxos canónicos R4 e R5, bem como ao controlador partilhado já integrado pelo head. Dev7 não alterou nenhuma cena, recurso R6, água, luz, física, colisão, rota, Player, câmara ou ancoragem durante esta reconciliação.

## Validações repetidas

| Verificação | Resultado | Evidência |
|---|---|---|
| Parser Godot 4.7.1 | **PASS** | `parser.log` |
| Gate regional R6 | **PASS** | `r6_regional_gate.log` |
| Rota `forest_to_ruins` | **PASS** | Marcador no gate R6, sem captura comparativa |
| Auditoria global de luz | **PASS** | `light_budget.log` |
| Formato Git contra head canónico | **PASS** | `git diff --check origin/integration/r1-r6-sprint1...HEAD` |

O gate R6 também manteve o orçamento de quatro luzes e as rotas contratuais `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`. A validação não usou `ORIGEM_QA_R6_ARCHAEOLOGY_CAPTURE`, não aplicou override de material e não salvou par baseline/variante.

> A rejeição da captura arqueológica 003 mantém-se. Este ciclo apenas reconcilia a integração e confirma que os invariantes R6 sobrevivem ao head canónico; não reabre a hipótese visual nem constitui autorização de produção.

## Continuação permitida

A próxima ação Dev7 permanece estritamente documental: conservar o registo de alvos `R6-ENTRY-VESTIGES-05` e aguardar uma formulação explícita de Dev6/R6 que defina hipótese visual, conjunto de `NodePath` e enquadramento de prova. Sem esses três elementos, ficam proibidos novas variantes comparativas e qualquer mutação de produção.

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `parser.log` | Verificação de parser após reconciliação. |
| `r6_regional_gate.log` | Gate R6, contratos, rotas e invariantes regionais. |
| `light_budget.log` | Resultado de auditoria global de luz. |
| `light_budget/` | Logs de importação e runtime da auditoria global. |
| `qa/dev7/DEV7_TASK_CONTRACT.md` | Estado da tarefa QA de registo de alvos. |
