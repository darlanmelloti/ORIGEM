# Dev3 — Contrato de Trabalho Contínuo do Arco das Ruínas

> **Regra operacional:** uma prova R3 aprovada não encerra o Dev3. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 3 sem sequência de trabalho rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV3-R3-PASSAGE-ARCHAEOLOGY-005
owner: Dev3
branch: dev3/r3-arch-ruins
```

## Entrega recuperada e aprovada — DEV3-R3-ARCH-AWAKENING-RECOVERY-001

A entrega declarada do Dev3 não estava presente no repositório remoto no commit indicado pelo relatório. Foi recuperada de forma compatível com o mundo atual: o Arco físico existente continua em Z aproximado 92, com dois pilares colidíveis laterais e vão central livre. A camada `R3ArchAwakening` acrescenta inscrições, efeito moderado sem novas luzes, despertar único por `EventBus.world_event_triggered` e persistência através do grupo `Persist`.

A prova `[ORIGEM_R3_ARCH_OK]` valida a projeção física, os dois colisores laterais, exatamente duas `OmniLight3D` locais e o despertar idempotente. O preenchimento Omni adicional foi removido para manter o orçamento contratual R3.

## Entrega aprovada — DEV3-R3-FOREST-HANDOFF-002

`R3HandoffParaFloresta` foi instalado no corredor real depois do Arco com quatro pedras de orientação baixas e oito fetos dispersos. A sequência permanece fora da faixa central, não cria colisores, luzes, painéis ou parede vegetal. A prova `[ORIGEM_R3_ARCH_OK]` confirma os quatro marcos abertos, zero `OmniLight3D` nova e a preservação do Arco, do despertar e das rotas R3.

## Entrega aprovada — DEV3-R3-INSCRIPTION-LORE-003

`R3LeituraArqueologica` instala duas placas de pedra quebrada, baixas e laterais, no Arco físico já integrado. As leituras “O RIO GUARDA / O QUE A PEDRA CALA” e “A LUZ NÃO SABE / O CAMINHO DE VOLTA” dialogam com as inscrições existentes sem revelar Orion. As placas ficam fora da faixa central, não criam `CollisionShape3D`, `StaticBody3D`, UI ou `Light3D`, e recebem apenas uma alteração cromática discreta quando o despertar único ocorre. A prova `[ORIGEM_R3_INSCRIPTION_LORE_OK]`, o parser, o portão regional e as rotas `road_to_arch`/`arch_to_forest` foram aprovados; a captura técnica confirma a leitura lateral sem interface.

## Entrega aprovada — DEV3-R3-ARCH-SOUNDLESS-VFX-004

A cadência silenciosa foi aplicada a `EfeitosDoDespertar`, reutilizando os dois `SphereMesh` existentes. O primeiro despertar reinicia uma sequência de três pulsos durante `1,35 s`, com amplitude máxima de escala `0,12`, e regressa a uma oscilação residual menor. Não foram adicionados `Light3D`, emissores, partículas densas, áudio, UI ou bloqueio físico. A prova `[ORIGEM_R3_SILENT_VFX_OK]`, parser, porta regional e rotas R3 aprovaram o comportamento; a captura técnica confirma que o efeito continua subordinado aos pilares do Arco.

## Tarefa ativa — DEV3-R3-PASSAGE-ARCHAEOLOGY-005

A passagem após o Arco deve ganhar uma **leitura arqueológica de solo discreta**, através de vestígios baixos e esparsos fora da faixa central que convidem o olhar para `arch_to_forest`. O trabalho não pode invadir o território de R4, alterar o Códice, criar UI, painéis, colisores, luzes ou uma parede vegetal.

| Critério | Obrigatório |
|---|---|
| Escopo | Apenas `levels/regions/r3/`, QA R3 e documentação Dev3; não alterar Códice, `ForestLakeRegion.gd`, âncoras ou módulos R4–R6 |
| Cartografia | Preservar Arco em Z aproximado 92, vão físico livre e saída `arch_to_forest` |
| Geometria | Vestígios baixos, esparsos e laterais; sem colisores, painéis ou barreiras no corredor |
| Luz | Não adicionar luz dinâmica; manter exatamente as duas luzes locais existentes no Arco |
| Jogabilidade | A passagem e o despertar continuam únicos, persistentes e sem retirar controlo do jogador |
| Verificação | Parser, `tools/qa/run_regional_gate.sh R3`, prova específica dos vestígios e rotas R3 antes de abrir a PR seguinte |

## Fecho e avanço obrigatório

Dev3 só pode fechar a tarefa após commit publicado, porta R3 verde e substituição desta secção por outra **Tarefa ativa** com `task_id` novo. A esteira cria ou mantém uma única issue ativa de continuidade do Dev3 e encerra automaticamente as obsoletas.

## Próxima fila reservada

`DEV3-R3-RIVER-MEMORY-006` deverá aprofundar a ligação simbólica entre o rio e o Arco após a aprovação dos vestígios de passagem, sem antecipar a verdade de Orion.
