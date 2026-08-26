# ORIGEM — Prontidão de Captura Baseline do Afluente R4 052

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-CAPTURE-READINESS-052`
**Estado:** Prontidão documental aprovada; nenhuma captura de variante executada

## Verificação estática do baseline

A ferramenta canónica `tools/qa/capture_regional_runtime.sh` foi verificada sem execução de captura. A sintaxe do script é válida e todas as dependências necessárias estão disponíveis no ambiente QA: Godot 4.7.1, Xvfb, xdotool, ImageMagick `import` e `identify`.

| Controlo | Resultado |
|---|---|
| Script de captura | Sintaxe Bash aprovada |
| Viewport QA | `1600×900`, proporção 16:9 |
| Rota de baseline | Parâmetro canónico `arch_to_forest` |
| Spawn | Confirmado pelo marcador `[ORIGEM_QA_ROUTE] Spawn` no roteiro |
| Imagem de saída | `${rota}_postload.png`, registada apenas em directório de evidência |
| Gate R4 | Inclui `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` |
| Dependências de captura | Disponíveis |

## Separação obrigatória

A verificação não iniciou Godot em runtime, não gerou imagem, não criou candidata e não alterou produção. Uma futura tarefa de baseline só pode gravar a captura sem candidata. Uma eventual candidata, caso exista aprovação explícita conjunta R4/R6, deve ser criada e removida numa tarefa QA separada, com directório de evidência distinto e comparação no mesmo enquadramento 16:9.

| Estado | Regra |
|---|---|
| Baseline | Pode ser capturado futuramente em tarefa QA autorizada, sem candidata |
| Candidata | Bloqueada até aprovação explícita R4/R6 e causa espacial definida |
| Material, água, cota, largura e `cull_back` | Permanecem fora de escopo por variantes rejeitadas |
| Margens R4 inventariadas | Apenas inventário; nenhuma alteração permitida |
| Produção | Sem alteração nesta tarefa |

## Continuidade

A sucessão activa é `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-BASELINE-CAPTURE-053`. Esta próxima tarefa pode executar somente a captura baseline de `arch_to_forest`, se a ponta canónica continuar estável, sem candidata e sem mudança de produção. A captura deve ser interrompida se a integração avançar ou se o contrato R4/R6 mudar.
