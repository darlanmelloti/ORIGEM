# Fila Contínua Cartográfica R1–R6

## Estado operativo de partida

A branch cinematográfica encontra-se publicada em `47430ed`, sem alterações pendentes. As melhorias materiais aceites mais recentes são a normalização PBR das rochas de margem R6 e o tratamento alfa dos fetos ribeirinhos, que removeram os props claros da bacia sem afectar a rota física. A entrega física Dev2 para R6→R7 ainda não está publicada na ponta conhecida `fd31a63`.

## Fila de execução sem pausa

| Prioridade | Checkpoint | Proprietário | Acção concreta | Critério de promoção |
| --- | --- | --- | --- | --- |
| 1 | CP-CARTO-54 | Dev1 / R1–R6 | Produzir uma prova macro com campos de visão sobrepostos a partir da saída QA: um enquadramento para Casa Voss→Estrada e outro para Estrada→Arco, sem mover geometrias. | Godot 4.7.1, duas capturas 1600×900 e 30 segundos de gameplay sem erro; a leitura deve separar a origem, o corredor e o marco arqueológico. |
| 2 | CP-CARTO-55 | Dev1 / R1–R6 | Se CP-54 identificar um oclusor por nó/projecção, corrigir exclusivamente esse nó fora do trilho; caso contrário, manter o mundo sem alteração. | Diferença visual positiva clara, rota física intacta, nenhuma luz nova e reversão imediata se não houver ganho. |
| 3 | CP-CARTO-56 | Dev1 + Dev2 | Assim que a ponta Dev2 superar `fd31a63`, executar `CHECKLIST_R6_R7_DEV4_CP_D2_214.md` num checkout de integração, sem editar R7 pela branch cinematográfica. | Scope guard, parser Godot, prova R6→R7 de 30 segundos e captura 1600×900. |

## Guardas obrigatórios

Não repetir os ensaios rejeitados de neblina adicional, relva procedural lateral, tonalização global de fetos, alteração de emissão/altura da água, escurecimento de lajes, recuo do núcleo ribeirinho pós-Arco ou substituição cega de copas. Antes de qualquer commit, remover `.uid` regeneráveis e validar Menu→Novo Jogo sempre que forem alterados scripts de runtime ou recursos de menu.

## Regra de continuidade

Um checkpoint aceite, revertido ou bloqueado só encerra a sua subtarefa; deve imediatamente abrir o item seguinte desta fila. A ausência de entrega Dev2 não suspende CP-CARTO-54 e CP-CARTO-55.
