# Take 7 — Ciclo 1

O parser Godot 4.7.1 passou e o processo permaneceu vivo durante 30 segundos. O print falha visualmente: a câmara está dentro ou atrás de uma massa rochosa da câmara aberta, sem leitura do Cubo de Orion, praça ciclópica ou presença Kharu. A próxima correção deve mover a câmara para um ponto exterior seguro, em `x` positivo e `z` mais recuado, olhando para o centro do santuário. O código do Take 5 e da zona ribeirinha não será alterado.

## Ciclos 2–3

A órbita exterior eliminou o ecrã de parede total e revelou parte da praça, mas o frame continua dominado por uma coluna rochosa em primeiro plano. O Cubo de Orion ainda não tem leitura limpa. A próxima correção deve usar um eixo de aproximação com `x` e `z` fora do anel e, se necessário, reduzir/remover apenas a coluna que bloqueia a linha de visão do Take 7; não serão alterados Take 5, rio ou canyon do Take 6.

## Ciclo 4

A aproximação pelo corredor limpo removeu a grande oclusão e revelou a praça ciclópica, o anel de arena, as fontes azuis, a montanha ao fundo e o Cubo de Orion. O Cubo, contudo, está completamente branco por excesso de emissão no material partilhado `resonance`. O próximo passe deve atribuir ao Cubo um material próprio azul profundo com emissão controlada, mantendo a leitura monumental e sem tocar nos blocos congelados.

## Ciclo 5 e comparação de gameplay

O print final e os frames de 03 s/29 s mostram o Cubo de Orion em ciano controlado, a praça ciclópica, o anel central, as montanhas e uma variação lateral subtil da câmara ao longo dos 30 segundos. Não há ecrã preto nem clipping dominante. Algumas fontes antigas permanecem brancas no perímetro; não impedem a leitura do Cubo, mas devem ser substituídas por materiais ciano num passe de produção posterior.
