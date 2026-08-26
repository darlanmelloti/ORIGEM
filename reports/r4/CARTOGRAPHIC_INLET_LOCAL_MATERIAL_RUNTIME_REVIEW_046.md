# ORIGEM — Revisão Runtime do Material Local do Afluente R4 046

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-LOCAL-MATERIAL-RUNTIME-REVIEW-046`
**Estado:** Revisão runtime aprovada, sem alteração de produção
**Rota capturada:** `arch_to_forest`
**Spawn confirmado:** `(-9.0, 1.319562, 107.0)`
**Estabilização:** 12 segundos

## Resultado da captura

A captura runtime canónica foi executada depois da instalação do material local R4 e confirma a mitigação do plano claro opaco que motivou as tarefas 044 e 045. A superfície dominante clara não aparece no primeiro plano da rota `arch_to_forest`. O afluente é lido apenas como uma faixa estreita azul-esverdeada escura junto ao relevo esquerdo, coerente com a redução local de opacidade e emissão.

| Comparação | Evidência 043 | Revisão 046 |
|---|---|---|
| Superfície clara no primeiro plano | Identificada como opaca e de grande escala | Não observada como elemento dominante |
| Hipótese técnica | Geometria do afluente com material lacustre opaco | Confirmada e mitigada por material local exclusivo R4 |
| Geometria, rota e corredor | Não alterados | Mantidos |
| Material lacustre R6 | Não alterado | Mantido |
| Alteração de produção nesta revisão | Não aplicável | Nenhuma |

A captura, o log de execução e a análise visual estão preservados em `reports/r4/cartographic_inlet_runtime_review_046/`. O primeiro método de captura encontrou ausência do utilitário X11 de imagem; a evidência final foi gerada pela ferramenta canónica após disponibilizar essa dependência no ambiente de QA. Não houve modificação de ficheiro de produção durante a revisão.

## Garantias preservadas

| Restrição | Estado |
|---|---|
| Clareira Orion (`Z≈126–151`) | Intacta |
| Corredor e trilho físico | Inalterados; garantia acumulada `≥8 m` preservada |
| Lajes, rota, câmara e âncoras | Sem alteração |
| Luzes, colisores, partículas, vento, animação, física e pós-processamento | Sem alteração |
| Material lacustre e água R6 | Sem alteração |
| R5 e R6 | Sem alteração de activos, lógica, iluminação ou rotas |

## Verificação

| Verificação | Resultado |
|---|---|
| Captura runtime `arch_to_forest` | `[ORIGEM_REGIONAL_RUNTIME_CAPTURE_OK]` |
| Parser Godot headless | Aprovado |
| Auditoria de orçamento | `[QA-BUDGET-01] result=PASS` |
| Porta regional | `[GATE:R4] PASS` |
| `arch_to_forest` | Aprovada |
| `forest_to_majestic` | Aprovada |
| `forest_to_ruins` | Aprovada |

Os avisos `Parameter "material" is null` que possam surgir no encerramento dos harnesses headless pertencem ao backend dummy após o sucesso das validações. Não foram observados erros de parser, script, shader ou falhas fatais nesta passagem.

## Continuidade

A correcção local está agora confirmada por QA estrutural, gates e captura runtime. A sucessão activa é `DEV4-R4-CARTOGRAPHIC-INLET-LOCAL-MATERIAL-STABILIZATION-047`, limitada a uma estabilização documental: confirmar a ponta remota, conservar a evidência 044–046 e não criar nem alterar produção sem um novo contrato canónico.
