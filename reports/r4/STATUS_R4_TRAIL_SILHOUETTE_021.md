# STATUS R4 — Forest Trail Silhouette 021

**Entrega:** `DEV4-R4-FOREST-TRAIL-SILHOUETTE-021`

**Região:** R4 — Floresta Densa

**Responsável:** Dev4

**Estado:** Validada tecnicamente; pronta para publicação

## Objetivo e alteração entregue

A entrega introduz `ForestTrailSilhouette.gd` como camada R4 modular e estática. O módulo actua exclusivamente sobre **uma copa focal R4 já existente e sem colisor associado** na faixa `Z=170–176`, anterior ao conector Majestic. A transformação determinística organiza a silhueta lateral do trilho sem criar barreiras ambientais nem modificar a rota navegável.

A montagem em `ForestLakeRegion.gd` é estritamente aditiva e reutiliza o contentor `CopasFocaisDaFlorestaDensa` com as funções existentes `_path_x` e `_height_at`. Copas com colisor associado são explicitamente excluídas. Não foram modificados módulos, activos, lógica ou iluminação de R5/R6.

| Salvaguarda | Resultado da entrega 021 |
|---|---|
| Clareira Orion `Z≈126–151` | Não tocada; a faixa de trabalho é `Z=170–176` |
| Corredor e conector Majestic | Copa mantida a pelo menos `7 m` do eixo do trilho |
| Física R4 | Copas com colisor preservadas; `0` novos colisores |
| Rota, lajes, âncoras e câmara | Inalteradas |
| Luzes | `0` criadas ou modificadas pelo módulo |
| Partículas, vento, animação, shaders e pós-processamento | `0` introduzidos |
| Escopo Dev5/R5 e R6 | Preservado |

## Validação executada

O parser Godot completou sem erro de script ou de carregamento. A prova dedicada `qa/regions/verify_r4_trail_silhouette.gd` concluiu com o marcador:

> `[ORIGEM_R4_TRAIL_SILHOUETTE_OK] silhueta, corredor, clareira e física R4 preservados.`

A porta canónica `GODOT_BIN=/home/ubuntu/tools/godot tools/qa/run_regional_gate.sh R4` emitiu `[GATE:R4] PASS`. As três rotas obrigatórias também foram aprovadas: `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

Os avisos `ERROR: Parameter "material" is null.` que surgem no encerramento headless pertencem ao backend dummy de renderização após os harnesses finalizarem. Não ocorreram erros de parser, script ou falhas fatais e os marcadores de prova e gate foram emitidos com sucesso.

## Continuidade

Após a publicação desta entrega, o marcador operacional deve avançar para `DEV4-R4-FOREST-MAJESTIC-THRESHOLD-022`, mantendo as proteções da clareira Orion, do corredor e da transição Majestic, além da validação por parser, prova própria, porta R4 e as três rotas antes da publicação.
