# CP-D5-535 — Regressão conjunta modular e Elias R6→R7

## Resultado

A regressão conjunta validou `R6R7ModularMirrorPreview.tscn` e `EliasR6R7HandoffPreview.tscn` com parser Godot 4.7.1 e duas sessões QA headless de 36 segundos em 1600×900. O parser terminou com `PARSER_EXIT=0`; os QA terminaram com timeouts controlados (`QA_MIRROR_EXIT=124` e `QA_HANDOFF_EXIT=124`).

## Evidência consolidada

| Critério | Resultado |
|---|---|
| Âncoras R6→R7 | `(60,252)` → `(140,352)` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Grounding | `grounded=true` |
| Clearance | `2.4` |
| Luzes dinâmicas | `0` |
| Limite GTX 1050 Ti | Cumprido — `0 ≤ 16` |
| Elias terceira pessoa | `elias_third_person=true`, `camera=CameraQA` |
| Marcador R7 alcançado | `reached_marker_r7=true` |
| Modo de handoff | `marker_only=true` |
| Geometria Dev2 criada | `false` |
| Geometria Região 7 | `region7_geometry=false` |
| Alterações em produção | `production_modules_changed=false` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless e não constituem falha do checkpoint.

## Integridade

O runtime completo está em `CP-D5-535_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime será registado em `CP-D5-535_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** A continuidade do handoff modular e da apresentação de Elias está aprovada para o próximo checkpoint.
