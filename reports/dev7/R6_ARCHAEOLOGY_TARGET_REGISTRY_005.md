# R6 — Registo QA de Alvos e Enquadramento Arqueológico 005

| Campo | Estado |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-TARGET-REGISTRY-005` |
| **Âmbito** | QA de leitura e registo; zero captura comparativa, zero variante material e zero escrita de produção |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Rota protegida** | `forest_to_ruins` |
| **Decisão regional** | Não solicitada por esta tarefa; produção continua rejeitada e bloqueada. |

## Resultado

O enumerador QA confirmou que há dois conjuntos arqueológicos distintos. O conjunto de entrada contém cinco meshes explicitamente identificáveis e é o único conjunto de corredor que pode, numa decisão futura, ser referido de forma inequívoca. O conjunto da captura 003 não constitui quatro objetos únicos: são quatro prefixos que abrangem **15 meshes** no mundo R6. Como o runner histórico seleciona o primeiro mesh de cada prefixo sem emitir os `NodePaths` escolhidos, o seu resultado continua válido apenas para a composição capturada e não é uma definição reutilizável de alvo.

> **Decisão de QA:** nenhum novo teste, override, material ou alteração de produção é autorizado por este registo. Qualquer avaliação futura exige aprovação explícita de Dev6/R6 para **um único conjunto declarado** e para uma hipótese visual nova, depois da rejeição da variante 003.

## Conjunto registado para eventual decisão futura

### `R6-ENTRY-VESTIGES-05`

Este conjunto documenta os cinco pilares já existentes que compõem a aproximação e o limiar da bacia. Os caminhos são relativos à instância de `ForestLakeRegion`; o prefixo `/root/Dev7R6TargetRegistryWorld/R6RuntimeRegistry/` da sonda é transitório e não deve ser guardado como referência de produção.

| ID | Mesh relativo a `ForestLakeRegion` | Nó dono | Posição global QA X/Y/Z | Papel espacial |
|---|---|---|---|---|
| E01 | `SilhuetasDeAproximacaoDaBacia/VestigioDeAproximacaoBacia_01/stone_tallC` | `VestigioDeAproximacaoBacia_01` | `(-0,286; 0,141; 200,003)` | Primeiro indício lateral da bacia. |
| E02 | `SilhuetasDeAproximacaoDaBacia/VestigioDeAproximacaoBacia_02/stone_tallC` | `VestigioDeAproximacaoBacia_02` | `(24,226; 0,135; 213,996)` | Contraponto lateral antes do limiar. |
| E03 | `SilhuetasDeAproximacaoDaBacia/VestigioDeAproximacaoBacia_03/stone_tallC` | `VestigioDeAproximacaoBacia_03` | `(4,821; 0,146; 221,002)` | Último indício de aproximação. |
| E04 | `LimiarDasRuinasSubmersas/VestigioDaEntradaDaBacia_00/stone_tallC` | `VestigioDaEntradaDaBacia_00` | `(9,651; 0,256; 225,289)` | Marco esquerdo do limiar, exterior às lajes. |
| E05 | `LimiarDasRuinasSubmersas/VestigioDaEntradaDaBacia_01/stone_tallC` | `VestigioDaEntradaDaBacia_01` | `(18,344; 0,270; 226,717)` | Marco direito do limiar, exterior às lajes. |

O registo só identifica referências. Não altera posição, rotação, escala, material, colisor, água ou rota.

## Conjunto histórico excluído de reutilização

### `R6-CAPTURE-CATEGORIES-04`

O conjunto histórico da captura 003 deve ser retido como evidência de rejeição, mas não deve ser reutilizado para selecionar alvos futuros por prefixo. A enumeração prova a sua multiplicidade efetiva.

| Prefixo histórico | Meshes enumerados | Estado no registo |
|---|---:|---|
| `EstelaDaChegada` | 1 | Categoria individual, mas fora do conjunto de entrada. |
| `MarcoRuinaEmergente_` | 3 | Categoria múltipla; o runner histórico escolhe somente o primeiro mesh encontrado. |
| `PilarSubmerso_` | 8 | Categoria múltipla; o runner histórico escolhe somente o primeiro mesh encontrado. |
| `AfloramentoChegadaRuinas_` | 3 | Categoria múltipla; o runner histórico escolhe somente o primeiro mesh encontrado. |
| **Total** | **15** | Não é um conjunto de quatro instâncias inequívocas. |

## Contrato de enquadramento para qualquer futura decisão QA

A captura 003 histórica utilizou 1600×900, OpenGL Compatibility/Xvfb, FOV de 57° e uma câmara temporária focada na média de quatro meshes selecionados por prefixo. Esta pose deve ser tratada como **evidência histórica**, não como contrato de uma avaliação futura dos cinco vestígios.

| Campo | Regra obrigatória antes de qualquer futura captura QA |
|---|---|
| **Conjunto de alvos** | Declarar exatamente um ID de conjunto. A única referência de corredor disponível é `R6-ENTRY-VESTIGES-05`. |
| **Identidade** | Emitir nome e `NodePath` relativo de todos os meshes, antes e depois do frame. É proibido procurar apenas pelo primeiro prefixo correspondente. |
| **Hipótese** | Dev6/R6 deve aprovar uma hipótese visual falsificável antes da execução; esta tarefa não cria uma. |
| **Câmara QA** | Declarar pose, FOV e relação com a rota antes da baseline. A mesma pose deve ser usada na variante, sem substituir a câmara do jogador. |
| **Resolução** | Fixar 1600×900, 16:9, e indicar backend de renderização no log. |
| **Invariantes** | Quatro luzes R6, água, rota `forest_to_ruins`, Player, câmara de jogador, colisores, ancoragens e handoff R6→R7 devem permanecer inalterados. |
| **Material** | Não criar material, override ou variante sem autorização explícita posterior de Dev6/R6. |
| **Saída** | Registrar transformações, contagem de luzes, conjunto de caminhos, diferenças de frame e decisão visual explícita. |

## Verificação da sonda

A sonda `qa/dev7/list_r6_archaeology_target_registry.gd` instanciou somente o módulo regional num mundo QA transitório e enumerou os caminhos sem criar `Light3D`, colisores ou overrides. O log confirma `production_mutations=0`, `created_light3d=false`, `created_collision=false` e `created_override=false`.

| Verificação | Resultado |
|---|---|
| Vestígios de entrada identificados | 5/5 |
| Categorias históricas enumeradas | 4/4 |
| Meshes cobertos pelas categorias históricas | 15 |
| Escritas de produção | 0 |
| Luzes QA criadas | 0 |
| Colisores QA criados | 0 |
| Overrides QA criados | 0 |

## Referências internas

[1] `reports/dev7/R6_ARCHAEOLOGY_EVIDENCE_REVIEW_004.md`, decisão de manter a rejeição e separar os conjuntos.

[2] `reports/dev7/R6_ARCHAEOLOGY_TARGET_REGISTRY_005.log`, enumeração runtime QA de nomes, caminhos, posições e invariantes.

[3] `qa/dev7/list_r6_archaeology_target_registry.gd`, sonda somente de leitura.

[4] `qa/regions/capture_dev7_r6_archaeology_override.gd`, comportamento histórico de seleção por prefixo e enquadramento 003.

[5] `reports/dev7/r6_archaeology_override_capture_003/VISUAL_AUDIT.md`, resultado rejeitado da variante temporária.
