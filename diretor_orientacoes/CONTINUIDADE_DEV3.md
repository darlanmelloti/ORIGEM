# Continuidade — Dev3

- **Checkout canónico:** `/home/ubuntu/work/ORIGEM_director_cinematic_polish_pass02`
- **Branch:** `feature/cine07-final`
- **Base recuperada:** `4c99099` com `project.godot` e importação Godot 4.7.1 concluída.
- **Escopo exclusivo:** câmaras, takes, evidências visuais, critérios PBR/iluminação e composição cinematográfica. O Dev3 não altera geometria regional proprietária das frentes Dev1 ou Dev2.
- **Orçamento técnico:** máximo de 16 luzes dinâmicas visíveis; preservar transições Garganta → Interior → Garganta.

## Regra operacional obrigatória — sem paragem após checkpoint

> **Um commit, ZIP, print, relatório ou validação é evidência de auditoria; nunca é o fim de um ciclo.** Antes de publicar qualquer checkpoint, o Dev3 deve iniciar materialmente uma única tarefa seguinte: criar ou actualizar a matriz, sonda, configuração de câmara, diretório de evidência ou primeira captura dessa tarefa.

Após cada validação, o Dev3 deve consultar `diretor_orientacoes/`, seleccionar a primeira tarefa aberta dentro do seu escopo, actualizar este marcador e iniciar a primeira acção material. A falta de um anexo histórico, de um vídeo de referência ou de uma pasta presumida **não** autoriza paragem: deve executar `tools/qa/bootstrap_dev3_workspace.sh`, usar o projecto recuperado e avançar por evidência do jogo real. Dentro de uma activação, a tarefa actual deve ser executada e apenas a primeira acção material de uma única tarefa consecutiva deve ficar iniciada; não declarar execução em segundo plano após a entrega.

## CINE-PAIR-14A — Take 3 normal com matriz bloqueada

**Estado:** `EM EXECUÇÃO MATERIAL`.

A primeira acção material é obrigatória nesta activação: criar a matriz de recaptura e a sonda de evidência para o Take 3 normal, preservando os parâmetros de câmara canónicos. Em seguida, executar parser Godot, recaptura de pelo menos 30 segundos e auditoria visual do corredor Regiões 7–12 sem alterar a geometria regional.

| Ordem | Entregável | Critério |
|---|---|---|
| 1 | Matriz `CINE-PAIR-14A` e sonda no checkout Dev3 | FOV, posição, orientação, luzes visíveis e limite regional registados |
| 2 | Recaptura do Take 3 normal | ≥30 segundos de gameplay real e imagem 1600×900 |
| 3 | Auditoria R7–R12 | Sem alteração de módulos; indicar apenas lacunas visuais e proprietário |
| 4 | Próxima tarefa material iniciada | Abrir e iniciar `CINE-PAIR-14B` antes do checkpoint/push |

## Recuperação obrigatória

1. Executar `tools/qa/bootstrap_dev3_workspace.sh` antes de alegar ausência de projecto ou workspace.
2. Nunca usar falta de referência externa como razão para não validar a câmara, a matriz ou a evidência do projecto real.
3. Se o bootstrap falhar, anexar a saída, o commit pretendido e iniciar uma subtarefa documental ou de matriz no checkout canónico; nunca encerrar apenas com uma mensagem de caminho ausente.
4. Após cada prova, iniciar a tarefa seguinte antes de terminar a activação.
