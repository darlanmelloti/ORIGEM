# CP-D5-258 — Regressão apresentação de Elias em terceira pessoa

## Resultado

A cena `EliasThirdPersonPreview.tscn` passou o parser Godot (`PARSER_EXIT=0`) e uma sessão QA controlada de 36 segundos (`QA_EXIT=124`, timeout controlado). A apresentação técnica mantém uma única câmara QA externa activa, com Elias apresentado em terceira pessoa, sem duplicar câmaras de produção e sem alterar `Player.gd`.

| Verificação | Resultado |
|---|---|
| Cena | `EliasThirdPersonPreview.tscn` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Câmara activa | `CameraQA` externa |
| Apresentação | terceira pessoa |
| `Player.gd` alterado | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os avisos de `viewport_set_scaling_3d_mode` pertencem ao renderer OpenGL Compatibility em ambiente headless e não configuram erro de parser. O log está em `CP-D5-258_ELIAS_THIRD_PERSON_RUNTIME.log`.
