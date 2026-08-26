# Dev8 — Hipótese de Estado Narrativo Cartográfico 002

**Tarefa:** `DEV8-CARTOGRAPHIC-DISCOVERY-STATE-HYPOTHESIS-002`
**Tipo:** leitura QA e handoff para Dev1
**Produção:** `production_mutations=0`

## Pergunta observacional

Por que a captura `road_to_arch` pode mostrar Elias em uma rota técnica posterior, enquanto o mapa ainda exibe a ligação e o destino de Casa Voss?

## Evidência causal

| Camada | Evidência existente | Efeito observado |
|---|---|---|
| Gatilho físico/narrativo | `VossHouse.open_front_door()` chama `_register_front_door_discovery()`, que dispara `voss_door_opened`. | A progressão legítima é iniciada pela abertura da porta, não pelo teleporte QA de rota. |
| Timeline | `TimelineManager.trigger_event()` acrescenta `road_to_orion_revealed` antes de emitir `timeline_event_triggered`. | Consumidores de UI podem consultar a consequência imediatamente no callback. |
| Mapa | `CartographicMapUI._refresh_r1_discovery_state()` consulta `has_consequence("road_to_orion_revealed")`. Sem consequência, oculta a ligação Casa Voss→Estrada e força o destino para Casa Voss. | O mapa preserva a narrativa inicial mesmo se o jogador for movido tecnicamente. |
| Marcador de Elias | `update_player_world_position()` posiciona Elias a partir do `world_position`, mas `_update_route_destination()` retorna cedo enquanto a estrada não estiver revelada. | Elias pode ser localizado fisicamente, enquanto o destino seguinte permanece bloqueado por narrativa. |

## Comparação de evidências

| Captura | Estado de rota | Estado narrativo observado | Resultado |
|---|---|---|---|
| `road_to_arch_map_1600x900.png` | Spawn técnico Estrada–Arco. | `[ORIGEM_MAP_R1] casa_visitada=true estrada_revelada=false`. | Baseline de UI válido; destino continua Casa Voss. |
| `routes_1600x900/arch_to_forest.png` | Spawn Arco–Floresta em `(-9, 107)`. | Telemetria aponta marco 4 e destino `RUMO À FLORESTA`. | Marcador e leitura espacial são coerentes com a rota após a camada R1. |

## Hipótese causal

> **H-DEV8-002:** a diferença entre o spawn técnico de `road_to_arch` e o destino/ligação ainda ancorados em Casa Voss não é falha em `CartographicAnchors.gd` nem em `CartographicMapUI.gd`. É o resultado previsto de o harness de rota não disparar o evento persistente `voss_door_opened`, que é a única origem observada de `road_to_orion_revealed`.

A hipótese explica a evidência sem requerer mudança em âncoras, UI, rotas, player, câmara ou timeline.

## Handoff exclusivo para Dev1

Se for necessário que futuras capturas de rota R2 provem a descoberta narrativa completa, Dev1 deve decidir entre usar o harness QA de abertura da porta já existente ou fornecer um estado de timeline QA explicitamente documentado e restaurável. Dev8 não deve implementar essa alteração.

## Decisão Dev8

`HIPOTESE_CAUSAL_PARA_DEV1` — sem ação de produção Dev8. A cartografia mantém-se em observação e a descoberta narrativa deve ser validada pelo proprietário Dev1.
