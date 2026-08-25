# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-WORLD-LIFE-001
owner: Dev2
branch: dev2/r2-river-road
```

## Tarefa ativa — DEV2-R2-WORLD-LIFE-001

A Estrada do Rio deve ganhar uma camada de **vida física de viagem**, sem encurtar a rota ou alterar as âncoras cartográficas. A entrega deve adicionar três marcos de orientação reais e distintos ao percurso exterior: uma marca de pedra junto à saída da Casa Voss, uma passagem de margem/vegetação baixa que enquadre o rio e um vestígio arqueológico antes da leitura do Arco. Estes elementos devem ser geometria navegável ou decorativa real; não podem ser painéis, emissões que simulem água, paredes repetidas de árvores ou bloqueios novos.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Preservar Casa Voss → Estrada do Rio → Arco e a leitura da silhueta física do Arco em Z aproximado 92 |
| Desempenho | Respeitar orçamento contratual R2: no máximo 2 luzes dinâmicas regionais; não criar efeitos de água por emissão persistente |
| Jogabilidade | Manter as rotas `road_return_voss`, `road_to_arch` e `positive_bridge` atravessáveis |
| Narrativa | Cada marco deve reforçar a pista “seguir as pedras, não a luz azul”, sem contradizer Tomás, Miguel ou Orion |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2`, anexar os logs relevantes e abrir PR para `integration/r1-r6-sprint1` |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional deve abrir automaticamente um item de continuidade no GitHub e manter o estado operacional como **ACTIVE**.

## Próxima fila reservada

`DEV2-R2-ORION-REFLECTION-002` deverá ampliar apenas a leitura física e de baixo custo do reflexo de Orion ao longo do rio, depois de a tarefa atual ser aprovada. A sua definição detalhada será movida para “Tarefa ativa” por Dev2 no momento do fecho da entrega 001.
