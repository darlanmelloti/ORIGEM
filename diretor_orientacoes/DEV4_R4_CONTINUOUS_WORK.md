# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-FOREST-MAJESTIC-APPROACH-029
owner: Dev4
branch: dev4/r4-dense-forest
```

## Base oficial e fronteira

A base de trabalho é o repositório oficial do ORIGEM, branch canónica `dev4/r4-dense-forest`, sincronizada com `integration/r1-r6-sprint1`. A R4 mantém a âncora cartográfica `(-9, 116)`, ocupa a transição entre o Arco e o Acampamento Majestic e conserva as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

O conteúdo Dev4 novo continua modular sob `levels/regions/r4/`. A montagem mínima em `levels/ForestLakeRegion.gd` é permitida apenas para instalar módulos R4 aditivos; não editar âncoras, `RiverRoadJourney.gd`, módulos R1–R3/R5–R6 ou sistemas transversais protegidos.

## Entregas concluídas

`DEV4-R4-MIST-LAYER-002` instalou `R4CamadaNeblinaLocal` com variação de material subtil, sem geometria, volume de neblina, partículas, pós-processamento ou luzes. A clareira Orion em `Z≈126–151` mantém peso zero e leitura livre.

`DEV4-R4-ORION-CLEARING-LORE-003` instalou `ForestClearingLore.gd`: três vestígios laterais e nove pedras gastas fora do corredor, sem interface, texto, eventos, colisores ou luzes.

`DEV4-R4-CANOPY-CADENCE-004` instalou `ForestCanopyCadence.gd`: 26 copas laterais existentes receberam variação estática; 20 copas na faixa Orion foram preservadas; não foram criadas luzes ou colisores.

`DEV4-R4-UNDERSTORY-EDGE-005` instalou `ForestUnderstoryEdge.gd`: doze elementos existentes do sub-bosque foram reposicionados lateralmente com distância mínima validada de 6,16 m ao trilho. Não houve novos nós, malhas, luzes, colisores, partículas, vento, animação, shaders ou pós-processamento.

`DEV4-R4-ORION-VISTA-FRAMING-006` instalou `ForestOrionVistaFraming.gd`: seis copas laterais existentes foram ajustadas para uma revelação gradual de Orion; duas copas na faixa protegida permaneceram sem modulação. Não foram criadas malhas, materiais, luzes, colisores, animação, partículas, vento, shaders, pós-processamento, interface ou alterações de câmara. A prova `[ORIGEM_R4_VISTA_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-APPROACH-RHYTHM-007` instalou `ForestApproachRhythm.gd`: 24 árvores, copas ou fetos R4 existentes foram reposicionados estaticamente entre `Z=152–170`; 23 elementos na faixa Orion foram preservados. A fronteira de transformação encerra antes do conector Majestic e não altera qualquer módulo Dev5. A prova `[ORIGEM_R4_APPROACH_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-MAJESTIC-EDGE-BALANCE-008` instalou `ForestMajesticEdgeBalance.gd`: três fetos ou copas focais R4 existentes foram ajustados na faixa `Z=165–174` para suavizar a borda antes de Majestic. Não foram modificados módulos, ativos, lógica, física ou iluminação Dev5. A prova `[ORIGEM_R4_EDGE_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-SILHOUETTE-CONTINUITY-009` instalou `ForestSilhouetteContinuity.gd`: oito árvores ou copas R4 sem colisores associados foram ajustadas na faixa `Z=152–164`; seis instâncias com colisores foram preservadas. A prova `[ORIGEM_R4_SILHOUETTE_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-DEPTH-BALANCE-010` instalou `ForestDepthBalance.gd`: três fetos R4 existentes foram reorganizados em dois planos laterais estáticos na faixa `Z=153–169`; nenhum nó, luz, colisão, partícula, vento, shader ou pós-processamento foi criado. A prova `[ORIGEM_R4_DEPTH_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-ORION-APPROACH-READABILITY-011` instalou `ForestApproachReadability.gd`: quatro raízes R4 existentes foram ajustadas nas bordas laterais da faixa `Z=152–170` para reforçar a direção ambiental sem texto, interface ou eventos. A prova `[ORIGEM_R4_READABILITY_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-TRAIL-PACING-012` instalou `ForestTrailPacing.gd`: duas pedras húmidas R4 existentes foram alternadas nas bordas da faixa `Z=152–170`, sem alterar lajes, rota, câmara, física ou módulos Dev5. A prova `[ORIGEM_R4_PACING_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-MARGIN-CONTINUITY-013` instalou `ForestMarginContinuity.gd`: duas raízes R4 existentes foram reorganizadas na margem exterior entre `Z=171–181`, sem criar nós, luzes, colisores, partículas, vento, shaders ou pós-processamento. A prova `[ORIGEM_R4_MARGIN_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-APPROACH-COMPOSITION-014` instalou `ForestApproachComposition.gd`: duas copas focais R4 sem colisores associados foram equilibradas entre `Z=152–174`; uma copa com colisor foi preservada. A prova `[ORIGEM_R4_COMPOSITION_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-EDGE-RHYTHM-015` instalou `ForestEdgeRhythm.gd`: uma pedra húmida R4 existente foi ajustada entre `Z=174–182` para manter a leitura lateral junto ao conector Majestic. A prova `[ORIGEM_R4_EDGE_RHYTHM_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-THRESHOLD-READING-016` instalou `ForestThresholdReading.gd`: duas raízes R4 existentes foram ajustadas entre `Z=182–190` antes do conector Majestic. A prova `[ORIGEM_R4_THRESHOLD_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-ENTRY-BALANCE-017` instalou `ForestEntryBalance.gd`: dois fetos R4 existentes foram ajustados entre `Z=116–125,5`, antes da clareira Orion. A prova `[ORIGEM_R4_ENTRY_BALANCE_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-LIMINAL-DEPTH-018` instalou `ForestLiminalDepth.gd`: uma árvore R4 existente sem colisor associado foi ajustada entre `Z=175–181` para reforçar a profundidade lateral antes do conector Majestic. A prova `[ORIGEM_R4_LIMINAL_DEPTH_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-MARGIN-019` instalou `ForestOuterMargin.gd`: sete árvores R4 existentes sem colisor associado foram ajustadas entre `Z=184–190` para refinar a margem exterior posterior ao conector Majestic. A prova `[ORIGEM_R4_OUTER_MARGIN_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-CANOPY-EDGE-020` instalou `ForestCanopyEdge.gd`: uma copa focal R4 existente sem colisor associado foi modulada entre `Z=192–199` para refinar a borda exterior sem criar parede vegetal. A prova `[ORIGEM_R4_CANOPY_EDGE_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-TRAIL-SILHOUETTE-021` instalou `ForestTrailSilhouette.gd`: uma copa focal R4 existente sem colisor associado foi ajustada entre `Z=170–176` para organizar a silhueta lateral do trilho. A prova `[ORIGEM_R4_TRAIL_SILHOUETTE_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-MAJESTIC-THRESHOLD-022` instalou `ForestMajesticThreshold.gd`: uma pedra húmida R4 existente foi ajustada entre `Z=182–186` para clarificar o limiar antes do conector Majestic. A prova `[ORIGEM_R4_MAJESTIC_THRESHOLD_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-RIM-BALANCE-023` instalou `ForestRimBalance.gd`: seis árvores R4 existentes sem colisor associado foram equilibradas entre `Z=165–170` para manter a borda lateral aberta. A prova `[ORIGEM_R4_RIM_BALANCE_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-RHYTHM-024` instalou `ForestOuterRhythm.gd`: uma árvore R4 existente sem colisor associado foi ajustada entre `Z=187,5–192` para modular o ritmo exterior. A prova `[ORIGEM_R4_OUTER_RHYTHM_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-RETURN-READING-025` instalou `ForestReturnReading.gd`: uma árvore R4 existente sem colisor associado foi ajustada entre `Z=184–190` para reforçar a leitura de retorno. A prova `[ORIGEM_R4_RETURN_READING_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-LATERAL-DEPTH-026` instalou `ForestLateralDepth.gd`: uma árvore R4 existente sem colisor associado foi ajustada entre `Z=170,5–174,5` para aprofundar a leitura lateral. A prova `[ORIGEM_R4_LATERAL_DEPTH_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-ENTRY-SILHOUETTE-027` instalou `ForestEntrySilhouette.gd`: uma árvore R4 existente sem colisor associado foi ajustada entre `Z=112–125` para reforçar a silhueta de entrada sem invadir Orion. A prova `[ORIGEM_R4_ENTRY_SILHOUETTE_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-ORION-MARGIN-028` instalou `ForestOrionMargin.gd`: uma árvore R4 existente sem colisor associado foi ajustada entre `Z=152–158` para modular a margem posterior a Orion sem invadir a clareira. A prova `[ORIGEM_R4_ORION_MARGIN_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

| Entrega | Clareira Orion | Corredor | Luz e física | QA |
|---|---|---|---|---|
| Neblina | Peso zero em Z≈126–151 | Preservado | 0 luzes novas | Aprovada |
| Lore | 3 conjuntos laterais | Livre | 0 luzes e colisores | Aprovada |
| Copas | 20 copas protegidas | ≥6 m | 0 luzes e colisores | Aprovada |
| Sub-bosque | Sem elementos em Z=126–151 | ≥6,16 m | 0 luzes e colisores | Aprovada |
| Vista Orion | 2 copas protegidas | ≥6 m | 0 luzes e colisores | Aprovada |
| Aproximação Majestic | 23 elementos protegidos | ≥6 m | 0 luzes e colisores | Aprovada |
| Borda Majestic | Fora da clareira | ≥6 m | 0 luzes e colisores | Aprovada |
| Silhuetas | Clareira e física preservadas | ≥6 m | 0 luzes e colisores | Aprovada |
| Profundidade | Fora da clareira | ≥6 m | 0 luzes e colisores | Aprovada |
| Legibilidade | Fora da clareira | ≥6 m | 0 luzes e colisores | Aprovada |
| Ritmo do trilho | Lajes preservadas | ≥6 m | 0 luzes e colisores | Aprovada |
| Margem ambiental | Fora da clareira | ≥6 m | 0 luzes e colisores | Aprovada |
| Composição | Física preservada | ≥6 m | 0 luzes e colisores | Aprovada |
| Cadência de borda | Conector preservado | ≥6 m | 0 luzes e colisores | Aprovada |
| Leitura do limiar | Conector preservado | ≥6 m | 0 luzes e colisores | Aprovada |
| Equilíbrio da entrada | Antes da clareira | ≥6 m | 0 luzes e colisores | Aprovada |
| Profundidade liminar | Fora da clareira | ≥9 m | 0 luzes e colisores | Aprovada |
| Margem exterior | Fora da clareira | ≥10 m | 0 luzes e colisores | Aprovada |
| Borda das copas | Fora da clareira | ≥7 m | 0 luzes e colisores | Aprovada |
| Silhueta lateral | Fora da clareira | ≥7 m | 0 luzes e colisores | Aprovada |
| Limiar Majestic | Conector preservado | ≥6,4 m | 0 luzes e colisores | Aprovada |
| Equilíbrio da borda | Fora da clareira | ≥10 m | 0 luzes e colisores | Aprovada |
| Ritmo exterior | Fora da clareira | ≥11 m | 0 luzes e colisores | Aprovada |
| Leitura de retorno | Fora da clareira | ≥11 m | 0 luzes e colisores | Aprovada |
| Profundidade lateral | Fora da clareira | ≥10 m | 0 luzes e colisores | Aprovada |
| Silhueta de entrada | Antes da clareira | ≥10 m | 0 luzes e colisores | Aprovada |
| Margem Orion | Após a clareira | ≥10 m | 0 luzes e colisores | Aprovada |

## Tarefa ativa — DEV4-R4-FOREST-MAJESTIC-APPROACH-029

Refinar a **aproximação R4 a Majestic** com transformações estáticas de instâncias ambientais existentes, sem criar paredes vegetais ou aproximar elementos do trilho e do conector Majestic. A tarefa deve preservar rota, câmara, lajes, física, módulos Dev5, iluminação, partículas, vento, pós-processamento, interface e narrativa explícita.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r4/`, montagem mínima e QA R4 |
| Clareira | Faixa `Z≈126–151` permanece integralmente livre |
| Corredor | Nenhum elemento a menos de 6 m do trilho físico |
| Integração R5 | Não alterar módulos, ativos, lógica, iluminação ou acampamento de Dev5 |
| Dinâmica | Zero luz, colisores, partículas, vento, pós-processamento ou animação |
| Verificação | Parser, prova própria, porta R4 e três rotas antes de publicar |

## Próxima fila reservada

`DEV4-R4-FOREST-OUTER-SILHOUETTE-030` deverá consolidar a silhueta exterior R4 sem modificar a rota, a câmara ou os limites regionais.
