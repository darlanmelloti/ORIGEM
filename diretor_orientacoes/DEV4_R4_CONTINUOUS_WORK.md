# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-UNDERSTORY-EDGE-005
owner: Dev4
branch: dev4/r4-dense-forest
```

## Base oficial e fronteira

A base de trabalho é o repositório oficial do ORIGEM, branch canónica `dev4/r4-dense-forest`, sincronizada por avanço rápido com `integration/r1-r6-sprint1`. A R4 mantém a âncora cartográfica `(-9, 116)`, ocupa a transição entre o Arco e o Acampamento Majestic e conserva as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

O conteúdo Dev4 novo continua modular sob `levels/regions/r4/`. A montagem mínima em `levels/ForestLakeRegion.gd` é permitida apenas para instalar módulos R4 aditivos; não editar âncoras, `RiverRoadJourney.gd`, módulos R1–R3/R5–R6 ou sistemas transversais protegidos.

## Entrega concluída — DEV4-R4-MIST-LAYER-002

`R4CamadaNeblinaLocal` foi instalada por `ForestMistLayer.gd`. A camada não cria geometria, `FogVolume`, planos, partículas, colisores, pós-processamento ou luzes. Aplica apenas uma variação subtil de material nas massas selecionadas da R4. A clareira de Orion em `Z≈126–151` recebe peso zero, mantendo a leitura de Orion e a saída para Majestic.

## Entrega concluída — DEV4-R4-ORION-CLEARING-LORE-003

`ForestClearingLore.gd` instalou três vestígios laterais de passagem antiga na clareira: nove pedras gastas em conjuntos assimétricos, fora do corredor jogável. A entrega não introduz interface, texto, objetivos, diálogos, colecionáveis, eventos, animações, colisores ou luzes. A prova `[ORIGEM_R4_LORE_OK]`, a porta R4 e as três rotas foram aprovadas.

## Entrega concluída — DEV4-R4-CANOPY-CADENCE-004

`ForestCanopyCadence.gd` aplicou variação determinística e estática a copas já existentes nas massas laterais R4. A entrega altera somente posição lateral exterior, escala moderada e rotação Y em parte das instâncias; não cria malhas, materiais, luzes, colisores, animação, partículas, vento físico, shaders, pós-processamento ou alterações de câmara.

| Critério | Resultado aprovado |
|---|---|
| Cadência | 26 copas existentes ajustadas de forma estática e económica |
| Clareira Orion | 20 copas na faixa `Z=126–151` preservadas sem modulação |
| Corredor | Todas as copas verificadas a pelo menos 6 m do trilho físico |
| Luz e física | Zero `Light3D` e zero `StaticBody3D` criados pelo módulo |
| QA | `[ORIGEM_R4_CANOPY_OK]`, parser, porta R4 e as três rotas aprovadas |

## Tarefa ativa — DEV4-R4-UNDERSTORY-EDGE-005

Refinar a **transição do sub-bosque lateral** entre o Arco e a clareira Orion, ajustando apenas a distribuição estática de fetos e rochas já existentes. O objetivo é reduzir agrupamentos que possam sugerir repetição, manter um gradiente visual suave para a clareira e conservar a leitura livre de Orion, Majestic e do trilho.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r4/`, montagem mínima e QA R4 |
| Clareira | Manter integralmente livre a faixa `Z≈126–151` e os elementos aprovados da clareira |
| Corredor | Nenhum elemento pode entrar na faixa física de 6 m do trilho |
| Luz e física | Zero luz dinâmica, colisores, partículas, vento, pós-processamento ou animação |
| Performance | Reorganizar somente instâncias estáticas existentes; não introduzir malhas pesadas |
| Verificação | Parser, prova própria, porta R4 e as três rotas antes de publicar |

## Próxima fila reservada

`DEV4-R4-ORION-VISTA-FRAMING-006` deverá rever o enquadramento lateral de Orion depois da tarefa de sub-bosque, sem reduzir a abertura cartográfica, criar narrativa explícita ou modificar a câmara global.
