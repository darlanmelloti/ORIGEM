# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-FOREST-APPROACH-RHYTHM-007
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

| Entrega | Clareira Orion | Corredor | Luz e física | QA |
|---|---|---|---|---|
| Neblina | Peso zero em Z≈126–151 | Preservado | 0 luzes novas | Aprovada |
| Lore | 3 conjuntos laterais | Livre | 0 luzes e colisores | Aprovada |
| Copas | 20 copas protegidas | ≥6 m | 0 luzes e colisores | Aprovada |
| Sub-bosque | Sem elementos em Z=126–151 | ≥6,16 m | 0 luzes e colisores | Aprovada |
| Vista Orion | 2 copas protegidas | ≥6 m | 0 luzes e colisores | Aprovada |

## Tarefa ativa — DEV4-R4-FOREST-APPROACH-RHYTHM-007

Consolidar a **cadência ambiental da chegada a Majestic** na faixa exterior R4 após a clareira Orion. A tarefa deve ajustar somente posições, escalas e rotações de instâncias estáticas já existentes de árvores, rochas ou fetos entre o fim da clareira e o conector Majestic. O objetivo é conduzir a leitura do trilho para Majestic sem criar muro de vegetação, alterar a rota, a geometria partilhada ou os módulos da Dev5.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r4/`, montagem mínima e QA R4 |
| Clareira | Faixa `Z≈126–151` permanece integralmente livre |
| Corredor | Nenhum elemento a menos de 6 m do trilho físico |
| Integração R5 | Não alterar módulos, ativos ou lógica de Dev5 |
| Dinâmica | Zero luz, colisores, partículas, vento, pós-processamento ou animação |
| Verificação | Parser, prova própria, porta R4 e três rotas antes de publicar |

## Próxima fila reservada

`DEV4-R4-MAJESTIC-EDGE-BALANCE-008` deverá equilibrar a borda visual da transição R4→R5, sem modificar a rota, o acampamento ou a iluminação de Majestic.
