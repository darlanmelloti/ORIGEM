# ORIGEM — Correcção Local de Material do Afluente Cartográfico R4 045

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-LOCAL-MATERIAL-CORRECTION-045`
**Estado:** Correcção modular aprovada
**Região:** R4 — Floresta Densa
**Escopo:** Apenas a lâmina `LaminaDoAfluenteCartografico`

## Correcção aplicada

A evidência da tarefa 044 confirmou que a superfície opaca clara de `arch_to_forest` era causada pelo contrato visual do material aplicado à lâmina do afluente. A correcção 045 substituiu **somente nessa instância R4** a chamada à fábrica lacustre partilhada por `R4CartographicInletMaterial.make_material()`.

O novo módulo `levels/regions/r4/ForestCartographicInletMaterial.gd` mantém a mesma oscilação de vértices e a mesma malha do afluente, mas usa mistura alfa, `depth_prepass_alpha` e `ALPHA = 0.68`. A sua paleta, emissão, rugosidade e especular foram reduzidas de forma local para evitar a leitura opaca clara no primeiro plano. O material lacustre criado por `_create_lake_material()` permanece inalterado e continua aplicado ao lago R6.

| Controlo | Estado |
|---|---|
| Geometria R4 | A mesma lâmina; 24 vértices e 4 segmentos |
| Posições, largura, cota e corredor do afluente | Inalterados |
| Material local R4 | Exclusivo da lâmina, sem `depth_draw_opaque`, com `ALPHA = 0.68` |
| Material lacustre R6 | Preservado com `depth_draw_opaque` e `ALPHA = 1.0` |
| `TerrainPatch.gd`, âncoras, rota, câmara, luzes e física | Sem alteração |
| R5 e R6 | Sem alteração de activos, lógica, água, iluminação ou rotas |

> A prova de candidato aplicou temporariamente o material local somente em QA e confirmou que R6, a malha R4, o material-fonte e o número de luzes permaneciam inalterados. A prova de produção confirmou depois a instalação local sem `material_override` e com o contrato original do lago R6 preservado.

## Evidência de validação

| Verificação | Resultado |
|---|---|
| Diagnóstico histórico de isolamento | `[ORIGEM_R4_INLET_ISOLATION_OK]` |
| Candidato QA R4/R6 | `[ORIGEM_R4_INLET_LOCAL_MATERIAL_CANDIDATE_OK]` |
| Correcção local instalada | `[ORIGEM_R4_INLET_LOCAL_MATERIAL_OK]` |
| Parser Godot headless | Aprovado |
| Auditoria de orçamento | `[QA-BUDGET-01] result=PASS` |
| Porta regional R4 | `[GATE:R4] PASS` |
| Porta regional R6 | `[GATE:R6] PASS` |
| `arch_to_forest` | Aprovada |
| `forest_to_majestic` | Aprovada |
| `forest_to_ruins` | Aprovada |

A auditoria de orçamento confirmou uma luz simultânea na câmara, abaixo do limite de 16. A correcção não introduziu nenhuma luz, colisor, partícula, vento, animação, pós-processamento, física ou geometria adicional. A clareira Orion em `Z≈126–151` e a garantia de corredor exterior `≥8 m` não foram tocadas.

Os avisos `Parameter "material" is null` eventualmente emitidos ao encerrar harnesses headless pertencem ao backend dummy de renderização após o sucesso da prova. Não ocorreu erro de parser, script, shader ou falha fatal nas verificações aprovadas.

## Continuidade

A sucessão activa é `DEV4-R4-CARTOGRAPHIC-INLET-LOCAL-MATERIAL-RUNTIME-REVIEW-046`. Ela deve capturar e rever exclusivamente a rota `arch_to_forest` após a estabilização runtime, confirmar que a leitura opaca foi mitigada sem impacto nas outras rotas e não alterar produção até existir evidência adicional.
