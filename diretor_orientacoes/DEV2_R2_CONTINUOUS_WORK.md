# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-RIVER-QA-023
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

## Tarefa concluída — DEV2-R2-RIVER-RETURN-010
A visada ambiental para Casa Voss recebeu duas pedras de referência e uma laje lateral, sem seta, HUD, interação ou luz dinâmica. A prova `[ORIGEM_R2_RIVER_RETURN_010_OK]` passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-MARKER-011
Os dois marcadores ambientais de retorno foram adicionados com pedras baixas e fetos abertos, sem sinalização explícita, interação ou luz dinâmica. A prova `[ORIGEM_R2_RIVER_MARKER_011_OK]` passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-012
O gate passou a verificar que os marcadores ambientais não possuem `StaticBody3D`, `CollisionShape3D` ou `Area3D`. A prova `[ORIGEM_R2_RIVER_QA_012_OK]` passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-ROUTE-013
A prova foi corrigida para usar a API contratual oficial de R2 e confirmou `road_to_arch`, `road_return_voss` e `positive_bridge`; o CI passou após a normalização da indentação.

## Tarefa concluída — DEV2-R2-RIVER-QA-014
O verificador contratual passou a exigir `road_to_arch`, `road_return_voss` e `positive_bridge`, mantendo o proprietário `Dev2`; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-015
O verificador confirmou a completude dos critérios, a origem `RiverRoadJourney.gd` e a AABB física da R2; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-016
O verificador confirmou o vocabulário mínimo de rota, reflexo, ponte e luz; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-017
O verificador confirmou as restrições de Orion, água não emissiva e ponte não dominante; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-018
O verificador confirmou a consistência entre as notas do contrato e os critérios essenciais; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-019
O verificador confirmou as âncoras contratuais de entrada e saída dentro da AABB R2; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-020
O verificador confirmou a idempotência de `build()` e o nome canônico do nó regional; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-021
O verificador confirmou os metadados retornados por `run_qa_contract()` sincronizados com o contrato; a prova passou no CI.

## Tarefa concluída — DEV2-R2-RIVER-QA-022
O verificador confirmou a composição exata das três rotas canônicas e a ausência de atalhos extras; a prova passou no CI.

## Tarefa ativa — DEV2-R2-RIVER-QA-023

O verificador contratual da R2 deve confirmar a **coerência do orçamento de luz**, garantindo que o limite regional declarado permaneça compatível com o teto global de duas luzes dinâmicas. Esta tarefa é somente de QA e não altera geometria, navegação ou cenas.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Validar as três rotas no contrato sem mover estrada, Arco ou âncoras cartográficas |
| Acesso | Confirmar orçamento regional de duas luzes, sem criar novas fontes dinâmicas |
| Desempenho | Zero luz dinâmica, partículas e emissão persistente; reutilizar pedra e fetos reais já presentes |
| Jogabilidade | Não bloquear `road_return_voss`, `road_to_arch` ou `positive_bridge`; não criar um novo atalho para o rio |
| Geometria | Não alterar a geometria; validar apenas metadados contratuais |
| Narrativa | A visada deve orientar o retorno à Casa Voss sem competir com Orion ou o Arco |
| Verificação | Executar o verificador contratual e acrescentar `[ORIGEM_R2_RIVER_QA_023_OK]` antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

A fila seguinte será definida após a aprovação de `DEV2-R2-RIVER-QA-023`, mantendo o estado `ACTIVE` e o trabalho contínuo rastreável no GitHub.
