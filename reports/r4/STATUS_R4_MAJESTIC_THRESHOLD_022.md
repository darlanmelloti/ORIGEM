# STATUS R4 — Forest Majestic Threshold 022

**Entrega:** `DEV4-R4-FOREST-MAJESTIC-THRESHOLD-022`

**Região:** R4 — Floresta Densa

**Responsável:** Dev4

**Estado:** Validada tecnicamente; pronta para publicação

## Objetivo e alteração entregue

A entrega introduz `ForestMajesticThreshold.gd` como camada R4 modular e estática. O módulo actua exclusivamente sobre **uma pedra húmida R4 já existente** na faixa `Z=182–186`, no limiar anterior ao conector Majestic. A transformação determinística clarifica a margem lateral sem modificar o conector, criar geometria ou aproximar elementos da rota navegável.

A montagem em `ForestLakeRegion.gd` é estritamente aditiva e reutiliza o contentor `RaizesPedrasESinaisP0` com as funções existentes `_path_x` e `_height_at`. Não foram modificados módulos, activos, lógica ou iluminação de R5/R6.

| Salvaguarda | Resultado da entrega 022 |
|---|---|
| Clareira Orion `Z≈126–151` | Não tocada; a faixa de trabalho é `Z=182–186` |
| Corredor e conector Majestic | Pedra mantida a pelo menos `6,62 m` do eixo do trilho |
| Rota, lajes, âncoras e câmara | Inalteradas |
| Luzes | `0` criadas ou modificadas pelo módulo |
| Colisores e física | `0` criados ou modificados pelo módulo |
| Partículas, vento, animação, shaders e pós-processamento | `0` introduzidos |
| Escopo Dev5/R5 e R6 | Preservado |

## Validação executada

O parser Godot completou sem erro de script ou de carregamento. A prova dedicada `qa/regions/verify_r4_majestic_threshold.gd` concluiu com o marcador:

> `[ORIGEM_R4_MAJESTIC_THRESHOLD_OK] limiar, conector, corredor e física R4 preservados.`

A porta canónica `GODOT_BIN=/home/ubuntu/tools/godot tools/qa/run_regional_gate.sh R4` emitiu `[GATE:R4] PASS`. As três rotas obrigatórias também foram aprovadas: `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

Os avisos `ERROR: Parameter "material" is null.` que surgem no encerramento headless pertencem ao backend dummy de renderização após os harnesses finalizarem. Não ocorreram erros de parser, script ou falhas fatais e os marcadores de prova e gate foram emitidos com sucesso.

## Continuidade

Após a publicação desta entrega, o marcador operacional deve avançar para `DEV4-R4-FOREST-RIM-BALANCE-023`, mantendo as proteções da clareira Orion, do corredor e da transição Majestic, além da validação por parser, prova própria, porta R4 e as três rotas antes da publicação.
