# Dev8 — Matriz de Estado Narrativo do Mapa

| Estado | Origem | Efeito cartográfico observado | Interpretação Dev8 |
|---|---|---|---|
| Porta Casa Voss ainda não aberta | `TimelineManager.has_consequence("road_to_orion_revealed") == false` | O mapa mantém `CASA VOSS — ORIGEM` e não mostra a ligação Casa→Estrada. | Estado inicial correcto; não é defeito de `map_texture_position`. |
| Evento `voss_door_opened` disparado | `VossHouse.gd` chama `TimelineManager.trigger_event("voss_door_opened")`. | A consequência `road_to_orion_revealed` passa a existir e a UI recalcula a descoberta. | Estado necessário para testar o marcador de rota depois da Casa. |
| Mapa aberto em QA | `ORIGEM_QA_OPEN_MAP=1` ativa a interface no arranque. | A UI fica visível, mas não injeta consequências narrativas. | Abrir o mapa não equivale a progredir a história. |
| Rota QA `road_to_arch` | `TempleLevel.gd` posiciona Elias na Estrada. | A posição física pode estar na Estrada enquanto a UI conserva o estado inicial. | Cobertura de QA incompleta, não incoerência de produção comprovada. |

## Decisão

A próxima captura Dev8 que avaliar destino e ligação deve nascer de um estado narrativo real, ou de um harness QA aprovado por Dev1 que reproduza **somente** a consequência de descoberta sem editar a UI ou a autoridade cartográfica. Dev8 não cria esse harness nem modifica `TimelineManager`, `VossHouse.gd`, `CartographicMapUI.gd` ou `CartographicAnchors.gd`.
