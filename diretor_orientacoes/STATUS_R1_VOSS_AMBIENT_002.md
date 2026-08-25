# STATUS CHECKPOINT — R1 CASA VOSS AMBIENT 002

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

A Casa Voss recebeu o primeiro incremento de narrativa ambiental. A intervenção mantém a planta, o limiar, a porta E e a rota Casa Voss → Estrada do Rio. Não foi introduzido qualquer colisor novo, para preservar a passagem já validada.

| Elemento | Intenção narrativa |
|---|---|
| Diário aberto, carta e selo | Elias saiu com informação incompleta e urgência crescente |
| Mochila, mapa enrolado e punhal | O protagonista está preparado para deixar o refúgio e seguir o vale |
| Retratos de Tomás e da mãe | A casa funciona como memória familiar, não apenas cenário funcional |
| Banco, balde e lenha no alpendre | Vida doméstica plausível antes do evento de abertura |
| Poste lateral com marca azul | Direção para a Estrada do Rio e sinal precoce da assinatura Orion |
| Pulso mínimo de luz nas fontes existentes | Ambiente vivo sem acrescentar novas luzes dinâmicas |

## Ficheiros

| Ficheiro | Alteração |
|---|---|
| `levels/regions/r1/VossAmbientLife.gd` | Módulo visual isolado, sem colisão e sem dependência de UI ou jogador |
| `levels/VossHouse.gd` | Instancia o módulo depois do interior e do alpendre existentes |

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| Rota QA `voss_to_road` | PASS técnico — spawn Casa Voss–Estrada confirmado e execução de 38 s sem erro fatal |
| Contratos R1–R6 no arranque | PASS — R1 emitido com proprietário Dev1, orçamento de 3 luzes e rotas QA declaradas |

## Próximo incremento Dev1

O próximo incremento de R1 é a **abertura cinematográfica funcional da porta E**, com uma verificação visual local em GPU: a luz do interior deve enquadrar a estrada e a assinatura Orion, mas não sobre-expor o vale nem prender o jogador no limiar.
