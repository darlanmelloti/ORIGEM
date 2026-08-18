# Recuperação Material do Workspace Dev3 — 18 de Agosto de 2026

## Resultado

A alegação de que o caminho `/home/ubuntu/work/ORIGEM_director_cinematic_polish_pass02` impedia o trabalho foi resolvida materialmente. A ferramenta `tools/qa/bootstrap_dev3_workspace.sh` recuperou a branch `feature/cine07-final` nesse destino, encontrou `project.godot` e executou a validação Godot headless.

| Verificação | Resultado |
| --- | --- |
| Workspace recuperado | `/home/ubuntu/work/ORIGEM_director_cinematic_polish_pass02` |
| Branch | `feature/cine07-final` |
| Commit recuperado | `e6f3aee` |
| Projecto Godot | `project.godot` presente |
| Validação | Headless concluída; apenas aviso não-fatal de UID com fallback por caminho para `MainMenu.gd` |

## Regra operacional

Dev3 não pode voltar a reportar a inexistência daquele caminho como bloqueio sem primeiro executar o bootstrap. Dev4 é proprietário da ferramenta de recuperação, da validação do checkout e do log de saída. Os assets históricos ausentes podem limitar uma comparação artística específica, mas não impedem o desenvolvimento ou a validação de código, câmara, interacção, colisão e evidência baseada no projecto canónico.

## Próxima tarefa material

Dev3 retoma `CINE-PAIR-14` no workspace recuperado e cria uma hipótese exterior da Garganta com commit e captura. Dev4 continua `QA-BUDGET-01` em paralelo e publica a contagem real de luzes do checkout novo; nenhum dos dois aguarda o outro para iniciar a própria prova.
