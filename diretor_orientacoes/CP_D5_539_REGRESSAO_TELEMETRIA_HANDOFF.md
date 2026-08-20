# CP-D5-539 — Regressão da telemetria de handoff R6→R7

## Resultado

O preview modular e o handoff de Elias foram revalidados com parser Godot 4.7.1 e duas sessões QA headless de 36 segundos em 1600×900. O parser terminou com `PARSER_EXIT=0`; os QA terminaram com timeouts controlados (`QA_MIRROR_EXIT=124` e `QA_HANDOFF_EXIT=124`).

## Evidência

| Critério | Resultado |
|---|---|
| Âncoras R6→R7 | `(60,252)` → `(140,352)` |
| Grounding | `grounded=true` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Clearance | `2.4 m` |
| Luzes dinâmicas | `0` |
| Bounding box | `min=(10,-1,212)`, `max=(190,5,392)` |
| Contrato | `contract_ready=true` |
| Proprietário R7 | `Dev2` |
| Elias | `elias_third_person=true`, `CameraQA` |
| Marcador R7 alcançado | `reached_marker_r7=true` |
| Modo | `marker_only=true` |
| Produção | `production_modules_changed=false` |

A telemetria confirma o handoff pronto para a próxima frente, preservando a geometria R7 fora do preview canónico e respeitando o limite de 16 luzes da GTX 1050 Ti. Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`; os avisos FSR1 são esperados no renderer OpenGL Compatibility headless.

## Integridade

O runtime completo está em `CP-D5-539_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime será registado em `CP-D5-539_SHA256SUMS.txt`.

**STATUS_CODE: PASSED / CONTRACT_READY.**
