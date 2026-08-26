# Dev3 — Contrato de Trabalho Contínuo do Arco das Ruínas

> **Regra operacional:** uma prova R3 aprovada não encerra o Dev3. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 3 sem sequência de trabalho rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV3-R3-ARCH-SOUNDLESS-VFX-004
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

## Tarefa ativa — DEV3-R3-ARCH-SOUNDLESS-VFX-004

O despertar existente deve ganhar uma **leitura visual silenciosa e mais ritual**, através de uma cadência curta e contida nos efeitos já presentes, sem introduzir áudio obrigatório, novos emissores, luz dinâmica adicional ou partículas densas. O resultado deve fazer a ativação única do Arco mais legível na travessia, preservando o controlo do jogador e a continuidade para R4.

| Critério | Obrigatório |
|---|---|
| Escopo | Apenas `levels/regions/r3/`, QA R3 e documentação Dev3; não alterar Códice, `ForestLakeRegion.gd`, âncoras ou módulos R4–R6 |
| Cartografia | Preservar Arco em Z aproximado 92, vão físico livre e saída `arch_to_forest` |
| VFX | Reutilizar os efeitos do despertar; sem áudio obrigatório, novas luzes, novos emissores ou partículas densas |
| Luz | Manter exatamente as duas luzes locais existentes no Arco |
| Jogabilidade | Despertar continua único, persistente e não remove controlo do jogador |
| Verificação | Parser, `tools/qa/run_regional_gate.sh R3`, prova específica de cadência e rotas R3 antes de abrir a PR seguinte |

## Fecho e avanço obrigatório

Dev3 só pode fechar a tarefa após commit publicado, porta R3 verde e substituição desta secção por outra **Tarefa ativa** com `task_id` novo. A esteira cria ou mantém uma única issue ativa de continuidade do Dev3 e encerra automaticamente as obsoletas.

## Próxima fila reservada

`DEV3-R3-PASSAGE-ARCHAEOLOGY-005` deverá aprofundar a leitura de passagem após a aprovação da cadência visual, sem invadir a floresta R4, o Códice ou a interface.
