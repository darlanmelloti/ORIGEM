# Dev4 — Contrato de Trabalho Contínuo da Floresta Densa

> **Regra operacional:** a aprovação da R4 nunca encerra o Dev4. Cada entrega deve ser publicada, validada e sucedida imediatamente por uma nova tarefa R4 ativa e rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV4-R4-MIST-LAYER-002
owner: Dev4
branch: dev4/r4-dense-forest
```

## Base oficial e fronteira

A base de trabalho é o repositório oficial do ORIGEM, branch canónica `dev4/r4-dense-forest`, sincronizada por avanço rápido com `integration/r1-r6-sprint1`. O arquivo do jogo entregue pelo Diretor é representado por esta base versionada; novas cópias ZIP/RAR não são necessárias para iniciar trabalho.

A R4 mantém a âncora cartográfica `(-9, 116)`, ocupa a transição entre o Arco e o Acampamento Majestic e conserva a rota `arch_to_forest` → `forest_to_majestic`. A geometria compartilhada atual está em `levels/ForestLakeRegion.gd`; o conteúdo Dev4 deve ser novo e modular sob `levels/regions/r4/`, sendo a montagem no mundo feita de modo aditivo e rastreável.

## Correção obrigatória de base

A auditoria encontrou quatro balizas Omni em `_build_forest_wayfinding`, embora o contrato R4 permita no máximo uma luz dinâmica local. A primeira entrega deve normalizar este legado para uma única baliza dinâmica ou nenhuma, sem escurecer a rota nem transferir a responsabilidade de luz para R3 ou R5.

## Entrega aprovada — DEV4-R4-CLEARING-SIGHTLINE-001

`R4ClareiraDaVisadaOrion` foi instalada com quatro quadros laterais de afloramento baixo e oito fetos distribuídos fora do eixo. Não cria luzes nem colisores. A normalização das balizas preserva quatro brasas visuais, mas deixa apenas `LuzBalizaFlorestalUnica` como luz dinâmica local R4. A prova `[ORIGEM_R4_CLEARING_OK]` confirma a clareira, quatro quadros e exatamente uma baliza dinâmica.

## Tarefa ativa — DEV4-R4-MIST-LAYER-002

Refinar a **neblina baixa da transição R4** com uma camada local subtil e sem pós-processamento pesado. A entrega deve reforçar profundidade entre as massas laterais, preservar a abertura para Orion e a leitura da saída para Majestic. Não pode usar planos de névoa, partículas densas, luzes, volumes opacos ou qualquer elemento que reduza a visibilidade do trilho.

| Critério | Obrigatório |
|---|---|
| Escopo | R4 e documentação Dev4; não editar âncoras, `RiverRoadJourney.gd` ou módulos R1–R3/R5–R6 |
| Cartografia | Preservar as três rotas R4 e a clareira aprovada em Z≈130–147 |
| Atmosfera | Apenas material/efeito local subtil e leve; nenhuma parede de névoa, painel, partículas densas ou pós-processamento global |
| Visibilidade | Orion e a direção de Majestic devem continuar legíveis entre as copas |
| Luz | Zero luz dinâmica nova; manter uma única baliza dinâmica local R4 |
| Verificação | Executar `tools/qa/run_regional_gate.sh R4`, `[ORIGEM_R4_CLEARING_OK]` e uma prova específica de atmosfera antes de abrir PR |

## Fecho e avanço obrigatório

Dev4 só pode fechar a tarefa após commit publicado, porta R4 aprovada e substituição por outra **Tarefa ativa** com novo `task_id`. A esteira deve manter uma única issue `[Dev4 Continuous]` aberta e encerrar automaticamente qualquer item Dev4 obsoleto.

## Próxima fila reservada

`DEV4-R4-ORION-CLEARING-LORE-003` deverá acrescentar leitura ambiental à clareira depois da tarefa atmosférica, sem nova interface ou revelação narrativa precoce.
