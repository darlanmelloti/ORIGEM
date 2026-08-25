# STATUS CHECKPOINT — R1 CONTEXTUAL PROMPTS 013

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

O HUD de interação deixou de mostrar um convite genérico e agora identifica a ação que Elias pode realizar. O RayCast envia o nome do alvo no sinal `EventBus.player_interact_target_changed`, e a cena principal converte esse identificador em texto de orientação.

| Alvo | Prompt |
|---|---|
| Porta E | `[E] Abrir a porta para o vale` |
| Lareira | `[E] Repousar e guardar` |
| Mesa de Tomás | `[E] Ler a carta de Tomás` |
| Mapa da montanha | `[E] Examinar o mapa da montanha` |
| Ferramentas de Miguel | `[E] Examinar as ferramentas de Miguel` |

O sinal continua desacoplado via EventBus e preserva um prompt de reserva para qualquer interativo novo das restantes regiões.

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| Construção dos três gatilhos físicos de pistas | PASS |
| Execução de Casa Voss em headless | PASS |
| Erro fatal / script na sessão de 12 s | Nenhum |
