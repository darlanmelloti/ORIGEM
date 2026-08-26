# STATUS R4 — Forest Threshold Reading 016

**Entrega:** `DEV4-R4-FOREST-THRESHOLD-READING-016`  
**Região:** R4 — Floresta Densa  
**Responsável:** Dev4  
**Estado:** Validada tecnicamente; pronta para publicação

## Objetivo e alteração entregue

A entrega introduz `ForestThresholdReading.gd` como uma camada R4 modular e estática. O módulo atua apenas sobre **duas raízes expostas R4 já existentes** na faixa `Z=182–190`, imediatamente antes do conector Majestic. A intervenção desloca e roda essas instâncias de forma determinística para sustentar a leitura lateral do limiar, sem criar nós ambientais novos.

A montagem em `ForestLakeRegion.gd` é exclusivamente aditiva: carrega o módulo R4, passa as funções existentes `_path_x` e `_height_at` e reutiliza o contentor `RaizesPedrasESinaisP0`. Não foram alterados os módulos, ativos, lógica ou iluminação de R5/R6.

| Salvaguarda | Resultado da entrega 016 |
|---|---|
| Clareira Orion `Z≈126–151` | Não tocada; a faixa de trabalho é `Z=182–190` |
| Corredor e conector Majestic | Raízes posicionadas a pelo menos `6,44 m` do eixo do trilho |
| Rota, lajes, âncoras e câmara | Inalteradas |
| Luzes | `0` criadas ou modificadas pelo módulo |
| Colisores e física | `0` criados ou modificados pelo módulo |
| Partículas, vento, animação, shaders e pós-processamento | `0` introduzidos |
| Escopo Dev5/R5 e R6 | Preservado |

## Validação executada

O parser Godot completou sem erro de script ou de carregamento. A prova dedicada `qa/regions/verify_r4_threshold_reading.gd` concluiu com o marcador:

> `[ORIGEM_R4_THRESHOLD_OK] limiar, conector, corredor e clareira R4 preservados.`

A porta canónica `GODOT_BIN=/home/ubuntu/tools/godot tools/qa/run_regional_gate.sh R4` emitiu `[GATE:R4] PASS`. As três rotas obrigatórias também foram aprovadas: `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

Os avisos `ERROR: Parameter "material" is null.` que surgem no encerramento headless pertencem ao backend dummy de renderização após os harnesses finalizarem. Não ocorreram erros de parser, script ou falhas fatais e os marcadores de prova e gate foram emitidos com sucesso.

## Continuidade

Após a publicação desta entrega, o marcador operacional deve avançar para `DEV4-R4-FOREST-ENTRY-BALANCE-017`, mantendo a mesma política: intervenções estáticas em instâncias R4 existentes, clareira Orion protegida, corredor de seis metros livre, e validação por parser, prova própria, porta R4 e as três rotas antes da publicação.
