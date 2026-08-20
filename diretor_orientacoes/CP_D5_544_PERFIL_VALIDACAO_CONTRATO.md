# CP-D5-544 — Perfil de validação do contrato R6→R7

## Resultado

O contrato machine-readable foi enriquecido com um perfil explícito de validação: versão do parser, duração QA, resolução, renderer, flags runtime obrigatórias e limite máximo de luzes. O JSON permaneceu válido e o preview modular passou parser Godot 4.7.1 e QA headless de 36 segundos em 1600×900.

## Evidência

| Critério | Resultado |
|---|---|
| JSON | Válido por `python3 -m json.tool` |
| Parser Godot 4.7.1 | Aprovado — `PARSER_EXIT=0` |
| QA headless | Aprovado — 36 s, `QA_EXIT=124` por timeout controlado |
| Renderer / resolução | `gl_compatibility` / `1600×900` |
| Flags obrigatórias | `grounded=true`, `marker_only=true`, `production_modules_changed=false`, `region7_geometry=false` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Clearance / luzes | `2.4 m` / `0`, máximo `16` |
| Elias / câmara | `Elias` / `CameraQA` |
| Contrato | `contract_ready=true`, proprietário R7 `Dev2` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

## Integridade

O contrato está em `levels/dev5/R6R7HandoffContract.json`; o runtime completo está em `CP-D5-544_RUNTIME.log`. O checksum SHA-256 do contrato, relatório e runtime será registado em `CP-D5-544_SHA256SUMS.txt`.

**STATUS_CODE: PASSED / VALIDATION_PROFILE_READY.**
