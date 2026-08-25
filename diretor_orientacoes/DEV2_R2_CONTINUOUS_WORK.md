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

## Tarefa concluída — DEV2-R2-TRAVELLER-REST-003

A Estrada do Rio recebeu um ponto de descanso físico e silencioso, distinto da Casa Voss e do Acampamento Majestic. O ponto contém abrigo baixo de pedra caída, banco/laje de observação, mochila de Miguel, ferramentas desaparecidas e fogueira extinta sem luz dinâmica. A porta regional R2 passou no CI após a implementação.

## Tarefa ativa — DEV2-R2-RIVER-CAIRN-004

A Estrada do Rio deve receber um **marco de pedra discreto no regresso da rota**, orientando o jogador de volta à Casa Voss sem criar um segundo Arco, seta luminosa ou barreira visual. O marco deve funcionar como cairn arqueológico baixo, com duas ou três pedras reais, uma laje tombada e um pequeno espaço livre de passagem. A leitura deve permanecer ambiental e não abrir novo sistema de interação.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Preservar Casa Voss → Estrada do Rio → Arco e manter o Arco físico em Z aproximado 92 |
| Desempenho | Não acrescentar luzes dinâmicas, partículas ou emissão azul persistente |
| Jogabilidade | O cairn fica fora do leito de 4,15 m e não bloqueia `road_return_voss`, `road_to_arch` ou `positive_bridge` |
| Geometria | Usar pedras, laje e colisor coincidente; não usar painel, parede de árvores ou barreira invisível |
| Narrativa | O marco sugere a rota de retorno e a passagem de viajantes sem contradizer Miguel ou o Códice de Elias |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2`, manter as provas anteriores e acrescentar `[ORIGEM_R2_RIVER_CAIRN_OK]` antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

A fila seguinte será definida após a aprovação de `DEV2-R2-RIVER-CAIRN-004`, mantendo o estado `ACTIVE` e o trabalho contínuo rastreável no GitHub.
