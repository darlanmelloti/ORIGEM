# STATUS CHECKPOINT 319 — Take encadeado Casa → ponte → Arco

**Frente:** Dev1 — Regiões 1–6 / Takes 1–11.

O CP 319 adicionou um encadeamento de olhar ao prólogo. O take começa na Casa Voss e, depois de quatro segundos, conduz a câmara pelos marcos físicos da ponte positiva em `z=58` e do Arco das Ruínas. O movimento usa apenas a câmara de prólogo; não cria geometria, luzes, marcadores nem altera o controlo de Elias.

A ocultação tardia dos emissores Chronos foi prolongada até aos 30 segundos do prólogo para remover sinais técnicos que surgiam após a carga inicial. A validação Godot 4.7.1 passou e a prova de gameplay de 30 segundos em `opengl3` concluiu sem erro GDScript.

As capturas em llvmpipe são intermitentes durante o arranque, mas o frame limpo pós-aquecimento confirma a Casa à esquerda, o curso de água em profundidade e o Arco à direita sem marcadores técnicos. O **CP 320** está iniciado para produzir os frames de tempo controlado do take a partir do ambiente já aquecido e encaminhá-los à grelha CP-CINE-03 do Dev3.
