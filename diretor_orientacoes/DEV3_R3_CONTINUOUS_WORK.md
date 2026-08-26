# Dev3 — Contrato de Trabalho Contínuo do Arco das Ruínas

> **Regra operacional:** uma prova R3 aprovada não encerra o Dev3. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 3 sem sequência de trabalho rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV3-R3-FOREST-HANDOFF-002
owner: Dev3
branch: dev3/r3-arch-ruins
```

## Entrega recuperada e aprovada — DEV3-R3-ARCH-AWAKENING-RECOVERY-001

A entrega declarada do Dev3 não estava presente no repositório remoto no commit indicado pelo relatório. Foi recuperada de forma compatível com o mundo atual: o Arco físico existente continua em Z aproximado 92, com dois pilares colidíveis laterais e vão central livre. A camada `R3ArchAwakening` acrescenta inscrições, efeito moderado sem novas luzes, despertar único por `EventBus.world_event_triggered` e persistência através do grupo `Persist`.

A prova `[ORIGEM_R3_ARCH_OK]` valida a projeção física, os dois colisores laterais, exatamente duas `OmniLight3D` locais e o despertar idempotente. O preenchimento Omni adicional foi removido para manter o orçamento contratual R3.

## Tarefa ativa — DEV3-R3-FOREST-HANDOFF-002

A passagem oriental após o Arco deve ganhar uma **leitura arqueológica de transição para a Floresta Densa**, mantendo o Arco como horizonte e evitando qualquer parede de árvores. A entrega deve acrescentar pedras de orientação baixas, solo mais húmido e vegetação aberta em grupos assimétricos apenas depois do vão, revelando a direção R4 sem comprimir o percurso ou antecipar a floresta como um bloqueio visual.

| Critério | Obrigatório |
|---|---|
| Escopo | R3 e documentação Dev3; não alterar âncoras, `ForestLakeRegion.gd` ou módulos R4–R6 sem integração aprovada |
| Cartografia | Preservar o Arco em Z aproximado 92, o eixo Casa Voss → Estrada → Arco e a rota `arch_to_forest` |
| Geometria | Usar pedras, terreno e vegetação baixa reais; não usar painéis, árvores repetidas em parede ou cortes de percurso |
| Luz | Máximo de duas luzes dinâmicas R3 no Arco; a nova transição não pode acrescentar luz dinâmica |
| Jogabilidade | Não bloquear o vão central, a rota `road_to_arch` ou a saída física para R4 |
| Narrativa | Reforçar a escolha de atravessar o Arco e avançar para a floresta sem contradizer Tomás, Miguel, Orion ou o Códice |
| Verificação | Executar `tools/qa/run_regional_gate.sh R3`, `[ORIGEM_R3_ARCH_OK]` e criar uma prova específica do handoff antes de abrir PR |

## Fecho e avanço obrigatório

Dev3 só pode fechar a tarefa após commit publicado, porta R3 verde e substituição desta secção por outra **Tarefa ativa** com `task_id` novo. A esteira cria ou mantém uma única issue ativa de continuidade do Dev3 e encerra automaticamente as obsoletas.

## Próxima fila reservada

`DEV3-R3-INSCRIPTION-LORE-003` deverá aprofundar a leitura narrativa das inscrições após a aprovação da tarefa atual, sem acrescentar interface persistente ou alterar o Códice sem coordenação Dev1.
