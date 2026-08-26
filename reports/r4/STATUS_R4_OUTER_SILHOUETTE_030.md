# STATUS R4 — Forest Outer Silhouette 030

**Entrega:** `DEV4-R4-FOREST-OUTER-SILHOUETTE-030`

**Região:** R4 — Floresta Densa

**Responsável:** Dev4

**Estado:** Validada tecnicamente; pronta para publicação

## Objetivo e alteração entregue

A entrega introduz `ForestOuterSilhouette.gd` como camada R4 modular e estática. O módulo actua exclusivamente sobre **uma copa focal R4 já existente e sem colisor associado** na faixa `Z=192–199`, além do conector Majestic. A transformação determinística consolida a silhueta exterior sem criar barreiras vegetais, geometria adicional ou sistemas dinâmicos.

A montagem em `ForestLakeRegion.gd` é estritamente aditiva e reutiliza o contentor `CopasFocaisDaFlorestaDensa` com as funções existentes `_path_x` e `_height_at`. Copas R4 que tenham colisor associado são explicitamente excluídas e o módulo limita a transformação a uma única instância. Não foram modificados módulos, activos, lógica ou iluminação de R5/R6.

| Salvaguarda | Resultado da entrega 030 |
|---|---|
| Clareira Orion `Z≈126–151` | Não tocada; a faixa de trabalho é `Z=192–199` |
| Corredor e conector Majestic | Copa mantida a pelo menos `7 m` do eixo do trilho |
| Física R4 | Copas com colisor preservadas; `0` novos colisores |
| Rota, lajes, âncoras e câmara | Inalteradas |
| Luzes | `0` criadas ou modificadas pelo módulo |
| Partículas, vento, animação, shaders e pós-processamento | `0` introduzidos |
| Escopo Dev5/R5 e R6 | Preservado |

## Validação executada

O parser Godot completou sem erro de script ou de carregamento. A prova dedicada `qa/regions/verify_r4_outer_silhouette.gd` concluiu com o marcador:

> `[ORIGEM_R4_OUTER_SILHOUETTE_OK] silhueta, corredor, conector e física R4 preservados.`

A porta canónica `GODOT_BIN=/home/ubuntu/tools/godot tools/qa/run_regional_gate.sh R4` emitiu `[GATE:R4] PASS`. As três rotas obrigatórias também foram aprovadas: `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

Os avisos `ERROR: Parameter "material" is null.` que surgem no encerramento headless pertencem ao backend dummy de renderização após os harnesses finalizarem. Não ocorreram erros de parser, script ou falhas fatais e os marcadores de prova e gate foram emitidos com sucesso.

## Continuidade

Após a publicação desta entrega, o marcador operacional deve avançar para `DEV4-R4-FOREST-ORION-RETURN-031`, mantendo as proteções da clareira Orion, do corredor e da transição Majestic, além da validação por parser, prova própria, porta R4 e as três rotas antes da publicação.
