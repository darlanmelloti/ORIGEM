# CP-D5-530 — Auditoria modular da transição R6→R7

## Resultado

O preview `R6R7ModularMirrorPreview.tscn` passou o parser Godot 4.7.1 em renderer OpenGL Compatibility (`PARSER_EXIT=0`) e manteve QA headless durante 36 segundos em 1600×900. O término `QA_EXIT=124` corresponde ao timeout controlado previsto para encerrar a sessão de duração fixa.

## Auditoria

| Critério | Resultado |
|---|---|
| Âncoras cartográficas | R6 `(60,252)` → R7 `(140,352)` |
| Grounding | `grounded=true` |
| Malhas modulares | `13` |
| Colisores | `13` |
| Clearance | `2.4` |
| Luzes dinâmicas | `0` |
| Limite GTX 1050 Ti | Cumprido — `0 ≤ 16` |
| Elias terceira pessoa | `elias_third_person=true`, `camera=CameraQA` |
| Região 7 canónica | `region7_geometry=false` |
| Modo de handoff | `marker_only=true` |
| Alterações em produção | `production_modules_changed=false` |

Não foram observados `SCRIPT ERROR`, `Parse Error`, `Invalid scene` ou `Failed loading`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless e não constituem falha do checkpoint.

## Integridade

O runtime completo está em `CP-D5-530_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime será registado em `CP-D5-530_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** A auditoria confirma que o preview pode ser entregue como apoio técnico à frente proprietária da Região 7 sem ultrapassar a fronteira de escopo.
