# STATUS CHECKPOINT — R1 MAP DISCOVERY 007

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

O mapa cartográfico agora começa pela origem real de Elias, em vez de indicar prematuramente o Arco das Ruínas. Casa Voss surge como origem visitada e o traço entre R1 e R2 só é revelado quando Elias abre a porta E.

| Estado | Mapa |
|---|---|
| Antes de abrir a porta E | Casa Voss destacada como origem; destino inicial permanece na casa; ligação para a Estrada do Rio oculta |
| Depois de abrir a porta E | Traço azul R1→R2 e rótulo “Estrada do Rio revelada” ficam visíveis; navegação normal passa a orientar Elias pela rota real |
| Regiões R3–R6 | Sem novos marcadores, ligações ou desbloqueios criados por Dev1 |

## Correção transversal

O `TimelineManager` agora insere a consequência antes de emitir `timeline_event_triggered`. Esse ajuste é necessário porque a UI consulta o estado no callback do sinal. Antes da correção, o mapa recebia o evento mas via `estrada_revelada=false` naquele frame; depois, recebe `estrada_revelada=true` imediatamente.

## Ficheiros

| Ficheiro | Alteração |
|---|---|
| `ui/menus/CartographicMapUI.gd` | Marcador de Casa Voss, ligação R1→R2 condicionada e atualização por evento Chronos |
| `core/timeline/TimelineManager.gd` | Ordem consistente entre consequência persistente e sinal de evento |

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| Mapa em QA antes da porta E | PASS — `estrada_revelada=false` |
| Abertura QA da porta E | PASS |
| Mapa após o evento temporal | PASS — `estrada_revelada=true` |
| Erro fatal / script na sessão de 14 s | Nenhum |
