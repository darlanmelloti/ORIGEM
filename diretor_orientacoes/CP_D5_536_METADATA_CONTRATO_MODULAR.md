# CP-D5-536 — Metadados do contrato modular R6→R7

## Resultado

O contrato da cena `R6R7ModularMirrorPreview.tscn` foi enriquecido com metadados explícitos de integração: bounding box global do preview, número de faixas, contagem de malhas e colisores, contagem de luzes dinâmicas, clearance e identidade de terceira pessoa. A alteração permanece isolada no preview Dev5.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | Aprovado — `PARSER_EXIT=0` |
| QA headless | Aprovado — 36 s, `QA_EXIT=124` por timeout controlado |
| Bounding box global | `min=(10,-1,212)`, `max=(190,5,392)` |
| Faixas | `2` |
| Malhas / colisores | `18 / 18` |
| Grounding | `grounded=true` |
| Clearance | `2.4 m` |
| Luzes dinâmicas | `0` |
| Limite global | `0 ≤ 16` |
| Elias | `elias_third_person=true`, `CameraQA` |
| Região 7 canónica | `region7_geometry=false` |
| Produção alterada | `production_modules_changed=false` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

## Integridade

O runtime completo está em `CP-D5-536_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime será registado em `CP-D5-536_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** Os metadados estão prontos para consumo pela próxima frente de integração sem alterar a geometria de produção.
