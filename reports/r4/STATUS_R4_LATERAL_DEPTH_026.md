# STATUS R4 — Forest Lateral Depth 026

**Entrega:** `DEV4-R4-FOREST-LATERAL-DEPTH-026`

**Região:** R4 — Floresta Densa

**Responsável:** Dev4

**Estado:** Validada tecnicamente; pronta para publicação

## Objetivo e alteração entregue

A entrega introduz `ForestLateralDepth.gd` como camada R4 modular e estática. O módulo actua exclusivamente sobre **uma árvore R4 já existente e sem colisor associado** na faixa `Z=170,5–174,5`, antes do conector Majestic. A transformação determinística reforça a profundidade lateral sem criar barreiras ambientais, geometria adicional ou sistemas dinâmicos.

A montagem em `ForestLakeRegion.gd` é estritamente aditiva e reutiliza o contentor `FlorestaDensaRegional` com as funções existentes `_path_x` e `_height_at`. Árvores R4 que tenham colisor associado são explicitamente excluídas e o módulo limita a transformação a uma única instância. Não foram modificados módulos, activos, lógica ou iluminação de R5/R6.

| Salvaguarda | Resultado da entrega 026 |
|---|---|
| Clareira Orion `Z≈126–151` | Não tocada; a faixa de trabalho é `Z=170,5–174,5` |
| Corredor e conector Majestic | Árvore mantida a pelo menos `10 m` do eixo do trilho |
| Física R4 | Árvores com colisor preservadas; `0` novos colisores |
| Rota, lajes, âncoras e câmara | Inalteradas |
| Luzes | `0` criadas ou modificadas pelo módulo |
| Partículas, vento, animação, shaders e pós-processamento | `0` introduzidos |
| Escopo Dev5/R5 e R6 | Preservado |

## Validação executada

O parser Godot completou sem erro de script ou de carregamento. A prova dedicada `qa/regions/verify_r4_lateral_depth.gd` concluiu com o marcador:

> `[ORIGEM_R4_LATERAL_DEPTH_OK] profundidade, corredor, conector e física R4 preservados.`

A porta canónica `GODOT_BIN=/home/ubuntu/tools/godot tools/qa/run_regional_gate.sh R4` emitiu `[GATE:R4] PASS`. As três rotas obrigatórias também foram aprovadas: `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

Os avisos `ERROR: Parameter "material" is null.` que surgem no encerramento headless pertencem ao backend dummy de renderização após os harnesses finalizarem. Não ocorreram erros de parser, script ou falhas fatais e os marcadores de prova e gate foram emitidos com sucesso.

## Continuidade

Após a publicação desta entrega, o marcador operacional deve avançar para `DEV4-R4-FOREST-ENTRY-SILHOUETTE-027`, mantendo as proteções da clareira Orion, do corredor e da transição Majestic, além da validação por parser, prova própria, porta R4 e as três rotas antes da publicação.
