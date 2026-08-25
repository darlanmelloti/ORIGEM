# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-RIVER-RETURN-010
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

## Tarefa concluída — DEV2-R2-RIVER-EDGE-006
A margem curta antes do Arco recebeu dois afloramentos baixos, pedras húmidas e fetos dispersos, sem luz, partículas, emissão persistente ou caminho atravessável. A porta R2 passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-APPROACH-007
O último trecho antes do Arco recebeu duas lajes interrompidas, pedras de borda e fetos esparsos, mantendo o eixo principal livre, o acesso secundário e o orçamento de luz. A prova `[ORIGEM_R2_RIVER_APPROACH_OK]` passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-EDGE-008
A margem final recebeu uma linha curta de três pedras de leitura e vegetação aberta, mantendo o leito não atravessável e o orçamento de luz inalterado. A porta R2 passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-APPROACH-009
O recuo final da margem recebeu duas lajes baixas, pedras molhadas e vegetação esparsa, mantendo o acesso lateral e o eixo principal livres. A prova `[ORIGEM_R2_RIVER_APPROACH_009_OK]` passou no CI.

## Tarefa ativa — DEV2-R2-RIVER-RETURN-010

O retorno da Estrada do Rio deve receber uma **linha de visada baixa para a Casa Voss**, formada por duas pedras de referência e uma laje curta lateral. A leitura deve ser ambiental, sem seta, HUD ou interação, e não pode bloquear as rotas existentes.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Manter a linha lateral de retorno sem mover estrada, Arco ou âncoras cartográficas |
| Acesso | Permanecer fora do eixo caminhável e não criar atalho para o rio |
| Desempenho | Zero luz dinâmica, partículas e emissão persistente; reutilizar pedra e fetos reais já presentes |
| Jogabilidade | Não bloquear `road_return_voss`, `road_to_arch` ou `positive_bridge`; não criar um novo atalho para o rio |
| Geometria | Usar duas pedras de referência e uma laje curta real; não usar painéis, seta ou parede de árvores |
| Narrativa | A visada deve orientar o retorno à Casa Voss sem competir com Orion ou o Arco |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2` e acrescentar `[ORIGEM_R2_RIVER_RETURN_010_OK]` antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

A fila seguinte será definida após a aprovação de `DEV2-R2-RIVER-RETURN-010`, mantendo o estado `ACTIVE` e o trabalho contínuo rastreável no GitHub.
