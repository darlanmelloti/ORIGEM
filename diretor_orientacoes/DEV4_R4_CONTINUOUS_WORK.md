# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-FOREST-OUTER-ENVIRONMENTAL-REVIEW-042
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

`DEV4-R4-FOREST-OUTER-RHYTHM-022` instalou `ForestOuterRhythm.gd`: oito árvores R4 existentes sem colisor associado foram ajustadas estaticamente na faixa exterior `Z=181–190`, com orientação e escala laterais subtis. A garantia cumulativa de corredor foi elevada a `≥8 m`; não foram criados nós, luzes, colisores, partículas, vento, animação, shaders, pós-processamento, interface ou conteúdo narrativo explícito. A prova `[ORIGEM_R4_OUTER_RHYTHM_OK]`, a silhueta exterior cumulativa, o parser, a porta R4 e as três rotas foram aprovados.

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
| Ritmo exterior | Fora da clareira | ≥8 m | 0 luzes e colisores | Aprovada |
| Profundidade exterior | Fora da clareira | ≥8 m | 0 luzes e colisores | Aprovada |

`DEV4-R4-FOREST-OUTER-DEPTH-023` instalou `ForestOuterDepth.gd`: três árvores R4 já aprovadas pelo ritmo exterior receberam apenas variação estática de escala e orientação. As posições-base, árvores com colisor, clareira, lajes e corredor de `≥8 m` foram preservados. A prova `[ORIGEM_R4_OUTER_DEPTH_OK]`, o parser, a porta R4 e as três rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-LATERAL-BALANCE-024` instalou `ForestOuterLateralBalance.gd`: duas árvores exteriores já aprovadas pelo ritmo, mas não usadas pela profundidade, receberam só escala e orientação estáticas. As bases espaciais e o corredor de `≥8 m` foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-VISTA-025` instalou `ForestOuterVista.gd`: duas árvores exteriores existentes, sem profundidade ou equilíbrio lateral prévios, receberam variação estática de escala e orientação. As bases e o corredor de `≥8 m` foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-RHYTHM-FINAL-026` instalou `ForestOuterRhythmFinal.gd`: duas árvores de vista exterior receberam variação estática final de escala e orientação. A clareira, as bases, o corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-CLOSURE-027` instalou `ForestOuterClosure.gd`: duas árvores exteriores da cadência final receberam variação estática de fecho. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-READABILITY-FINAL-028` instalou `ForestOuterReadabilityFinal.gd`: duas árvores exteriores do fecho receberam variação estática de legibilidade. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-OBSERVATION-029` instalou `ForestOuterObservation.gd`: duas árvores exteriores da legibilidade final receberam variação estática de observação. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-REVIEW-030` instalou `ForestOuterReview.gd`: duas árvores exteriores da observação receberam variação estática de revisão. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-CONSOLIDATION-031` instalou `ForestOuterConsolidation.gd`: duas árvores exteriores da revisão receberam variação estática de consolidação. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-STABILIZATION-032` instalou `ForestOuterStabilization.gd`: duas árvores exteriores da consolidação receberam variação estática de estabilização. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-RECONCILIATION-033` instalou `ForestOuterReconciliation.gd`: duas árvores exteriores da estabilização receberam variação estática de reconciliação. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-CONSISTENCY-034` instalou `ForestOuterConsistency.gd`: duas árvores exteriores da reconciliação receberam variação estática de consistência. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-CHECK-035` instalou `ForestOuterCheck.gd`: duas árvores exteriores da consistência receberam variação estática de verificação. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-FINALIZATION-036` instalou `ForestOuterFinalization.gd`: duas árvores exteriores da verificação receberam variação estática de finalização. Clareira, bases, corredor de `≥8 m`, luzes, colisores e rotas foram preservados; a prova própria, parser, porta R4 e rotas foram aprovados.

`DEV4-R4-FOREST-OUTER-ARCHIVE-037` consolidou a validação documental da cadeia exterior R4. A porta cumulativa e as três rotas foram aprovadas, com clareira Orion, corredor de `≥8 m`, bases, luzes e física preservados; não foi feita alteração adicional ao mundo.

`DEV4-R4-FOREST-OUTER-POSTCHECK-038` confirmou documentalmente, com a porta R4 aprovada, que não houve regressão após o arquivo. Clareira, corredor de `≥8 m`, rotas, luzes e física permanecem preservados; não foi feita alteração adicional ao mundo.

## Entrega aprovada — DEV4-R4-FOREST-OUTER-CLOSEOUT-039

O closeout documental consolidou a cadeia R4 pronta para integração futura. As portas, rotas, clareira Orion, corredor de `≥8 m`, orçamento e bundles foram verificados; não houve alteração adicional ao mundo.

## Entrega aprovada — DEV4-R4-FOREST-OUTER-PUBLISH-040

A cadeia exterior R4 foi integrada em *fast-forward* no commit remoto `5e6445b` após reconciliação segura com a integração atual. As portas R4, R5 e R6, as três rotas R4 e a auditoria global de luz foram aprovadas antes da publicação; a CI comum integrada também concluiu com sucesso. Não houve alteração adicional ao mundo nesta entrega documental.

## Entrega aprovada — DEV4-R4-FOREST-OUTER-POST-PUBLISH-REVIEW-041

A revisão documental pós-publicação confirmou o estado integrado sem regressão de clareira, corredor, rotas, luz ou física. A evidência foi preservada em `reports/r4/POST_PUBLISH_REVIEW_041.md`; não houve alteração ao mundo nesta entrega.

## Tarefa ativa — DEV4-R4-FOREST-OUTER-ENVIRONMENTAL-REVIEW-042

Auditar uma necessidade ambiental concreta da faixa exterior R4 a partir da versão integrada e da sua leitura runtime, sem iniciar alteração de produção antes de documentar o alvo espacial, o orçamento e a prova necessária.

| Critério | Obrigatório |
|---|---|
| Escopo | Auditoria e plano modular; nenhuma montagem ou novo elemento antes de evidência espacial |
| Clareira | Faixa `Z≈126–151` permanece integralmente livre |
| Corredor | Nenhum elemento a menos de 8 m do trilho físico |
| Integração R5 | Não alterar módulos, ativos, lógica, iluminação ou acampamento de Dev5 |
| Dinâmica | Zero luz, colisores, partículas, vento, pós-processamento ou animação |
| Verificação | Confirmar rota e orçamento antes de propor uma entrega R4 |

## Próxima fila reservada

`DEV4-R4-FOREST-OUTER-ENVIRONMENTAL-REVIEW-042` permanece ACTIVE até que a auditoria escolha um incremento modular R4 rastreável.
