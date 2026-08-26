# ORIGEM — Captura Baseline do Afluente Cartográfico R4 053

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-BASELINE-CAPTURE-053`
**Estado:** Baseline QA aprovado; nenhuma candidata modular criada

## Evidência runtime

A rota canónica `arch_to_forest` foi capturada após estabilização de 12 segundos, no viewport 1600×900 (16:9). O spawn foi confirmado em `(-9.0, 1.319562, 107.0)` e a imagem está preservada em `reports/r4/cartographic_inlet_baseline_053/arch_to_forest_postload.png`.

A captura regista a leitura actual do afluente: a superfície ampla clara/opaca mantém-se visível no primeiro plano. Esta leitura é o baseline formal para qualquer comparação futura que receba aprovação explícita conjunta R4/R6. Não foi instalada candidata e a captura não altera a conclusão canónica de que transparência, cota, largura e `cull_back` permanecem rejeitados.

| Critério | Resultado |
|---|---|
| Rota | `arch_to_forest` aprovada e capturada |
| Viewport | 1600×900 (16:9) |
| Estabilização | 12 segundos após spawn |
| Candidata modular | Ausente |
| Material e água partilhados | Sem override local nesta tarefa |
| Produção | Nenhuma alteração |

## Preservação regional

| Limite | Estado |
|---|---|
| Clareira Orion `Z≈126–151` | Sem alteração |
| Corredor R4 `≥8 m` | Sem alteração |
| Raízes R4 inventariadas | Não modificadas |
| Água, quatro luzes e handoff R6 | Sem alteração |
| R5, rota, câmara, âncoras e física | Sem alteração |

## Validação

| Verificação | Resultado |
|---|---|
| Captura runtime | `[ORIGEM_REGIONAL_RUNTIME_CAPTURE_OK]` |
| Parser Godot headless | Aprovado |
| Auditoria de orçamento | `[QA-BUDGET-01] result=PASS` |
| Porta R4 | `[GATE:R4] PASS` |
| `arch_to_forest` | Aprovada |
| `forest_to_majestic` | Aprovada |
| `forest_to_ruins` | Aprovada |

Os avisos de material nulo que possam ser emitidos no fim de harnesses headless pertencem ao backend dummy após o sucesso das verificações; não são uma regressão observada nesta passagem.

## Sucessão

A tarefa activa seguinte é `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-BASELINE-ARCHIVE-054`. Ela é exclusivamente documental: deve indexar e confirmar a publicação da evidência baseline 053, sem criar candidata, executar comparação de variante ou alterar produção até existir aprovação canónica conjunta R4/R6.
