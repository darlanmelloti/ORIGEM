# STATUS CHECKPOINT — R1 JOURNEY HUD 010

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

Foi acrescentado um HUD persistente de jornada à cena principal. A UI não cria uma missão paralela: consulta a consequência temporal já gravada pelo evento da porta E e transforma o estado narrativo em orientação legível para o jogador.

| Estado narrativo | HUD | Intenção de jogo |
|---|---|---|
| Porta E ainda fechada | “Procure uma saída na Casa Voss” | Mantém o foco no prólogo e nas pistas de Tomás |
| Porta E aberta | “Siga pela Estrada do Rio. Encontre o Arco das Ruínas.” | Conduz o primeiro passo de mundo aberto sem setas intrusivas |

O painel fica acima do HUD normal e abaixo da cartografia (`layer 11`; mapa em `layer 12`), preservando a leitura do mapa quando o jogador prime M.

## Ficheiros

| Ficheiro | Alteração |
|---|---|
| `ui/hud/JourneyObjectiveHUD.gd` | Novo HUD de jornada alimentado por `TimelineManager` e `EventBus` |
| `scripts/main.gd` | Instancia o HUD no arranque da cena principal |

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| Estado inicial do HUD | PASS — `estrada_revelada=false` |
| Abertura QA da porta E | PASS |
| Atualização do HUD pelo evento Chronos | PASS — `estrada_revelada=true` |
| Persistência da porta / Chronos / SaveManager | PASS |
| Erro fatal / script na sessão de 14 s | Nenhum |
