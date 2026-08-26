# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-FOREST-EDGE-RHYTHM-015
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

## Tarefa ativa — DEV4-R4-FOREST-EDGE-RHYTHM-015

Rever a **cadência da borda R4** usando transformações estáticas de elementos ambientais existentes junto à transição para Majestic. A tarefa deve manter o conector livre e legível sem alterar rota, câmara, lajes, clareira Orion, física, módulos Dev5, iluminação, partículas, vento, pós-processamento, interface ou narrativa explícita.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r4/`, montagem mínima e QA R4 |
| Clareira | Faixa `Z≈126–151` permanece integralmente livre |
| Corredor | Nenhum elemento a menos de 6 m do trilho físico |
| Integração R5 | Não alterar módulos, ativos, lógica, iluminação ou acampamento de Dev5 |
| Dinâmica | Zero luz, colisores, partículas, vento, pós-processamento ou animação |
| Verificação | Parser, prova própria, porta R4 e três rotas antes de publicar |

## Próxima fila reservada

`DEV4-R4-FOREST-THRESHOLD-READING-016` deverá consolidar a leitura do limiar R4 sem modificar a rota, a câmara ou os limites regionais.
