# CP-D5-537 — Regressão conjunta do contrato modular e handoff de Elias

## Resultado

A regressão conjunta do preview `R6R7ModularMirrorPreview.tscn` e do handoff `EliasR6R7HandoffPreview.tscn` passou o parser Godot 4.7.1 e duas sessões QA headless de 36 segundos em 1600×900. O parser terminou com `PARSER_EXIT=0`; as sessões QA terminaram com timeouts controlados (`QA_MIRROR_EXIT=124` e `QA_HANDOFF_EXIT=124`).

## Evidência

| Critério | Resultado |
|---|---|
| Âncoras R6→R7 | `(60,252)` → `(140,352)` |
| Grounding | `grounded=true` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Clearance | `2.4 m` |
| Luzes dinâmicas | `0` |
| Limite GTX 1050 Ti | Cumprido — `0 ≤ 16` |
| Elias em terceira pessoa | `elias_third_person=true`, `CameraQA` |
| R7 alcançado | `reached_marker_r7=true` |
| Modo | `marker_only=true` |
| Região 7 canónica | `region7_geometry=false` |
| Alterações de produção | `production_modules_changed=false` |

Os metadados de bounding box e orçamento introduzidos no checkpoint anterior permaneceram compatíveis com o runtime. Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

## Integridade

O runtime completo está em `CP-D5-537_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime será registado em `CP-D5-537_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** A integração modular e o handoff de Elias permanecem estáveis para a próxima tarefa.
