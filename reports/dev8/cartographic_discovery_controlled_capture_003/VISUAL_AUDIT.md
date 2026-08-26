# Dev8 — Auditoria Visual de Descoberta Cartográfica 003

**Tarefa:** `DEV8-CARTOGRAPHIC-DISCOVERY-STATE-CONTROLLED-CAPTURE-003`
**Modo:** cena de jogo, OpenGL Compatibility e Xvfb
**Resolução:** 1920×1080
**Produção:** `production_mutations=0`

## Comparação controlada

| Estado | Evidência | Resultado visual |
|---|---|---|
| Antes da porta | `before_voss_door.png` | O mapa mostra o marcador em **Casa Voss — Origem**. O HUD pede para procurar uma saída na Casa Voss. A ligação para a Estrada do Rio não é exibida. |
| Depois da porta | `after_voss_door.png` | A ligação azul Casa Voss→Estrada do Rio torna-se visível, o marcador passa a **Estrada do Rio revelada — Rumo ao Arco**, e o HUD passa a instruir o jogador a seguir pela Estrada do Rio para encontrar o Arco das Ruínas. |

## Telemetria

O log anterior contém `[ORIGEM_MAP_R1] casa_visitada=true estrada_revelada=false`. O log posterior contém a sequência de atualização para `estrada_revelada=true` e `[ORIGEM_QA_DOOR] Casa Voss abertura=true rota=EstradaDoRio`.

## Decisão QA

> **H-DEV8-002 confirmada.** A diferença observada na baseline de `road_to_arch` é uma consequência narrativa deliberada: a rota técnica não aciona `voss_door_opened`, enquanto a abertura real da porta atualiza a consequência persistente, o mapa e o objetivo.

Não existe evidência de defeito em `CartographicAnchors.gd`, na conversão mundo→mapa ou no marcador. Não é proposta alteração de UI, âncoras, rotas, câmara, player, timeline ou produção.

## Próxima sucessão

A única sucessora deve continuar como revisão de evidência e handoff Dev1; nenhuma nova captura ou hipótese de produção é necessária sem alteração da autoridade narrativa.
