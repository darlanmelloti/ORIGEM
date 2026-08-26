# Dev7 — Reconciliação de Evidências do Checkpoint Controlado 009

| Campo | Valor verificado |
|---|---|
| **Task ID** | `DEV7-R6-CHECKPOINT-EVIDENCE-RECONCILIATION-009` |
| **Head Dev7** | `5958a1a9175eb926131eccd4b6149976365003a5` |
| **Head remoto Dev7** | Igual ao head local |
| **Base canónica da PR #380** | `b58aadeb0406aeaaa3edf33c7a74a04d28356d67` |
| **Relação Dev7/base** | 11 commits exclusivos Dev7; 0 commits em falta da base |
| **PR #380** | Aberta, estado `CLEAN`, head idêntico a Dev7 |
| **Produção R6** | Sem modificação |
| **Comparativos R6** | Não executados |
| **CI manual/agressiva** | Não acionada |

## Objetivo e fronteiras

Este ledger consolida a validade do trabalho QA Dev7 no checkpoint controlado. Ele separa três dimensões que não podem ser confundidas: **evidência local preservada**, **estado da integração por pull request** e **decisão regional de produção**. Não cria hipótese visual, não seleciona nova variante e não altera cenas, `ForestLakeRegion.gd`, água, Player, câmara, colisores, luzes, rotas ou ancoragens.

> A captura arqueológica 003 continua rejeitada para produção. A ausência de autorização Dev6/R6 não encerra a frente Dev7: a sucessora 009 mantém a reconciliação documental ativa, mas não permite inventar uma hipótese visual ou iniciar um comparativo novo.

## Estado de integração

A PR #380 associa o head Dev7 ao mesmo head usado pelo snapshot e expõe todos os checks reportados como `SUCCESS/COMPLETED`, incluindo `ORIGEM Regional Gate`, orçamento global de luz e portas regionais R2–R6. Esta condição valida a publicação e o checkpoint, mas **não** autoriza Dev7 a realizar merge fora da coordenação nem a usar bypass, auto-merge ou force-push.

| Domínio | Estado | Interpretação operacional |
|---|---|---|
| Head local vs. remoto Dev7 | Igual | Commit preservado e publicado. |
| Dev7 vs. base canónica | `11 / 0` | A branch contém a base canónica; não há reconciliação pendente. |
| PR #380 | `OPEN`, `CLEAN` | A integração é elegível pela plataforma neste checkpoint; decisão de merge permanece de coordenação. |
| `ORIGEM Regional Gate` | `SUCCESS` | O requisito de gate foi reportado com sucesso no head da PR. |
| CI comum R2–R6 | `SUCCESS` | Estado regional comum aprovado; não justifica novo disparo de CI. |
| Produção R6 | Bloqueada | Exige hipótese, alvos e enquadramento aprovados por Dev6/R6. |

## Ledger de evidências Dev7

| Artefacto | Função de evidência | SHA-256 |
|---|---|---|
| `visual_playable_physics_baseline_001/BASELINE_REPORT.md` | Baseline runtime e física multi-rota. | `d7a9581a92fd…fecdd30` |
| `R6_ARCHAEOLOGY_MATERIAL_SILHOUETTE_AUDIT_002.md` | Auditoria QA de material/silhueta R6. | `71b6160b3ab3…e87da5` |
| `r6_archaeology_override_capture_003/VISUAL_AUDIT.md` | Evidência da variante temporária rejeitada. | `6960dfbebe9c…28d6bd` |
| `R6_ARCHAEOLOGY_EVIDENCE_REVIEW_004.md` | Reconciliação de quatro categorias e cinco vestígios. | `0d314d742dee…0629d` |
| `R6_ARCHAEOLOGY_TARGET_REGISTRY_005.md` | Registo inequívoco do conjunto de entrada. | `d3c3771936cf…60694` |
| `continuous_registry_audit_007/R6_POSTCANONICAL_REGISTRY_AUDIT_007.md` | Estabilidade pós-canonização dos 20 `NodePaths`. | `3e72948abc1f…314a98` |
| `continuous_registry_audit_007/INTEGRATION_CI_POLICY_AUDIT_008.md` | Política de integração e rastreabilidade de CI. | `39d04df3191e…10be0` |

Os hashes completos e o estado bruto da PR constam em `checkpoint_snapshot.txt`. O truncamento da tabela é apenas de leitura; a fonte de verificação é o snapshot integral.

## Invariantes locais preservadas

| Verificação | Resultado local preservado |
|---|---|
| Gate regional R6 | `PASS` |
| Orçamento global de luz | `PASS` |
| NodePaths pós-canónicos | Inalterados; 20/20 iguais ao registo 005. |
| Entrada R6 | Cinco vestígios distintos. |
| Categorias históricas 003 | Quatro prefixos correspondem a 15 meshes, não a quatro instâncias únicas. |
| Produção, luz, colisão e override no enumerador | `0`, `false`, `false`, `false`. |

## Próximos marcos seguros

| Marco | Ação permitida Dev7 | Ação proibida Dev7 |
|---|---|---|
| Publicação de commit Dev7 | Recolher referências, verificar diffs e atualizar o ledger. | Force-push, bypass ou criação de produção. |
| Alteração da base canónica | Reconciliar por merge não destrutivo e repetir gates aplicáveis. | Reescrever histórico ou descartar evidências. |
| Atualização de CI/gate | Registar estado reportado e comparar com snapshot. | Disparos repetidos/agressivos de CI. |
| Aprovação Dev6/R6 de hipótese, alvo e enquadramento | Preparar plano QA conforme escopo aprovado. | Executar teste comparativo antes dessa aprovação. |

## Conclusão

A frente Dev7 está ativa em **checkpoint controlado**. O seu trabalho atual é documental e determinístico: preservar o ledger, reconciliar mudanças de referência e manter os limites regionais explícitos. A indisponibilidade temporária de integração não invalida a QA local; ao mesmo tempo, o estado `CLEAN` da PR não substitui a decisão regional necessária para qualquer nova experimentação R6.

## Referências internas

[1] `checkpoint_snapshot.txt`, snapshot determinístico de hashes, PR e gates.

[2] `qa/dev7/DEV7_TASK_CONTRACT.md`, contrato Dev7 e fronteiras da tarefa 009.

[3] `reports/dev7/continuous_registry_audit_007/INTEGRATION_CI_POLICY_AUDIT_008.md`, política de integração e CI.
