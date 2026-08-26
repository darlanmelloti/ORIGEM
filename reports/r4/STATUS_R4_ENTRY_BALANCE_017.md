# STATUS R4 — Forest Entry Balance 017

**Entrega:** `DEV4-R4-FOREST-ENTRY-BALANCE-017`

**Região:** R4 — Floresta Densa

**Responsável:** Dev4

**Estado:** Validada tecnicamente; pronta para publicação

## Objetivo e alteração entregue

A entrega introduz `ForestEntryBalance.gd` como camada R4 modular e estática. O módulo atua exclusivamente sobre **dois fetos R4 já existentes** na banda de chegada `Z=116–125,5`, anterior à clareira Orion. As duas instâncias são reposicionadas e rodadas de forma determinística para tornar a margem de entrada mais equilibrada, sem criar geometria nem nós ambientais.

A montagem em `ForestLakeRegion.gd` é estritamente aditiva: carrega o módulo R4 e reutiliza o contentor `FlorestaDensaRegional` com as funções existentes `_path_x` e `_height_at`. Não foram alterados módulos, ativos, lógica ou iluminação de R5/R6.

| Salvaguarda | Resultado da entrega 017 |
|---|---|
| Clareira Orion `Z≈126–151` | Não tocada; a banda de trabalho termina em `Z=125,5` |
| Corredor do trilho | Fetos posicionados a pelo menos `6,30 m` do eixo do trilho |
| Rota, lajes, âncoras e câmara | Inalteradas |
| Luzes | `0` criadas ou modificadas pelo módulo |
| Colisores e física | `0` criados ou modificados pelo módulo |
| Partículas, vento, animação, shaders e pós-processamento | `0` introduzidos |
| Escopo Dev5/R5 e R6 | Preservado |

## Validação executada

O parser Godot completou sem erro de script ou de carregamento. A prova dedicada `qa/regions/verify_r4_entry_balance.gd` concluiu com o marcador:

> `[ORIGEM_R4_ENTRY_BALANCE_OK] entrada, clareira Orion, corredor e física R4 preservados.`

A porta canónica `GODOT_BIN=/home/ubuntu/tools/godot tools/qa/run_regional_gate.sh R4` emitiu `[GATE:R4] PASS`. As três rotas obrigatórias também foram aprovadas: `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

Os avisos `ERROR: Parameter "material" is null.` que surgem no encerramento headless pertencem ao backend dummy de renderização após os harnesses finalizarem. Não ocorreram erros de parser, script ou falhas fatais e os marcadores de prova e gate foram emitidos com sucesso.

## Continuidade

Após a publicação desta entrega, o marcador operacional deve avançar para `DEV4-R4-FOREST-LIMINAL-DEPTH-018`, mantendo as proteções da clareira Orion e do corredor de seis metros, além da validação por parser, prova própria, porta R4 e as três rotas antes da publicação.
