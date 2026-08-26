# R6 — Revisão de Evidências Arqueológicas 004

| Campo | Resultado |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-EVIDENCE-REVIEW-004` |
| **Âmbito** | QA documental; sem runtime novo, override novo ou mutação de produção |
| **Região dona** | R6 — Ruínas Submersas / Dev6 |
| **Rota protegida** | `forest_to_ruins` |
| **Conclusão de produção** | A variante de material continua **rejeitada**; não existe recomendação para implementar. |

## Questão da revisão

A proposta arquivada `...CONTRAST-PROPOSAL-003` descreve **cinco vestígios próximos do corredor**. Já a auditoria integrada e a captura comparativa `...OVERRIDE-CAPTURE-003` descrevem **quatro marcos**. Esta revisão determina se se trata do mesmo conjunto de objetos e se o enquadramento já é inequívoco para uma decisão regional.

> **Resultado:** não. Os dois artefactos tratam de conjuntos distintos e a captura usa quatro **prefixos de categoria**, não um conjunto estável de quatro objetos com identidade espacial explícita. A rejeição da variante permanece válida para a composição capturada, mas não deve ser extrapolada para os cinco vestígios de entrada nem convertida em uma alteração de produção.

## Reconciliação dos conjuntos

| Conjunto | Origem | Definição | Cardinalidade documental | Relação com o outro conjunto |
|---|---|---|---:|---|
| **Vestígios de entrada** | Proposta arquivada `...PROPOSAL-003` | `VestigioDeAproximacaoBacia_01…03` e `VestigioDaEntradaDaBacia_00…01`. | 5 nós nomeados. | Conjunto de pilares próximo do percurso; não é selecionado pela captura comparativa integrada. |
| **Marcos auditados** | Auditoria/captura `...AUDIT-002` e `...CAPTURE-003` | Prefixos `EstelaDaChegada`, `MarcoRuinaEmergente_`, `PilarSubmerso_` e `AfloramentoChegadaRuinas_`. | 4 categorias de prefixo. | Conjunto de tipos arqueológicos distribuídos pela bacia; não equivale aos cinco vestígios de entrada. |

A diferença é estrutural. Os cinco vestígios de entrada são criados com nomes individuais e ficam na aproximação/limiar da bacia. Os quatro marcos da captura são procurados pelo primeiro mesh encontrado para cada prefixo. Assim, o número quatro é a contagem de **categorias selecionadas pelo runner**, e não uma garantia de que existem somente quatro objetos arqueológicos relevantes no mundo.

| Prefixo da captura QA | Multiplicidade conhecida no construtor R6 | Semântica efetiva do runner atual |
|---|---:|---|
| `EstelaDaChegada` | 1 | Seleciona a estela única. |
| `MarcoRuinaEmergente_` | 3 | Seleciona apenas o primeiro mesh encontrado. |
| `PilarSubmerso_` | 8 | Seleciona apenas o primeiro mesh encontrado. |
| `AfloramentoChegadaRuinas_` | 3 | Seleciona apenas o primeiro mesh encontrado. |

## Enquadramento e suficiência da prova existente

A captura 003 calcula o foco pela média das posições dos quatro meshes retornados pelos prefixos e posiciona uma câmara QA temporária relativamente a esse ponto. Este é um enquadramento válido para comparar **aquela seleção de quatro instâncias**, porque baseline e override compartilham câmara, luzes, transformações e rota. A prova também confirmou quatro luzes R6, zero escritas de produção e restauração dos overrides.

Porém, o enquadramento não satisfaz a hipótese da proposta arquivada: os cinco pilares próximos não são os objetos selecionados, e o campo de visão não é contratado a partir do corredor `forest_to_ruins` nem de uma lista de NodePaths. Consequentemente, o número de píxeis diferentes e o RMSE da captura são evidência de uma diferença técnica na seleção de quatro categorias, mas não demonstram efeito perceptível sobre os cinco vestígios do limiar.

| Pergunta de decisão | Resposta da revisão 004 | Implicação |
|---|---|---|
| A captura 003 aprovou um override de produção? | **Não.** A própria auditoria rejeitou a variante como não perceptível. | Produção permanece bloqueada. |
| Os quatro marcos são os cinco vestígios de entrada? | **Não.** Nomes, localização e mecanismo de seleção diferem. | Não combinar as duas contagens em um único resultado. |
| O par de imagens é repetível? | **Parcialmente.** É reproduzível com a ordem atual da árvore, mas não define explicitamente as instâncias múltiplas por `NodePath`. | Não usar como prova definitiva de um conjunto diferente. |
| Existe hoje alvo e enquadramento inequívocos para decisão de Dev6/R6? | **Não.** | Abrir apenas uma especificação QA de registo de alvos; não criar nova variante nem produção. |

## Decisão documental

A revisão 004 arquiva a proposta de cinco vestígios como uma hipótese de entrada distinta e conserva a rejeição da captura 003 como decisão limitada aos quatro prefixos que o runner selecionou. Não há autorização para repetir a variante, aumentar contraste, mudar luzes, aproximar câmara do jogador, deslocar nós ou modificar produção. A única continuação segura é formalizar um **registo QA de alvos e enquadramento**, sujeito a decisão posterior de Dev6/R6.

## Especificação mínima para a próxima auditoria QA

A tarefa sucessora deve permanecer documental e produzir um registo que fixe, antes de qualquer novo teste, os seguintes itens:

| Campo do registo | Requisito |
|---|---|
| **Identidade** | Nome completo e `NodePath` de cada mesh candidato, sem seleção por prefixo aberto. |
| **Conjunto** | Um único conjunto declarado: cinco vestígios de entrada **ou** uma seleção de marcos da bacia; nunca ambos implicitamente. |
| **Geometria** | Posição, rotação, escala e material de origem documentados; nenhuma alteração permitida. |
| **Câmara** | Pose, FOV, resolução 1600×900 e relação com a rota declaradas antes da captura. |
| **Invariantes** | Quatro luzes R6, rota `forest_to_ruins`, água, colisão, Player, câmara de jogador e handoff R6→R7 preservados. |
| **Critério visual** | Uma hipótese legível e falsificável, aprovada pelo dono R6 antes de qualquer futura captura QA. |

## Referências internas

[1] `levels/ForestLakeRegion.gd`, linhas de criação de `VestigioDeAproximacaoBacia_*`, `VestigioDaEntradaDaBacia_*` e `AfloramentoChegadaRuinas_*`.

[2] `qa/regions/verify_dev7_r6_archaeology_material_silhouette.gd`, lista de quatro prefixos auditados.

[3] `qa/regions/capture_dev7_r6_archaeology_override.gd`, seleção do primeiro mesh por prefixo, pose QA e invariantes da captura.

[4] `reports/dev7/r6_archaeology_override_capture_003/VISUAL_AUDIT.md`, resultado rejeitado da captura comparativa.

[5] `reports/dev7/visual_playable_physics_baseline_001/R6_ARCHAEOLOGY_CONTRAST_PROPOSAL_003.md`, proposta arquivada dos cinco vestígios de entrada.
