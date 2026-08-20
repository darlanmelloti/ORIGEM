# CP-D5-546 — Validação do perfil de contrato R6→R7

## Resultado

O perfil explícito do contrato machine-readable foi validado com JSON válido, parser Godot 4.7.1 e QA headless de 36 segundos em 1600×900. O parser terminou com `PARSER_EXIT=0`; o QA terminou com `QA_EXIT=124` por timeout controlado.

## Evidência

| Critério | Resultado |
|---|---|
| Contrato JSON | Válido por `python3 -m json.tool` |
| Parser Godot 4.7.1 | Aprovado — `PARSER_EXIT=0` |
| QA headless | Aprovado — 36 s, `QA_EXIT=124` |
| Renderer / resolução | `gl_compatibility` / `1600×900` |
| Âncoras R6→R7 | `(60,252)` → `(140,352)` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Grounding / clearance | `grounded=true`, `2.4 m` |
| Luzes dinâmicas | `0`, limite `≤16` |
| Elias / câmara | `elias_third_person=true`, `CameraQA` |
| Handoff | `contract_ready=true`, proprietário R7 `Dev2` |
| Produção | `production_modules_changed=false` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

## Integridade

O contrato está em `levels/dev5/R6R7HandoffContract.json`; o runtime completo está em `CP-D5-546_RUNTIME.log`. O checksum SHA-256 do contrato, relatório e runtime será registado em `CP-D5-546_SHA256SUMS.txt`.

**STATUS_CODE: PASSED / PROFILE_VALIDATED.**
