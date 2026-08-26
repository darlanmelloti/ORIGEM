# R6 — Auditoria de Material e Silhueta Arqueológica

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002` |
| **Estado** | Concluída em QA; decisão de produção pendente do dono R6 |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Rota preservada** | `forest_to_ruins` |
| **Alterações de produção** | Nenhuma |
| **Luzes QA criadas** | Zero |
| **Colisores QA criados** | Zero |
| **Materiais de produção escritos** | Zero |

## Método

A auditoria cruzou a captura runtime canónica `forest_to_ruins_postload.png`, o construtor existente `ForestLakeRegion.gd`, a rota canónica e duas sondas Dev7 isoladas. `r6_archaeology_inventory.py` reproduz apenas fórmulas espaciais já existentes para calcular a distância dos elementos ao percurso; `r6_archaeology_material_probe.gd` cria um material temporário fora da árvore de produção e calcula a diferença de contraste contra o albedo de terreno. Nenhuma cena, recurso regional, água, luz, física, câmara, Player ou ancoragem foi escrita.

> A imagem runtime confirma que a via de lajes é legível, mas a margem, as formas arqueológicas e o destino competem com terreno genérico, água de recorte rígido e elementos de baixo detalhe. A hierarquia precisa ser dirigida por **silhueta e material dos elementos já existentes**, não por luz, partículas, colisores ou geometria nova.

## Inventário espacial elegível

O inventário integral, com fórmulas e distâncias calculadas, está em [`R6_ARCHAEOLOGY_INVENTORY.md`](R6_ARCHAEOLOGY_INVENTORY.md). Para a rota `forest_to_ruins`, cinco elementos existentes formam a faixa de decisão: três vestígios de aproximação e os dois vestígios do limiar da bacia. Os pilares, marcos, domo e estela internos do lago ficam fora do corredor técnico imediato e não devem ser incluídos na primeira decisão de material.

| Elemento existente | Forma | Distância mínima à rota | Leitura no percurso | Material atual |
|---|---|---:|---|---|
| `VestigioDeAproximacaoBacia_01` | Pilar inclinado | 10,72 m | Silhueta lateral média; visível antes da margem, mas insuficiente como marco. | `ruin_material` |
| `VestigioDeAproximacaoBacia_02` | Pilar inclinado | 11,67 m | Contraponto lateral médio; não deve aproximar-se do trilho. | `ruin_material` |
| `VestigioDeAproximacaoBacia_03` | Pilar inclinado | 8,59 m | Último indício lateral antes da bacia; melhor candidato para material mais legível. | `ruin_material` |
| `VestigioDaEntradaDaBacia_00` | Pilar emergente | 4,36 m | Marco esquerdo da chegada, próximo mas exterior à faixa de lajes. | `ruin_material` |
| `VestigioDaEntradaDaBacia_01` | Pilar emergente | 4,68 m | Marco direito da chegada, próximo mas exterior à faixa de lajes. | `ruin_material` |
| `PilarSubmerso_00…07` | Oito pilares submersos | 32,84–73,95 m | Leitura de bacia posterior; fora da primeira intervenção. | `ruin_material` |
| `MarcoRuinaEmergente_00…02` | Três pilares altos emergentes | 34,13–68,03 m | Silhuetas internas do lago; fora da primeira intervenção. | `ruin_material` |
| `DomoSubmersoDoHub` | Cúpula achatada | 53,34 m | Foco distante do complexo; fora da primeira intervenção. | `ruin_material` |
| `EstelaDaChegada` | Estela vertical | 38,47 m | Interação na margem interna; fora da primeira intervenção. | `ruin_material` |

## Auditoria de contraste QA

O material arqueológico atual é `Color(0,48; 0,52; 0,45)` com rugosidade `0,95`, sem emissão. O teste transitório propôs `Color(0,56; 0,55; 0,47)` e rugosidade `0,88`, mantendo emissão desativada. Contra o albedo de terreno de referência `Color(0,28; 0,36; 0,23)`, a sonda mediu melhoria de 23,1% na diferença de luminância e de 22,9% na distância cromática. O teste não criou `Light3D`, colisores ou escritas de produção.

| Perfil avaliado | Δ de luminância | Distância cromática | Rugosidade | Emissão | Resultado |
|---|---:|---:|---:|---|---|
| `ruin_material` existente | 0,1728 | 0,3376 | 0,95 | Desativada | Base arqueológica segura, mas com leitura frágil no terreno verde e sob a água. |
| Override QA proposto | 0,2127 | 0,4148 | 0,88 | Desativada | Maior separação de silhueta sem aumentar luz, geometria ou física. |

## Única recomendação modular

### R6-ARCHAEOLOGY-CONTRAST-PROFILE-003 — Perfil de Contraste de Entrada da Bacia

Propõe-se **uma única decisão de produção para Dev6**: aplicar, apenas aos cinco vestígios existentes da aproximação e do limiar acima, um override de material regional com a mesma textura arqueológica existente (`MOSSY_RUIN_DIFF` e normal existente), albedo moderadamente mais quente/legível e rugosidade ligeiramente inferior. A alteração não cria mesh, nó, luz, água, partícula, colisor ou área; não muda posição, escala, rotação, rota, largura de trilho ou ancoragem. A simulação serve para confirmar contraste, não para autorizar a alteração automática.

| Restrição | Compromisso da recomendação |
|---|---|
| **Dono e decisão** | Dev6/R6 decide e implementa somente após validação regional explícita. |
| **Geometria** | Reutiliza exclusivamente os cinco pilares existentes; zero meshes novos. |
| **Material** | Override local e modular, sem emissão; não altera a água nem o material partilhado globalmente. |
| **Luzes** | Zero adições; R6 permanece com exatamente quatro luzes. |
| **Física** | Zero colisores, áreas, mudanças de massa ou navegação. |
| **Cartografia** | Sem alteração de `CartographicAnchors.gd`, rota ou largura. |
| **Handoff** | Não toca no handoff R6→R7 nem antecipa conteúdo R7. |
| **Risco** | Baixo, porque é reversível e limitado a referências de material existentes. |

## Gates obrigatórios antes da decisão R6

A decisão do dono R6 deverá executar parser Godot 4.7.1, `git diff --check`, gate R6, auditoria de luz R6 e rota `forest_to_ruins`. A captura runtime deve permanecer 16:9, não mostrar ecrã de arranque e demonstrar a mesma faixa livre de lajes.

## Evidências

| Evidência | Localização |
|---|---|
| Captura runtime canónica | `forest_to_ruins/forest_to_ruins_postload.png` |
| Inventário espacial calculado | `R6_ARCHAEOLOGY_INVENTORY.md` |
| Sonda de inventário | `qa/dev7/r6_archaeology_inventory.py` |
| Sonda de override de material | `qa/dev7/r6_archaeology_material_probe.gd` |
| Medição de contraste | `R6_MATERIAL_PROBE.log` |
| Orientação de trabalho | `diretor_orientacoes/DEV7_VISUAL_PLAYABLE_PHYSICS_CONTINUOUS_WORK.md` |
