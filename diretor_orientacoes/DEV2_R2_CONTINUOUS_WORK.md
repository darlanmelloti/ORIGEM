# Dev2 — Contrato de Trabalho Contínuo da Estrada do Rio

> **Regra operacional:** uma porta R2 aprovada nunca equivale a “ciclo concluído”. Equivale a “entrega atual aprovada; próxima tarefa Dev2 obrigatoriamente ativa”.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV2-R2-ORION-REFLECTION-002
owner: Dev2
branch: dev2/r2-river-road
```

## Entrega anterior aprovada — DEV2-R2-WORLD-LIFE-001

A camada de vida física foi concluída e passou a porta R2: `MarcoPedrasDeTomas`, `PassagemMargemBaixa` e `VestigioAntesDoArco` são volumes reais fora do leito da estrada, com colisores baixos apenas nos elementos pétreos. A prova `[ORIGEM_R2_WORLD_LIFE_OK]` agora é obrigatória na porta regional. A estrada, o Arco em Z aproximado 92 e o orçamento R2 de duas luzes permanecem preservados.

## Tarefa ativa — DEV2-R2-ORION-REFLECTION-002

A anomalia de Orion deve ganhar **leitura arqueológica física** na aproximação ao primeiro reflexo do rio, sem transformar a água em um painel luminoso ou criar emissão persistente. A entrega deve construir uma pequena estação de observação de margem, composta por dois vestígios de pedra baixos, um conjunto de lajes húmidas irregulares e marcas orientadas para o segmento do reflexo já existente. Ela deve reforçar a escolha narrativa de Tomás — **seguir as pedras, não a luz azul** — tornando o brilho um aviso que se observa de uma margem segura, e não um caminho que o jogador deve perseguir.

| Critério | Obrigatório |
|---|---|
| Escopo | R2 e documentos de Dev2; não editar `ForestLakeRegion.gd`, âncoras ou módulos R3–R6 sem integração aprovada |
| Cartografia | Preservar Casa Voss → Estrada do Rio → Arco e manter o Arco físico em Z aproximado 92 |
| Desempenho | Não acrescentar luzes dinâmicas R2; a reflexão atual deve manter o pulso localizado e transparente |
| Jogabilidade | A estação deve ficar fora do leito de 4,15 m da estrada e não bloquear `road_return_voss`, `road_to_arch` ou `positive_bridge` |
| Geometria | Usar rochas, pilares e lajes reais; não usar painéis, árvores em parede, emissões para mascarar a água ou colisores invisíveis na rota |
| Narrativa | A estação deve ser anterior ou lateral ao primeiro reflexo (Z 43–56), com leitura segura a partir da margem |
| Verificação | Executar `tools/qa/run_regional_gate.sh R2`, manter a prova de vida física e acrescentar uma prova específica da estação antes de abrir PR |

## Fecho e avanço obrigatório

Dev2 só pode fechar a tarefa quando o commit estiver publicado, a porta R2 estiver verde e uma nova secção **Tarefa ativa** tiver substituído esta, com outro `task_id`. Se a tarefa for concluída sem substituição, a esteira regional abre automaticamente um item de continuidade no GitHub e mantém o estado operacional como **ACTIVE**.

## Próxima fila reservada

`DEV2-R2-TRAVELLER-REST-003` deverá criar uma pequena leitura de descanso/observação à margem da estrada depois da tarefa atual ser aprovada, sem tornar a Região 2 num acampamento de R5.
