# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-CARTOGRAPHIC-INLET-MODULE-BASELINE-CAPTURE-053
owner: Dev4
branch: dev4/r4-dense-forest
```

## Base oficial e fronteira

A base de trabalho é o repositório oficial do ORIGEM, a partir de `integration/r1-r6-sprint1`. A branch canónica Dev4 continua `dev4/r4-dense-forest`; esta revisão documental foi publicada por uma branch auxiliar derivada da integração. A branch canónica não é fonte de produção até ser reconciliada separadamente, pois contém trabalho concorrente não reauditorado. A R4 mantém a âncora cartográfica `(-9, 116)`, ocupa a transição entre o Arco e o Acampamento Majestic e conserva as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

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

## Entrega aprovada — DEV4-R4-FOREST-OUTER-ENVIRONMENTAL-REVIEW-042

A auditoria confirmou que os elementos exteriores existentes já receberam transformações estáticas extensas e que uma nova variação sem evidência runtime criaria risco cumulativo sem ganho demonstrável. A evidência foi preservada em `reports/r4/ENVIRONMENTAL_REVIEW_042.md`; não houve alteração de produção.

## Entrega aprovada — DEV4-R4-RUNTIME-COMPOSITION-CAPTURE-043

As capturas pós-carregamento das duas rotas R4 confirmaram composição runtime e revelaram uma superfície opaca clara na aproximação `arch_to_forest`. A evidência foi preservada em `reports/r4/RUNTIME_COMPOSITION_CAPTURE_043.md`; não houve alteração de produção.

## Tarefa ativa — DEV4-R4-CARTOGRAPHIC-INLET-MATERIAL-ISOLATION-044

Determinar, por isolamento QA, se a superfície opaca observada provém da geometria ou do material do afluente cartográfico. A tarefa não pode alterar o material partilhado, a água R6, as âncoras, as rotas, a câmara, a luz ou a física de produção.

| Critério | Obrigatório |
|---|---|
| Produção | Nenhuma modificação a `ForestLakeRegion.gd`, `TerrainPatch.gd`, água R6 ou âncoras |
| Isolamento | Prova/captura de teste fora da montagem de produção |
| Clareira | Faixa `Z≈126–151` permanece integralmente livre |
| Corredor | Nenhum elemento a menos de 8 m do trilho físico |
| Integração | Preservar R5 e R6; tratar material partilhado como responsabilidade conjunta |
| Verificação | Parser, orçamento, porta R4 e três rotas antes de propor correção |

## Entrega concluída — DEV4-R4-CARTOGRAPHIC-INLET-MATERIAL-ISOLATION-044

O diagnóstico foi concluído sem alterar produção. O isolamento confirmou que a faixa deriva de uma lâmina visual ampla combinada com material lacustre opaco e partilhado; transparência, cota, largura e `cull_back` foram testados, rejeitados e revertidos. A evidência e a revisão comparativa foram integradas nos relatórios `CARTOGRAPHIC_INLET_ISOLATION_044.md` e `CARTOGRAPHIC_INLET_VARIANT_REVIEW_047.md`; a porta R4 e as três rotas foram aprovadas.

## Entrega concluída — DEV4-R4-CARTOGRAPHIC-INLET-EVIDENCE-REVIEW-049

A revisão QA consolidou a matriz de responsabilidades R4/R6 e confirmou que transparência, cota, largura e `cull_back` permanecem rejeitados. A evidência em `reports/r4/CARTOGRAPHIC_INLET_EVIDENCE_REVIEW_049.md` não autoriza produção: qualquer intervenção futura precisa de fonte causal, aprovação conjunta e prova runtime.

## Entrega concluída — DEV4-R4-CARTOGRAPHIC-INLET-MODULE-ELIGIBILITY-050

A auditoria QA inventariou duas raízes R4 existentes (`RaizExpostaFlorestal_14` e `RaizExpostaFlorestal_15`) fora da clareira Orion e a 8,75 m e 9,20 m do trilho. As referências não são autorizadas para produção. A reconciliação canónica também retirou a variante local de material incompatível com as quatro variantes formalmente rejeitadas, restaurando a lâmina e a fábrica lacustre canónicas. A evidência está em `reports/r4/CARTOGRAPHIC_INLET_MODULE_ELIGIBILITY_050.md`.

## Entrega concluída — DEV4-R4-CARTOGRAPHIC-INLET-MODULE-OWNERSHIP-CHECK-051

A verificação documental confirmou que a causa permanece na lâmina e no material lacustre partilhado sob responsabilidade R6, e que as duas raízes R4 inventariadas não têm aprovação para alteração. O roteiro de captura comparativa foi definido sem criar candidata. A evidência está em `reports/r4/CARTOGRAPHIC_INLET_MODULE_OWNERSHIP_CHECK_051.md`.

## Entrega concluída — DEV4-R4-CARTOGRAPHIC-INLET-MODULE-CAPTURE-READINESS-052

A prontidão estática confirmou a ferramenta canónica de captura, o viewport 16:9, a rota `arch_to_forest`, as dependências QA e a separação obrigatória baseline/candidata. Nenhuma captura runtime nem candidata foi criada. A evidência está em `reports/r4/CARTOGRAPHIC_INLET_MODULE_CAPTURE_READINESS_052.md`.

## Tarefa ativa — DEV4-R4-CARTOGRAPHIC-INLET-MODULE-BASELINE-CAPTURE-053

Executar exclusivamente uma captura QA baseline pós-carregamento de `arch_to_forest`, desde que a ponta canónica permaneça estável. A captura não pode criar candidata, modificar produção, mover, instanciar, materializar ou ocultar nós e não altera `ForestLakeRegion.gd`, `TerrainPatch.gd`, água R6, materiais, luzes, rota, câmara, âncoras ou física.

| Critério | Obrigatório |
|---|---|
| Produção | Zero modificações de produção nesta tarefa QA |
| Captura | Somente baseline 16:9 de `arch_to_forest`, sem candidata |
| Propriedade | Preservar a exigência de aprovação explícita conjunta R4/R6 para qualquer candidata futura |
| Variantes rejeitadas | Não reabrir transparência, cota, largura ou `cull_back` |
| R4 | Clareira Orion em `Z≈126–151` e corredor ≥8 m integralmente preservados |
| R6 | Água, quatro luzes, handoff e rotas permanecem imutáveis |
| Verificação | Parser, orçamento, porta R4 e três rotas antes de publicação |

## Sucessão obrigatória

Há exatamente uma tarefa ACTIVE. Ao concluir a captura baseline, Dev4 deve avançar para nova tarefa QA rastreável; qualquer alteração de produção exige tarefa distinta, evidência runtime e reconciliação prévia da propriedade R4/R6.
