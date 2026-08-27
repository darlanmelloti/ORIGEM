# ORIGEM — Dev7: Reconciliação Canónica e Atestação CI da PR #503 026

## Contexto do marco

| Campo | Registo |
|---|---|
| **Bilhete Dev7** | `DEV7-ENVIRONMENT-BASELINE-INTAKE-024` |
| **Estado Dev7** | `READY_FOR_HYPOTHESIS — pausa controlada; QA documental somente de leitura` |
| **PR de intake** | [#503](https://github.com/darlanmelloti/ORIGEM/pull/503), `dev7/visual-playable-physics` → `integration/r1-r6-sprint1` |
| **Estado PR consultado** | `OPEN`, não draft, `CLEAN`; checks da execução regular concluídos com `SUCCESS`. |
| **Ação CI Dev7** | Consulta pontual e atestação somente de leitura; nenhuma reexecução, cancelamento, despacho manual, bypass ou auto-merge. |
| **Commit local de atestação preservado** | `5cb52ab5` — `docs(dev7): attest regular PR 503 CI` |
| **Avanço remoto concorrente** | `c8cee19b`, contendo a integração canónica de PRs #504 e #505. |
| **Reconciliação Dev7** | Merge não destrutivo `5ca075ff`, após referência local de segurança `backup/dev7-pre-pr503-attestation-5cb52ab5`. |
| **Produção alterada por Dev7** | Não; `production_mutations=0`. |

A publicação da atestação CI encontrou avanço remoto legítimo antes do push. O commit local Dev7 foi preservado numa referência de segurança e reconciliado com merge regular, sem sobrescrita, force-push ou bypass. O avanço canónico incluía alterações de Player/câmara e recursos de NPC de outras frentes, razão pela qual Dev7 reaplicou as validações locais R6 proporcionais antes da publicação posterior.

> A conclusão regular da CI da PR #503 confirma integridade técnica do intake documental. Nem a CI aprovada, nem o merge canónico subsequente, autorizam candidata visual, material, captura comparativa ou mutação de R6.

## Validação depois da reconciliação

| Verificação | Resultado | Evidência |
|---|---|---|
| Parser Godot incluído na porta regional R6 | `PASS` | `r6_regional_gate.log` |
| Quatro luzes R6 | `PASS` | `r6_regional_gate.log` |
| Provas de leitura, composição e handoff R6→R7 | `PASS` | `r6_regional_gate.log` |
| Rotas `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` | `PASS` | `r6_regional_gate.log` |
| Orçamento global de luzes | `PASS` — 59 luzes globais visíveis, 1 simultânea na câmara, limite 16 | `light_budget/qa_budget_runtime.log` |
| `git diff --check` antes da publicação da atestação | `PASS` | Checkpoint 012 / commit `5cb52ab5` |
| Ficheiros temporários Godot | 232 `.uid` não rastreados removidos após cada execução; nenhum remanescente | Limpeza operacional, sem fontes removidas |

## Fronteiras preservadas

| Limite | Estado |
|---|---|
| Intake 024 e baseline Dev1/Dev8 | Sem recaptura; evidência apenas consumida. |
| Água, luzes, materiais, cenas e nós R6 | Sem alteração Dev7. |
| Player, câmara, física, colisores, áreas, rotas e ancoragens | Não modificados por Dev7; o delta canónico foi somente validado no âmbito R6. |
| Handoff R6→R7 | Protegido e aprovado pela porta R6. |
| Autorização artística R6 | Continua ausente. Qualquer mutação requer hipótese falsificável, alvos por `NodePath` e enquadramento de prova explícitos de Dev6/R6. |

## Continuidade

A frente Dev7 continua aberta e documental. O checkpoint CI e a reconciliação canónica são conclusões de marcos, não encerramento de responsabilidade. A próxima ação Dev7 permanece limitada ao próximo marco verificável de integração, publicação ou autorização regional completa, sem monitorização persistente entre esses marcos.
