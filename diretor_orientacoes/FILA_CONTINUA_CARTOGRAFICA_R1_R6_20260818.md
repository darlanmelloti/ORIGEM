# Fila Contínua Cartográfica R1–R6

## Estado operativo de partida

A branch cinematográfica encontra-se publicada em `47430ed`, sem alterações pendentes. As melhorias materiais aceites mais recentes são a normalização PBR das rochas de margem R6 e o tratamento alfa dos fetos ribeirinhos, que removeram os props claros da bacia sem afectar a rota física. A entrega física Dev2 para R6→R7 ainda não está publicada na ponta conhecida `fd31a63`.

## Fila de execução sem pausa

| Prioridade | Checkpoint | Proprietário | Acção concreta | Critério de promoção |
| --- | --- | --- | --- | --- |
| 1 | CP-CARTO-54 | Dev1 / R1–R6 | **Concluído:** prova macro Casa Voss e Estrada→Arco realizada sem alterar geometria. | Duas sessões de 30 s e capturas 1600×900 publicadas. |
| 2 | CP-CARTO-55 | Dev1 / R1–R6 | **Concluído:** o alvo z=92 foi confirmado como escala física da âncora e o harness `arco` foi retirado da intersecção de copa. | Godot e 30 s aprovados; arco completo no take QA, sem alteração de produção. |
| 3 | CP-CARTO-56 | Dev1 + Dev2 | **Aguardando publicação Dev2:** assim que a ponta Dev2 superar `fd31a63`, executar `CHECKLIST_R6_R7_DEV4_CP_D2_214.md` num checkout de integração, sem editar R7 pela branch cinematográfica. | Scope guard, parser Godot, prova R6→R7 de 30 segundos e captura 1600×900. |

## Guardas obrigatórios

Não repetir os ensaios rejeitados de neblina adicional, relva procedural lateral, tonalização global de fetos, alteração de emissão/altura da água, escurecimento de lajes, recuo do núcleo ribeirinho pós-Arco ou substituição cega de copas. Antes de qualquer commit, remover `.uid` regeneráveis e validar Menu→Novo Jogo sempre que forem alterados scripts de runtime ou recursos de menu.

## Regra de continuidade

Um checkpoint aceite, revertido ou bloqueado só encerra a sua subtarefa; deve imediatamente abrir o item seguinte desta fila. CP-CARTO-54 e CP-CARTO-55 estão concluídos. A ausência de entrega Dev2 mantém CP-CARTO-56 como dependência verificável, sem autorizar alterações nas Regiões 7–12 pela branch cinematográfica.
