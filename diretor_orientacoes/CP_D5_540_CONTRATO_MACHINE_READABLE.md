# CP-D5-540 — Contrato machine-readable de handoff R6→R7

## Resultado

Foi criado `levels/dev5/R6R7HandoffContract.json`, um contrato machine-readable para consumo seguro da integração R6→R7. O JSON foi validado sintaticamente e o preview modular foi revalidado no parser Godot 4.7.1 e em QA headless de 36 segundos.

## Validação

| Critério | Resultado |
|---|---|
| JSON | Válido por `python3 -m json.tool` |
| Parser Godot 4.7.1 | Aprovado — `PARSER_EXIT=0` |
| QA headless | Aprovado — 36 s, `QA_EXIT=124` por timeout controlado |
| Âncoras R6→R7 | `(60,252)` → `(140,352)` |
| Marcador | `PASSAGEM_VILA_ELEVADA`, ID `7` |
| Proprietário da geometria R7 | `Dev2` |
| Bounding box | `min=(10,-1,212)`, `max=(190,5,392)` |
| Faixas / malhas / colisores | `2 / 18 / 18` |
| Grounding / clearance | `true / 2.4 m` |
| Luzes dinâmicas | `0`, limite `16` |
| Elias / câmara | `Elias`, `CameraQA` |
| Contrato / handoff | `contract_ready=true`, `marker_only=true` |
| Produção | `production_modules_changed=false`, `player_gd_changed=false` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

## Integridade

O contrato está em `levels/dev5/R6R7HandoffContract.json` e o runtime completo em `CP-D5-540_RUNTIME.log`. O checksum SHA-256 do contrato, relatório e runtime será registado em `CP-D5-540_SHA256SUMS.txt`.

**STATUS_CODE: PASSED / CONTRACT_READY.**
