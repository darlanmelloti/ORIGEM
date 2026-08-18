# Continuidade — Dev4

- **Último checkpoint material:** `QA-INPUT-01` — porta por `E`, pausa/retoma por `Esc`, cursor e retorno Orion por `E` verificados em sessões de 30 segundos; a correcção associada centraliza o atalho de pausa no controlador principal e sincroniza a árvore, o painel e o cursor.
- **Recuperação paralela concluída:** Dev4 executou `tools/qa/bootstrap_dev3_workspace.sh` e materializou o checkout Dev3 em `/home/ubuntu/work/ORIGEM_director_cinematic_polish_pass02`, branch `feature/cine07-final`, commit `e6f3aee`, com `project.godot` e validação Godot headless.
- **Próxima tarefa iniciada:** `QA-BUDGET-01` — em checkout novo, contar luzes exteriores depois de Menu Principal → Novo Jogo e provar que o orçamento permanece em no máximo 16 fontes visíveis.
- **Tarefa paralela obrigatória:** manter e validar o bootstrap Dev3 sempre que um ambiente cinematográfico não contenha a branch canónica; o resultado deve ser um checkout real ou um log de falha reproduzível.
- **Ficheiros dentro do escopo:** `tools/qa/verify_clean_package.sh`, `tools/qa/verify_input_flow.sh`, `tools/qa/bootstrap_dev3_workspace.sh`, futuras ferramentas QA, estabilidade de input, orçamento GTX 1050 Ti, transições e documentos de evidência.
- **Critério de aceitação:** logs, capturas, contagem material e commit verificável acompanham cada prova. Uma tarefa sem artefacto material não pode ser marcada como concluída.
- **Estado:** `QA-BUDGET-01 EM EXECUÇÃO — NÃO AGUARDAR DEV3 NEM DIRECÇÃO`.

## Motivo objectivo de inactividade

- **Motivo actual:** nenhum. A ausência de um caminho antigo não é dependência válida enquanto o bootstrap canónico estiver disponível.
- **Encadeamento obrigatório:** ao publicar QA-BUDGET-01, iniciar `QA-STATE-01` (persistência de saúde, stamina e orientação no retorno Orion) sem abrir DIR autónomo.
- **Proibição:** Dev4 não pode declarar CINE-PAIR concluído, esperar por workspace Dev3 nem encerrar relatório sem commit, evidência e próxima subtarefa técnica material iniciada.
