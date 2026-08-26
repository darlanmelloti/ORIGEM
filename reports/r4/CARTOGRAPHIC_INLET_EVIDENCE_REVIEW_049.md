# R4 — Revisão QA de Evidências do Afluente Cartográfico 049

| Campo | Valor |
|---|---|
| **Task ID** | `DEV4-R4-CARTOGRAPHIC-INLET-EVIDENCE-REVIEW-049` |
| **Estado** | Concluída exclusivamente em QA documental. |
| **Escopo** | Reconciliar diagnóstico R4 044, revisão de variantes 047 e brief ambiental 048. |
| **Produção** | Nenhuma alteração em cena, `ForestLakeRegion.gd`, materiais, água, luz, geometria, câmara, colisão, âncoras ou rotas. |
| **Resultado** | Não há autorização de produção; uma candidata futura requer propriedade inequívoca R4/R6 e evidência runtime nova. |

## Síntese da evidência

A investigação confirma que a faixa visível em `arch_to_forest` decorre de uma lâmina de água cartográfica ampla com material lacustre opaco e partilhado. As tentativas QA de transparência, alteração de cota, redução de largura e `cull_back` falharam em remover a leitura dominante e foram revertidas. Por isso, o diagnóstico não deve ser reinterpretado como autorização para uma nova microvariação do material ou da geometria.

> **Decisão QA:** a hipótese de correção por material/água permanece **rejeitada**. A única hipótese futura admissível é uma composição modular externa à lâmina, previamente delimitada e aprovada pelos donos R4 e R6.

## Matriz de responsabilidades

| Tema | Responsável primário | Responsável de validação | Limite não negociável |
|---|---|---|---|
| Clareira Orion, corredor e leitura da aproximação | Dev4 / R4 | Dev1 | Z≈126–151 livre; corredor físico ≥8 m; rotas R4 intactas. |
| Lâmina `LaminaDoAfluenteCartografico` e material lacustre | Dev6 / R6 | Dev4 + Dev1 | Não alterar transparência, cota, largura, culling ou recurso partilhado por iniciativa isolada. |
| Água, quatro luzes R6 e handoff R6→R7 | Dev6 / R6 | Dev1 | Exatamente quatro luzes R6; sem emissão nova, sem alteração de água ou de handoff. |
| Camada ambiental exterior à lâmina | Dev4 / R4, somente após aprovação conjunta | Dev6 + Dev1 | Sem parede vegetal, painel, efeito de ocultação, luz, partícula, colisor ou invasão do corredor. |
| Captura e comparação runtime | Dev4 / QA | Dev6 + Dev1 | Mesmo enquadramento `arch_to_forest`, viewport gráfico 16:9, baseline e candidata temporária separadas. |

## Hipóteses e decisão

| Hipótese | Estado | Fundamentação |
|---|---|---|
| Transparência do material partilhado | **Rejeitada** | Produziu faixa escura e leitura fragmentada. |
| Cota inferior da lâmina | **Rejeitada** | A faixa intrusiva persistiu. |
| Largura menor da lâmina | **Rejeitada** | A faixa intrusiva persistiu e elevaria risco cartográfico. |
| `cull_back` no material partilhado | **Rejeitada** | Não removeu a leitura dominante. |
| Ativo/margem modular exterior, descontínuo e afastado | **Não testada; não autorizada** | Só elegível após definição de proprietário, ativo, posição, distância ao corredor e captura QA. |

## Critérios de elegibilidade para uma futura candidata

Uma proposta de produção só é elegível quando todos os critérios seguintes existirem simultaneamente:

| Critério | Evidência mínima |
|---|---|
| Fonte causal | Nó, asset e transformação identificados antes de qualquer alteração. |
| Propriedade | Aprovação explícita de Dev4/R4 e Dev6/R6 por envolver leitura de água partilhada. |
| Não repetição | Diferença material da candidata face às quatro variantes rejeitadas. |
| Espacial | Distância comprovada ≥8 m ao corredor R4; nenhuma ocupação de Z≈126–151. |
| Visual | Par de capturas runtime `arch_to_forest` no mesmo enquadramento, com ganho legível sem mascaramento. |
| Técnico | Parser Godot 4.7.1, `git diff --check`, orçamento global, gate R4, gate R6 e rotas R4/R6 aprovados. |
| R6 | Quatro luzes, água, handoff R6→R7, lajes e colisores sem alteração. |

## Próxima sucessão

A revisão recomenda somente uma auditoria de **elegibilidade modular**. Essa auditoria deve inventariar ativos/margens existentes fora do corredor e produzir uma prova causal antes de sugerir qualquer mudança. Não pode gerar geometria, material, luz, colisor ou alteração de `ForestLakeRegion.gd`.

## Referências internas

[1] `reports/r4/CARTOGRAPHIC_INLET_ISOLATION_044.md`.

[2] `reports/r4/CARTOGRAPHIC_INLET_VARIANT_REVIEW_047.md`.

[3] `reports/r4/CARTOGRAPHIC_INLET_ENVIRONMENTAL_BRIEF_048.md`.

[4] `diretor_orientacoes/DEV4_R4_CONTINUOUS_WORK.md`.
