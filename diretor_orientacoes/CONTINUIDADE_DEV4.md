# CONTINUIDADE_DEV4 — fila automática de produção

## Estado único activo

| Campo | Valor |
|---|---|
| **STATUS_CODE** | ACTIVE_QUEUE |
| **CURRENT_BLOCK** | Pós-Ato 3 — transição para Ato 4 |
| **CURRENT_TASK** | DEV4-ACT4-001 — auditoria do primeiro handoff narrativo do Ato 4 |
| **TARGET_FILE** | `levels/CinePair49ActFourOpeningAudit.gd` |
| **TASK_OBJECTIVE** | Criar a auditoria do início do Ato 4, verificar continuidade narrativa, entrada/saída de câmara, estado físico e fronteira de escopo. |
| **EXIT_CRITERIA** | Script presente, linter Godot limpo, relatório de evidência, commit e marcador da tarefa seguinte actualizado. |
| **NEXT_TASK_ACTIVE** | DEV4-ACT4-002 — integração jogável do handoff Ato 3→Ato 4 |
| **NEXT_TARGET_FILE** | `levels/CinePair50ActFourPlayableHandoffAudit.gd` |
| **NEXT_EXIT_CRITERIA** | Travessia física, captura de gameplay, print, log, commit e activação de DEV4-ACT4-003. |
| **WAIT_ALLOWED** | `false` |
| **STOP_AFTER_REPORT** | `false` |

## Fila obrigatória

O epílogo e os créditos do Ato 3 são apenas o bloco anterior. O Dev4 deve continuar pela fila abaixo, sem esperar instrução entre as linhas:

| Ordem | Identificador | Trabalho | Transição automática |
|---:|---|---|---|
| 1 | `DEV4-ACT4-001` | Auditoria do início do Ato 4 | Iniciar `DEV4-ACT4-002` após linter e commit. |
| 2 | `DEV4-ACT4-002` | Handoff jogável Ato 3→Ato 4 | Iniciar `DEV4-ACT4-003` após gameplay e print. |
| 3 | `DEV4-ACT4-003` | Primeiro take cinematográfico do Ato 4 | Iniciar `DEV4-ACT4-004` após validação visual. |
| 4 | `DEV4-ACT4-004` | Continuidade física e narrativa do take seguinte | Iniciar `DEV4-ACT4-005` após pacote e hash. |
| 5 | `DEV4-ACT4-005` | Auditoria integrada do bloco Ato 4 | Iniciar o próximo bloco narrativo, sem aguardar resposta. |

## Contrato de cada encerramento

Um relatório só pode ser fechado quando apresentar o estado actual, a evidência executada, o commit ou diff correspondente e a próxima tarefa já marcada como `NEXT_TASK_ACTIVE`. É proibido terminar com “aguardo a próxima instrução”, “aguardo aprovação” ou equivalente.

Se o estado visual for `REJECTED_VISUAL`, a própria rejeição activa o passe seguinte. Se for `PASSED`, a fila avança para a tarefa seguinte. Em ambos os casos, o processo continua automaticamente.

## Fronteira

Este marcador é de continuidade e QA. Não autoriza alterações nas Regiões 1–6 do Dev1. O Dev4 deve trabalhar apenas nos módulos e cenas atribuídos ao bloco narrativo activo, mantendo a auditoria de escopo em cada checkpoint.
