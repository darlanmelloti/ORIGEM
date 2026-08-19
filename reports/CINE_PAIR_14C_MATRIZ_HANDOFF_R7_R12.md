# CINE-PAIR-14C — Matriz de Handoff R7–R12

## Estado operacional

**EM EXECUÇÃO MATERIAL.** Esta matriz foi iniciada no mesmo ciclo que a fila CINE-PAIR-14B. Não depende de retorno dos proprietários Dev1/Dev2.

## Contrato cinematográfico

| Critério | Regra |
|---|---|
| Escopo | Câmara, matriz, evidência e auditoria; sem editar módulos R7–R12 |
| Posição | Entrada de handoff R7, sem deslocar âncoras cartográficas |
| Lente | FOV canónico, sem usar reenquadramento para esconder lacunas |
| Duração | Pelo menos 30 segundos de gameplay real |
| Evidência | Imagem 1600×900 no segundo 30 |
| Luzes | Contar apenas luzes visíveis na câmara; limite operacional ≤16 |

## Pré-auditoria já materializada

A sonda inicial detectou 18 luzes visíveis quando executada na cena principal sem posicionar a câmara do handoff. Esse valor não é aceite como avaliação R7–R12; a tarefa actual deve posicionar a câmara no handoff antes de contar luzes e emitir a classificação correcta.

## Próxima operação

1. Criar uma rota QA de recaptura no handoff R7 em `RegionalCinematicDirector.gd` ou evidência Dev3, sem tocar em geometria.
2. Executar a captura válida e a contagem de luzes no ponto de vista R7.
3. Abrir materialmente `CINE-PAIR-14D` com a matriz de retorno de resultados antes de publicar o checkpoint.
