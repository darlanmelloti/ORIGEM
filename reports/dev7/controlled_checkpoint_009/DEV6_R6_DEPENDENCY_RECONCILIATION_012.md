# Dev7 — Reconciliação da Dependência Dev6/R6 015

| Campo | Estado |
|---|---|
| **Publicação Dev6 verificada** | `650a6bae0f29532679b4b9814cb08cb260567cc1` |
| **Checkpoint de produção associado** | `5581765` — composição arqueológica de plano médio R6 |
| **Tarefa Dev6 ativa** | `DEV6-R6-MIDGROUND-COMPOSITION-CHECKPOINT-QA-015` |
| **Delta desde `5581765`** | Apenas orientação Dev6 e relatório QA 015 |
| **Autorização explícita para Dev7** | **Não encontrada** |
| **Produção Dev7 / comparativo R6** | **Proibidos** |

## Leitura operacional

O checkpoint Dev6/R6 015 é uma sucessora exclusivamente documental. Ele preserva a composição de plano médio já validada em `5581765` e a PR #390, mas não cria hipótese visual nova, não define conjunto de alvos para Dev7 e não aprova enquadramento de prova. A sua própria fronteira proíbe alterações de produção, repetição de CI e captura sem mudança de base.

> A publicação Dev6 015 é uma dependência de evidência, não uma autorização. Dev7 deve respeitar o checkpoint como contexto rastreável e manter `DEV7-R6-CHECKPOINT-EVIDENCE-RECONCILIATION-009` em QA documental.

## Comparação de escopo

| Dimensão | Dev6 checkpoint 015 | Consequência para Dev7 |
|---|---|---|
| Produção R6 | Proibida na tarefa ativa Dev6. | Dev7 não altera produção. |
| Evidência permitida | Referências, PR e QA já existente. | Dev7 reconcilia o ledger e não cria variante. |
| Cadência | Uma rodada por nova ponta de integração. | Dev7 só revalida em marco verificável. |
| CI | Sem cancelamento ou disparos agressivos. | Dev7 não reinicia nem duplica CI. |
| Aprovação visual Dev7 | Não declarada. | Não há comparativo, hipótese inventada ou novo enquadramento. |
| Rotas, água, luzes, física e handoff | Preservados. | Mantidos como invariantes protegidas. |

## Evidência de confirmação

A inspeção remota encontrou somente um commit após `5581765`: `docs(dev6): registrar checkpoint QA R6 015`. Os ficheiros alterados são a orientação Dev6 e `reports/r6/MIDGROUND_COMPOSITION_CHECKPOINT_QA_015.md`. A procura explícita na orientação não encontrou autorização de Dev7 para hipótese, alvo, enquadramento, comparativo ou produção.

## Próxima condição legítima

A fronteira só muda quando Dev6/R6 publicar ou comunicar explicitamente, de forma inequívoca, os três elementos seguintes: uma **hipótese visual falsificável**, um **conjunto de alvos nomeado** e um **enquadramento de prova**. Até então, a captura 003 permanece rejeitada e o checkpoint Dev7 limita-se a reconciliação de referências e evidência.

## Referências internas

[1] `origin/dev6/r6-submerged-ruins:diretor_orientacoes/DEV6_R6_CONTINUOUS_WORK.md`, tarefa ativa e fronteiras do checkpoint 015.

[2] `origin/dev6/r6-submerged-ruins:reports/r6/MIDGROUND_COMPOSITION_CHECKPOINT_QA_015.md`, evidência documental Dev6 do checkpoint.

[3] `qa/dev7/DEV7_TASK_CONTRACT.md`, tarefa QA Dev7 009 e limites de produção.
