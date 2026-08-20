# CP-D5-543 — Auditoria estática do contrato R6→R7

## Resultado

O contrato machine-readable foi submetido a auditoria estática, verificando âncoras R6/R7, duas faixas, contagens de malhas e colisores, orçamento de iluminação, flags de produção e estado de handoff. A auditoria passou. O preview modular também passou parser Godot 4.7.1 e QA headless de 36 segundos em 1600×900.

## Evidência

| Critério | Resultado |
|---|---|
| Auditoria estática | `STATIC_CONTRACT=PASSED` |
| Parser Godot 4.7.1 | Aprovado — `PARSER_EXIT=0` |
| QA headless | Aprovado — 36 s, `QA_EXIT=124` por timeout controlado |
| Âncoras R6→R7 | `(60,252)` → `(140,352)` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Grounding / clearance | `grounded=true`, `2.4 m` |
| Luzes dinâmicas | `0`, limite `≤16` |
| Elias / câmara | `elias_third_person=true`, `CameraQA` |
| Contrato | `contract_ready=true` |
| Proprietário R7 | `Dev2` |
| Região 7 canónica | `region7_geometry=false` |
| Player.gd alterado | `false` |
| Produção alterada | `production_modules_changed=false` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

## Integridade

O contrato auditado está em `levels/dev5/R6R7HandoffContract.json`; o runtime completo está em `CP-D5-543_RUNTIME.log`. O checksum SHA-256 do contrato, relatório e runtime será registado em `CP-D5-543_SHA256SUMS.txt`.

**STATUS_CODE: PASSED / STATIC_CONTRACT_VALID.**
