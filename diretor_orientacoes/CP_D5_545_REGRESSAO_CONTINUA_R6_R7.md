# CP-D5-545 — Regressão contínua do contrato modular R6→R7

## Resultado

O contrato machine-readable, o preview modular e o handoff de Elias foram revalidados com JSON válido, parser Godot 4.7.1 e duas sessões QA headless de 36 segundos em 1600×900. O parser terminou com `PARSER_EXIT=0`; os QA terminaram com timeouts controlados (`QA_MIRROR_EXIT=124` e `QA_HANDOFF_EXIT=124`).

## Evidência

| Critério | Resultado |
|---|---|
| Contrato JSON | Válido por `python3 -m json.tool` |
| Âncoras R6→R7 | `(60,252)` → `(140,352)` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Grounding / clearance | `grounded=true`, `2.4 m` |
| Luzes dinâmicas | `0`, limite `≤16` |
| Bounding box | `min=(10,-1,212)`, `max=(190,5,392)` |
| Elias / câmara | `elias_third_person=true`, `CameraQA` |
| Marcador R7 | `reached_marker_r7=true` |
| Contrato | `contract_ready=true`, proprietário R7 `Dev2` |
| Região 7 canónica | `region7_geometry=false` |
| Produção | `production_modules_changed=false` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

## Integridade

O contrato está em `levels/dev5/R6R7HandoffContract.json` e o runtime completo está em `CP-D5-545_RUNTIME.log`. O checksum SHA-256 do contrato, relatório e runtime será registado em `CP-D5-545_SHA256SUMS.txt`.

**STATUS_CODE: PASSED / CONTINUOUS_REGRESSION_VALID.**
