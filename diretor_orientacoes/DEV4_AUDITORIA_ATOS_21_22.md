# Auditoria Dev4 — Alegações dos Atos 21 e 22

A declaração recebida menciona o commit `4a47a7c` e três ficheiros `validation/a21-*.json`, mas nenhum desses artefactos existe no checkout local nem na ponta remota `feature/cine07-final` consultada nesta auditoria. O commit abreviado também não é resolvido pelo Git disponível. Por isso, a conclusão do Ato 21 e a alegada abertura material do Ato 22 são **não verificáveis** e não podem alterar o estado canónico da frente Dev4.

| Declaração | Evidência verificável encontrada | Decisão |
|---|---|---|
| Commit `4a47a7c` | Não resolvido pelo Git local/remoto | `REJECTED_UNVERIFIED` |
| `validation/a21-preparation-01.json` | Ausente | `REJECTED_UNVERIFIED` |
| `validation/a21-integration-02.json` | Ausente | `REJECTED_UNVERIFIED` |
| `validation/a21-visual-pass-03.json` | Ausente | `REJECTED_UNVERIFIED` |
| `DEV4_ORION_A22_PREPARATION_01` iniciado | Sem ficheiro, log ou alteração versionada | `PRONTA PARA RETOMA`, não iniciada |

A continuidade válida permanece na fila QA real desta branch. `QA-BUDGET-01` já possui sonda runtime, executor e prova de abertura local; `QA-STATE-01` possui a primeira acção material na sonda `tools/qa/audit_player_state_transition.gd`. Não se declara execução em segundo plano de nenhuma destas tarefas.

> A unidade de continuidade é finita: conclusão validada da tarefa actual e primeira acção material comprovada de uma única tarefa seguinte. Alegações sem commit resolvível, ficheiro ou log não substituem esse contrato.
