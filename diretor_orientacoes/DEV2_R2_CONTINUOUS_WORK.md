# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-RIVER-FOOTBRIDGE-005
owner: Dev2
branch: dev2/r2-river-road
```

## Entrega anterior aprovada — DEV2-R2-WORLD-LIFE-001

A camada de vida física foi concluída e passou a porta R2: `MarcoPedrasDeTomas`, `PassagemMargemBaixa` e `VestigioAntesDoArco` são volumes reais fora do leito da estrada, com colisores baixos apenas nos elementos pétreos. A prova `[ORIGEM_R2_WORLD_LIFE_OK]` agora é obrigatória na porta regional. A estrada, o Arco em Z aproximado 92 e o orçamento R2 de duas luzes permanecem preservados.

## Entrega anterior aprovada — DEV2-R2-ORION-REFLECTION-002

A estação `EstacaoDeObservacaoDoReflexoOrion` foi acrescentada à margem segura do primeiro reflexo, em Z 51. Ela contém cinco lajes húmidas irregulares, dois vestígios baixos e três pedras de visada, todos sem luz dinâmica nova. A prova `[ORIGEM_R2_ORION_STATION_OK]` passou dentro da porta R2 e confirma que a estação preserva a estrada, o Arco e a reflexão localizada.

## Tarefa concluída — DEV2-R2-TRAVELLER-REST-003

A Estrada do Rio recebeu um ponto de descanso físico e silencioso, distinto da Casa Voss e do Acampamento Majestic. O ponto contém abrigo baixo de pedra caída, banco/laje de observação, mochila de Miguel, ferramentas desaparecidas e fogueira extinta sem luz dinâmica. A porta regional R2 passou no CI após a implementação.

## Entrega anterior aprovada — DEV2-R2-RIVER-CAIRN-004

`MarcoCairnRegresso` foi construído como cairn arqueológico baixo com pedras reais, laje tombada e colisor coincidente fora da faixa da estrada. A prova `[ORIGEM_R2_RIVER_CAIRN_OK]` é obrigatória na porta R2 e confirma a passagem livre, sem luz dinâmica ou nova interação.

## Tarefa ativa — DEV2-R2-RIVER-FOOTBRIDGE-005

A travessia lateral já visível no vale deve ganhar **leitura física de aproximação**, sem deslocar a ponte positiva existente nem transformar a margem numa rota alternativa obrigatória. A entrega deve adicionar dois encontros de pedra baixos, lajes partidas de acesso e vegetação ribeirinha esparsa que façam a ponte parecer uma construção antiga usada apenas como ponto de observação. Nenhum elemento pode cruzar o eixo Casa Voss → Arco, criar luz dinâmica ou tornar a ponte uma atalho de progressão.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Preservar Casa Voss → Estrada do Rio → Arco e a posição da ponte lateral existente |
| Desempenho | Zero luz dinâmica, partículas e emissão persistente; reutilizar pedra e fetos reais já presentes |
| Jogabilidade | A aproximação permanece lateral, fora do eixo de 4,15 m e não bloqueia `road_return_voss`, `road_to_arch` ou `positive_bridge` |
| Geometria | Usar encontros, lajes e vegetação ribeirinha esparsa reais; não usar painéis nem uma parede de árvores |
| Narrativa | A ponte deve parecer uma observação arqueológica secundária, sem competir com a ordem de progressão Casa → Estrada → Arco |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2` e acrescentar uma prova específica da leitura de aproximação antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

`DEV2-R2-RIVER-EDGE-006` deverá enriquecer uma margem curta após a aprovação da tarefa atual, sem tornar o rio atravessável nem aumentar o orçamento de luz.
