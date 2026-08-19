# Continuidade — Dev4

- **Último checkpoint material:** `QA-INPUT-01` — porta por `E`, pausa/retoma por `Esc`, cursor e retorno Orion por `E` verificados em sessões de 30 segundos; a correcção associada centraliza o atalho de pausa no controlador principal e sincroniza a árvore, o painel e o cursor.
- **Recuperação paralela concluída:** Dev4 executou `tools/qa/bootstrap_dev3_workspace.sh` e materializou o checkout Dev3 em `/home/ubuntu/work/ORIGEM_director_cinematic_polish_pass02`, branch `feature/cine07-final`, commit `e6f3aee`, com `project.godot` e validação Godot headless.
- **Próxima tarefa iniciada:** `QA-BUDGET-01` — em checkout novo, contar luzes exteriores depois de Menu Principal → Novo Jogo e provar que o orçamento permanece em no máximo 16 fontes visíveis.
- **Tarefa paralela obrigatória:** manter e validar o bootstrap Dev3 sempre que um ambiente cinematográfico não contenha a branch canónica; o resultado deve ser um checkout real ou um log de falha reproduzível.
- **Ficheiros dentro do escopo:** `tools/qa/verify_clean_package.sh`, `tools/qa/verify_input_flow.sh`, `tools/qa/bootstrap_dev3_workspace.sh`, futuras ferramentas QA, estabilidade de input, orçamento GTX 1050 Ti, transições e documentos de evidência.
- **Critério de aceitação:** logs, capturas, contagem material e commit verificável acompanham cada prova. Uma tarefa sem artefacto material não pode ser marcada como concluída.
- **Estado:** `QA-BUDGET-01 VALIDADA LOCALMENTE — PRONTA PARA PUBLICAÇÃO` — a sonda de câmara mediu 1/16 luzes simultâneas no prólogo, com 77 luzes no inventário global. A prova de Novo Jogo correu durante 36 s sem erro de script; a publicação ainda não ocorreu nesta activação.
- **Alegações externas rejeitadas:** os Atos 21/22 e o commit `4a47a7c` não existem na ponta canónica nem possuem artefacto resolvível. Auditoria: `DEV4_AUDITORIA_ATOS_21_22.md`.
- **Retoma técnica única:** `QA-STATE-01 PRONTA PARA RETOMA` — a primeira acção material já existe em `tools/qa/audit_player_state_transition.gd`; a próxima activação deve executar a sonda no mundo, sem afirmar que ela já está em execução.
- **Protocolo canónico:** `PROTOCOLO_CONTINUIDADE_POR_ACTIVACAO_DEV4.md`. Dentro de uma activação, o commit não encerra o ciclo: o Dev4 inicia a primeira acção da próxima tarefa. Quando a activação termina, regista apenas `PRONTA PARA RETOMA`, nunca “em execução” sem processo real.

## Motivo objectivo de inactividade

- **Motivo actual:** nenhum. A ausência de um caminho antigo não é dependência válida enquanto o bootstrap canónico estiver disponível.
- **Encadeamento obrigatório:** ao publicar QA-BUDGET-01, reconhecer a primeira acção material de `QA-STATE-01` já criada e executar a sonda na activação seguinte. Nenhuma terceira tarefa é exigida; se a activação encerrar, `QA-STATE-01` mantém-se `PRONTA PARA RETOMA` com ficheiro-alvo e validação explícitos.
- **Proibição:** Dev4 não pode declarar CINE-PAIR concluído, esperar por workspace Dev3 nem encerrar relatório sem commit, evidência e próxima subtarefa técnica material iniciada. Também não pode afirmar que a subtarefa seguinte continua em execução após a activação ser encerrada; deve usar `PRONTA PARA RETOMA`.
