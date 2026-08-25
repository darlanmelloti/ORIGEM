# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-RIVER-CAIRN-004
owner: Dev2
branch: dev2/r2-river-road
```

## Entrega anterior aprovada — DEV2-R2-WORLD-LIFE-001

A camada de vida física foi concluída e passou a porta R2: `MarcoPedrasDeTomas`, `PassagemMargemBaixa` e `VestigioAntesDoArco` são volumes reais fora do leito da estrada, com colisores baixos apenas nos elementos pétreos. A prova `[ORIGEM_R2_WORLD_LIFE_OK]` agora é obrigatória na porta regional. A estrada, o Arco em Z aproximado 92 e o orçamento R2 de duas luzes permanecem preservados.

## Entrega anterior aprovada — DEV2-R2-ORION-REFLECTION-002

A estação `EstacaoDeObservacaoDoReflexoOrion` foi acrescentada à margem segura do primeiro reflexo, em Z 51. Ela contém cinco lajes húmidas irregulares, dois vestígios baixos e três pedras de visada, todos sem luz dinâmica nova. A prova `[ORIGEM_R2_ORION_STATION_OK]` passou dentro da porta R2 e confirma que a estação preserva a estrada, o Arco e a reflexão localizada.

## Entrega anterior aprovada — DEV2-R2-TRAVELLER-REST-003

`PontoDeDescansoDoViajante` foi implantado em Z 37, fora da faixa central da estrada. O banco de laje, a `MochilaDeMiguel`, o abrigo baixo e a `FogueiraExtintaDoViajante` contam a passagem de Miguel sem criar interação de save, cura, luz dinâmica, emissão persistente ou partículas. A prova `[ORIGEM_R2_TRAVELLER_REST_OK]` passou dentro da porta regional R2.

## Tarefa ativa — DEV2-R2-RIVER-CAIRN-004

O regresso pela Estrada do Rio deve receber um **cairn baixo e legível** na margem exterior, usado como marco de decisão para quem volta da direção do Arco. A entrega deve criar pedras empilhadas assimetricamente e uma pequena laje de percurso caída, com posição que faça sentido ao olhar para Casa Voss sem competir com os marcos de Tomás. Não pode tornar-se um segundo Arco, bloquear a estrada, criar luzes nem acrescentar uma seta UI.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | O cairn deve ficar entre o ponto de viajante e o Arco, mas fora do leito de 4,15 m da estrada |
| Desempenho | Zero luz dinâmica e zero emissão persistente; reutilizar pedra real existente |
| Jogabilidade | Preservar `road_return_voss`, `road_to_arch` e `positive_bridge` sem colisores invisíveis no eixo |
| Narrativa | O marco reforça “seguir as pedras” no retorno, sem reescrever as pistas de Tomás ou Miguel |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2` e acrescentar uma prova específica do cairn antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

`DEV2-R2-RIVER-FOOTBRIDGE-005` deverá aprofundar a leitura física de uma travessia lateral apenas depois da tarefa atual ser aprovada, sem deslocar a ponte positiva existente.
