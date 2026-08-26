# R6 — Proposta Modular de Contraste Arqueológico

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-CONTRAST-PROPOSAL-003` |
| **Estado** | Proposta QA pronta para decisão explícita de Dev6/R6 |
| **Implementação de produção por Dev7** | Não autorizada |
| **Base de evidência** | `R6_ARCHAEOLOGY_MATERIAL_SILHOUETTE_AUDIT.md` e `R6_ARCHAEOLOGY_INVENTORY.md` |
| **Rota protegida** | `forest_to_ruins` |

## Decisão solicitada ao dono R6

Dev7 propõe que Dev6 avalie uma única intervenção material, reversível e limitada aos cinco pilares arqueológicos já existentes na aproximação e no limiar da bacia. A proposta não adiciona qualquer asset, luz, colisão, área, nó, água, partícula, geometria ou modificação de rota. Também não substitui a textura arqueológica existente; apenas descreve um perfil de override local para reforçar a leitura de silhueta em GL Compatibility.

> **Decisão requerida:** aprovar ou rejeitar o perfil de contraste local R6. Sem aprovação explícita do dono R6, o estado permanece exclusivamente QA.

## Conjunto de alvos imutável

| Nó existente | Justificação | Distância à rota | Ação proposta |
|---|---|---:|---|
| `VestigioDeAproximacaoBacia_01` | Primeiro indício lateral de civilização antes da margem. | 10,72 m | Override local de material. |
| `VestigioDeAproximacaoBacia_02` | Contraponto da aproximação, preservando o eixo aberto. | 11,67 m | Override local de material. |
| `VestigioDeAproximacaoBacia_03` | Último indício antes da bacia; melhora a continuidade de leitura. | 8,59 m | Override local de material. |
| `VestigioDaEntradaDaBacia_00` | Marco emergente esquerdo, exterior à faixa de lajes. | 4,36 m | Override local de material. |
| `VestigioDaEntradaDaBacia_01` | Marco emergente direito, exterior à faixa de lajes. | 4,68 m | Override local de material. |

Os pilares submersos, marcos internos, domo e estela de chegada não pertencem a esta proposta. A exclusão reduz risco de interação com água, handoff R6→R7 e leitura posterior do lago.

## Perfil proposto

| Propriedade | Estado atual | Perfil QA candidato | Limite |
|---|---|---|---|
| Textura albedo | `MOSSY_RUIN_DIFF` | Reutilizar a mesma textura existente. | Não criar nem importar textura. |
| Textura normal | `MOSSY_RUIN_NORMAL` | Reutilizar a mesma textura existente. | Não criar nem importar normal map. |
| Albedo | `(0,48; 0,52; 0,45)` | `(0,56; 0,55; 0,47)` | Manter mineral, sem branco/alto brilho. |
| Rugosidade | `0,95` | `0,88` | Manter acabamento mate. |
| Emissão | Desativada | **Desativada** | Não usar brilho azul emissivo. |
| Luzes | R6: quatro | **Sem alteração** | Não criar `Light3D`. |
| Física | Colisores existentes | **Sem alteração** | Não criar, remover ou mover colisores. |

A medição QA prevê aumento de 23,1% da diferença de luminância e 22,9% da distância cromática contra o terreno de referência, com emissão desativada. O perfil melhora separação de figura/fundo sem depender de pós-processamento ou iluminação adicional.

## Roteiro de implementação para Dev6 — somente após aprovação

| Ordem | Ação permitida | Proibição correspondente | Evidência requerida |
|---:|---|---|---|
| 1 | Criar um material local R6 ou referências de override para os cinco nós listados. | Não editar o `ruin_material` partilhado globalmente. | Lista de referências de material. |
| 2 | Reutilizar `MOSSY_RUIN_DIFF` e `MOSSY_RUIN_NORMAL`; aplicar o perfil albedo/rugosidade candidato. | Não introduzir texturas, emissão ou shader novo. | Inspeção de recurso e captura 16:9. |
| 3 | Preservar posição, rotação, escala e nós dos cinco pilares. | Não deslocar geometria, estreitar trilho ou criar marco novo. | Diff espacial e rota `forest_to_ruins`. |
| 4 | Manter as quatro luzes R6 e toda a água tal como estão. | Não alterar água, `Light3D`, cascatas ou handoff R6→R7. | Auditoria R6 de luz e gate R6. |
| 5 | Executar parser, `git diff --check`, gate R6 e captura runtime. | Não declarar resultado com parser, rota ou orçamento falhados. | Logs e captura pós-mudança. |

## Critérios de aceite para a decisão R6

A produção somente será elegível se o frame `forest_to_ruins` mantiver as lajes livres e tornar os cinco pilares distinguíveis do terreno sem criar brilho azul excessivo. O orçamento deve continuar exatamente em quatro luzes R6, e `forest_to_ruins` deve completar sem novo colisor ou alteração de largura. Qualquer diferença de física, água, ancoragem ou handoff invalida a candidata e exige nova revisão.

## Transferência de responsabilidade

| Papel | Responsabilidade |
|---|---|
| **Dev7** | Entregou o inventário, a medição de contraste, a proposta de baixo risco e o roteiro de validação. |
| **Dev6 / R6** | Decide, implementa se aprovado, executa os gates e conserva a propriedade regional. |
| **Dev7 após decisão** | Revisa evidência pós-implementação em QA; não altera produção sem nova autorização. |

## Referências internas

[1] `levels/ForestLakeRegion.gd`, construtor existente dos pilares e material arqueológico R6.
[2] `reports/dev7/visual_playable_physics_baseline_001/R6_ARCHAEOLOGY_INVENTORY.md`, inventário espacial QA.
[3] `reports/dev7/visual_playable_physics_baseline_001/R6_ARCHAEOLOGY_MATERIAL_SILHOUETTE_AUDIT.md`, resultado da auditoria e medição QA.
[4] `diretor_orientacoes/DEV7_VISUAL_PLAYABLE_PHYSICS_CONTINUOUS_WORK.md`, fronteiras de trabalho Dev7.
