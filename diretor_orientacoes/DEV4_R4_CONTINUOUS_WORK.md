# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-ORION-CLEARING-LORE-003
owner: Dev4
branch: dev4/r4-dense-forest
```

## Base oficial e fronteira

A base de trabalho é o repositório oficial do ORIGEM, branch canónica `dev4/r4-dense-forest`, sincronizada por avanço rápido com `integration/r1-r6-sprint1`. A R4 mantém a âncora cartográfica `(-9, 116)`, ocupa a transição entre o Arco e o Acampamento Majestic e conserva as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.

O conteúdo Dev4 novo continua modular sob `levels/regions/r4/`. A montagem mínima em `levels/ForestLakeRegion.gd` é permitida apenas para instalar módulos R4 aditivos; não editar âncoras, `RiverRoadJourney.gd`, módulos R1–R3/R5–R6 ou sistemas transversais protegidos.

## Entrega concluída — DEV4-R4-MIST-LAYER-002

`R4CamadaNeblinaLocal` foi instalada por `ForestMistLayer.gd`. A camada não cria geometria, `FogVolume`, planos, partículas, colisores, pós-processamento ou luzes. Em vez disso, aplica uma variação subtil de material apenas nas massas selecionadas da R4.

A clareira de Orion em `Z≈126–151` recebe peso zero; portanto, mantém-se aberta para a leitura de Orion e do caminho para Majestic. A prova `[ORIGEM_R4_MIST_OK]` registou `materiais=128`, `clareira_protegida=42` e `luzes=0`. A porta `tools/qa/run_regional_gate.sh R4` foi aprovada, incluindo a prova de clareira, contratos e três rotas R4.

| Critério mantido | Resultado |
|---|---|
| Clareira Orion | Preservada, sem camada atmosférica local |
| Luz | Nenhuma luz nova; baliza única aprovada permanece |
| Atmosfera | Material local e de baixa intensidade; sem parede de névoa |
| QA | Parser, prova de neblina e porta canónica R4 aprovados |

## Tarefa ativa — DEV4-R4-ORION-CLEARING-LORE-003

Acrescentar **leitura ambiental discreta** à clareira Orion com um único conjunto de elementos estáticos de baixo custo. A entrega deve sugerir passagem antiga e direção da montanha por pedras, desgaste de trilho ou afloramentos baixos; não pode criar interface, objetivos, diálogo, colecionáveis, animação de revelação ou lore explícito antes do momento narrativo correto.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r4/` e documentação Dev4 |
| Clareira | Manter a faixa aberta Z≈126–151, os quatro quadros e oito fetos existentes |
| Atmosfera | Não reduzir visibilidade de Orion, Majestic ou do trilho |
| Luz | Zero luz dinâmica nova; preservar a única baliza local existente |
| Performance | Materiais existentes e um número reduzido de instâncias estáticas |
| Verificação | Porta canónica R4, prova específica de lore e confirmação das três rotas |

## Próxima fila reservada

`DEV4-R4-CANOPY-CADENCE-004` deverá ajustar a cadência visual das copas após a leitura da clareira, sem alterar a geometria compartilhada nem a câmara global.
