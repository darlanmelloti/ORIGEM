# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-TRAVELLER-REST-003
owner: Dev2
branch: dev2/r2-river-road
```

## Entrega anterior aprovada — DEV2-R2-WORLD-LIFE-001

A camada de vida física foi concluída e passou a porta R2: `MarcoPedrasDeTomas`, `PassagemMargemBaixa` e `VestigioAntesDoArco` são volumes reais fora do leito da estrada, com colisores baixos apenas nos elementos pétreos. A prova `[ORIGEM_R2_WORLD_LIFE_OK]` agora é obrigatória na porta regional. A estrada, o Arco em Z aproximado 92 e o orçamento R2 de duas luzes permanecem preservados.

## Entrega anterior aprovada — DEV2-R2-ORION-REFLECTION-002

A estação `EstacaoDeObservacaoDoReflexoOrion` foi acrescentada à margem segura do primeiro reflexo, em Z 51. Ela contém cinco lajes húmidas irregulares, dois vestígios baixos e três pedras de visada, todos sem luz dinâmica nova. A prova `[ORIGEM_R2_ORION_STATION_OK]` passou dentro da porta R2 e confirma que a estação preserva a estrada, o Arco e a reflexão localizada.

## Tarefa ativa — DEV2-R2-TRAVELLER-REST-003

A Estrada do Rio deve receber um **pequeno ponto de descanso de viajante**, distinto do repouso protegido da Casa Voss e do Acampamento Majestic. A entrega deve criar uma área de observação física e silenciosa junto ao percurso inicial: abrigo baixo de pedra caída, banco/laje para sentar, mochila arqueológica e uma fogueira extinta sem luz dinâmica. O ponto deve sugerir que Miguel passou por ali, mas não pode salvar, curar ou abrir um sistema de descanso novo nesta fase.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Preservar Casa Voss → Estrada do Rio → Arco e manter o Arco físico em Z aproximado 92 |
| Desempenho | Não acrescentar luzes dinâmicas R2; a fogueira é extinta, sem emissão persistente nem partículas caras |
| Jogabilidade | O ponto fica fora do leito de 4,15 m da estrada e não bloqueia `road_return_voss`, `road_to_arch` ou `positive_bridge` |
| Geometria | Usar rochas, lajes, mochila e prop físico reais; não usar painéis, árvores em parede ou colisores invisíveis na rota |
| Narrativa | A mochila e as ferramentas devem ligar-se ao desaparecimento de Miguel, sem contradizer o Códice de Elias |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2`, manter as provas de vida/reflexo e acrescentar uma prova específica do ponto de descanso antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

`DEV2-R2-RIVER-CAIRN-004` deverá adicionar um marco de pedra discreto ao regresso da estrada, depois de a tarefa atual ser aprovada, sem criar um segundo Arco ou uma barreira visual.
