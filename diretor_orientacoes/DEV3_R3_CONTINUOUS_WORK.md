# Dev3 — Contrato de Trabalho Contínuo do Arco das Ruínas

> **Regra operacional:** uma prova R3 aprovada não encerra o Dev3. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 3 sem sequência de trabalho rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV3-R3-INSCRIPTION-LORE-003
owner: Dev3
branch: dev3/r3-arch-ruins
```

## Entrega recuperada e aprovada — DEV3-R3-ARCH-AWAKENING-RECOVERY-001

A entrega declarada do Dev3 não estava presente no repositório remoto no commit indicado pelo relatório. Foi recuperada de forma compatível com o mundo atual: o Arco físico existente continua em Z aproximado 92, com dois pilares colidíveis laterais e vão central livre. A camada `R3ArchAwakening` acrescenta inscrições, efeito moderado sem novas luzes, despertar único por `EventBus.world_event_triggered` e persistência através do grupo `Persist`.

A prova `[ORIGEM_R3_ARCH_OK]` valida a projeção física, os dois colisores laterais, exatamente duas `OmniLight3D` locais e o despertar idempotente. O preenchimento Omni adicional foi removido para manter o orçamento contratual R3.

## Entrega aprovada — DEV3-R3-FOREST-HANDOFF-002

`R3HandoffParaFloresta` foi instalado no corredor real depois do Arco com quatro pedras de orientação baixas e oito fetos dispersos. A sequência permanece fora da faixa central, não cria colisores, luzes, painéis ou parede vegetal. A prova `[ORIGEM_R3_ARCH_OK]` confirma os quatro marcos abertos, zero `OmniLight3D` nova e a preservação do Arco, do despertar e das rotas R3.

## Tarefa ativa — DEV3-R3-INSCRIPTION-LORE-003

As inscrições do Arco devem receber uma **leitura arqueológica adicional e discreta**, através de duas pequenas placas de pedra quebrada e texto ambiental complementar ao lado do percurso, sem abrir UI persistente nem adicionar marcadores flutuantes. A informação precisa de dialogar com o despertar existente e apontar para a memória do rio, mantendo a interpretação aberta para futuros capítulos de Orion.

| Critério | Obrigatório |
|---|---|
| Escopo | R3 e documentação Dev3; não alterar o Códice, `ForestLakeRegion.gd`, âncoras ou módulos R4–R6 sem integração aprovada |
| Cartografia | Preservar Arco em Z aproximado 92 e a saída `arch_to_forest` |
| Geometria | Duas placas quebradas e elementos baixos reais; nunca usar painel, UI ou bloqueio no vão |
| Luz | Sem luz dinâmica adicional; manter o máximo de duas luzes do Arco |
| Narrativa | Complementar “A PEDRA RECORDA” e “NÃO SIGAS A LUZ” sem revelar a verdade de Orion prematuramente |
| Verificação | Executar `tools/qa/run_regional_gate.sh R3`, `[ORIGEM_R3_ARCH_OK]` e acrescentar prova específica das duas placas antes de abrir PR |

## Fecho e avanço obrigatório

Dev3 só pode fechar a tarefa após commit publicado, porta R3 verde e substituição desta secção por outra **Tarefa ativa** com `task_id` novo. A esteira cria ou mantém uma única issue ativa de continuidade do Dev3 e encerra automaticamente as obsoletas.

## Próxima fila reservada

`DEV3-R3-ARCH-SOUNDLESS-VFX-004` deverá refinar a leitura visual do despertar após a aprovação da tarefa atual, sem adicionar áudio obrigatório, partículas densas ou novas luzes.
