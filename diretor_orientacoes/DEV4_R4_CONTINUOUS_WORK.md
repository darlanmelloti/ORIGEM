# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-CANOPY-CADENCE-004
owner: Dev4
branch: dev4/r4-dense-forest
```

## Base oficial e fronteira

A base de trabalho é o repositório oficial do ORIGEM, branch canónica `dev4/r4-dense-forest`, sincronizada por avanço rápido com `integration/r1-r6-sprint1`. A R4 mantém a âncora cartográfica `(-9, 116)`, ocupa a transição entre o Arco e o Acampamento Majestic e conserva as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

O conteúdo Dev4 novo continua modular sob `levels/regions/r4/`. A montagem mínima em `levels/ForestLakeRegion.gd` é permitida apenas para instalar módulos R4 aditivos; não editar âncoras, `RiverRoadJourney.gd`, módulos R1–R3/R5–R6 ou sistemas transversais protegidos.

## Entrega concluída — DEV4-R4-MIST-LAYER-002

`R4CamadaNeblinaLocal` foi instalada por `ForestMistLayer.gd`. A camada não cria geometria, `FogVolume`, planos, partículas, colisores, pós-processamento ou luzes. Aplica apenas uma variação subtil de material nas massas selecionadas da R4.

A clareira de Orion em `Z≈126–151` recebe peso zero; portanto, mantém-se aberta para a leitura de Orion e do caminho para Majestic. A prova `[ORIGEM_R4_MIST_OK]` registou `materiais=128`, `clareira_protegida=42` e `luzes=0`.

## Entrega concluída — DEV4-R4-ORION-CLEARING-LORE-003

`ForestClearingLore.gd` instala três vestígios de passagem antiga na lateral da clareira: nove pedras gastas em conjuntos assimétricos, todas fora do corredor jogável. A entrega não introduz UI, texto, objetivos, diálogos, colecionáveis, eventos, animações de revelação, colisores ou luzes. A leitura continua material e ambiental, sem antecipar a revelação narrativa de Orion.

| Critério | Resultado |
|---|---|
| Clareira Orion | Faixa `Z=126–151` mantida livre, com 4.40 m de afastamento mínimo ao trilho |
| Vestígios | 3 conjuntos laterais e 9 pedras gastas |
| Luz e física | Zero `Light3D` e zero `StaticBody3D` criados pelo módulo |
| Atmosfera | Sem alteração à camada local de neblina ou à visibilidade distante |
| QA | `[ORIGEM_R4_LORE_OK]`, porta R4 e três rotas aprovadas |

## Tarefa ativa — DEV4-R4-CANOPY-CADENCE-004

Ajustar a cadência visual das copas R4 com poucas variações de escala, rotação e agrupamento em massa lateral. O objetivo é eliminar qualquer leitura de repetição sem erguer parede de árvores, invadir a clareira Orion, alterar a geometria partilhada, introduzir animação global, partículas, vento físico, luz, câmara ou pós-processamento. Preferir instâncias estáticas e materiais existentes; o trilho precisa permanecer legível desde o Arco até Majestic.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r4/`, montagem mínima e QA R4 |
| Clareira | Manter integralmente a faixa aberta Z≈126–151 |
| Corredor | Árvores a pelo menos 6 m do trilho físico |
| Luz | Zero luz dinâmica nova; baliza local única preservada |
| Performance | Poucas instâncias estáticas; sem animação ou shader novo |
| Verificação | Parser, prova própria, porta R4 e três rotas antes do PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev4 Continuous]` e encerra automaticamente o item anterior quando o `task_id` avançar. O fecho de `DEV4-R4-CANOPY-CADENCE-004` exige commit publicado, porta R4 aprovada e nova tarefa em estado `ACTIVE`.
