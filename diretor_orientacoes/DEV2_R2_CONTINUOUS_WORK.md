# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-RIVER-EDGE-006
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

## Entrega anterior aprovada — DEV2-R2-RIVER-FOOTBRIDGE-005

`AproximacaoArqueologicaPonteLateral` foi construída com dois encontros baixos, quatro lajes partidas com colisores coincidentes e três fetos esparsos. A prova `[ORIGEM_R2_FOOTBRIDGE_OK]` confirma que ela é secundária, física e sem luz dinâmica, preservando a ponte positiva e o eixo Casa Voss → Arco.

## Tarefa ativa — DEV2-R2-RIVER-EDGE-006

Uma margem curta antes do Arco deve receber uma **leitura geológica ribeirinha** de baixo custo: dois afloramentos baixos, pedras húmidas e fetos dispersos que enquadrem o rio sem criar uma parede vegetal ou um novo caminho. A entrega deve permanecer lateral, não atravessável e fora da rota principal. Nenhuma luz, painel, emissão persistente ou colisão invisível é permitida.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Ficar em margem lateral antes do Arco, sem mover a estrada ou as âncoras cartográficas |
| Desempenho | Zero luz dinâmica, partículas e emissão persistente; reutilizar pedra e fetos reais já presentes |
| Jogabilidade | Não bloquear `road_return_voss`, `road_to_arch` ou `positive_bridge`; não criar um novo atalho para o rio |
| Geometria | Usar afloramentos e vegetação esparsa reais; não usar painéis nem uma parede de árvores |
| Narrativa | O afloramento deve reforçar a antiguidade geológica do vale, sem competir com Orion ou o Arco |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2` e acrescentar uma prova específica da margem antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

`DEV2-R2-RIVER-APPROACH-007` deverá aprofundar a leitura do último trecho até ao Arco depois da aprovação da tarefa atual, sem competir com a responsabilidade da R3.
