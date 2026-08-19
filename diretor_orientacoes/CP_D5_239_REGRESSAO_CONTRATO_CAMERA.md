# CP-D5-239 — Regressão do contrato de câmara de Elias

## Resultado

A cena `EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O contrato confirmou uma única câmara QA externa activa, sem duplicação de câmaras de produção e sem alterar `Player.gd` ou módulos regionais.

| Verificação | Resultado |
|---|---|
| Elias câmara de produção | `false` |
| Câmara externa QA | `true` |
| Proprietário do viewport | `CameraQAExterna` |
| Câmaras activas | 1 |
| `Player.gd` alterado | `false` |
| Módulos regionais alterados | `false` |
| Estado | `approved` |

Os avisos de `viewport_set_scaling_3d_mode` são específicos do renderer OpenGL Compatibility no ambiente headless e não representam erro de script. O log está em `CP-D5-239_CAMERA_CONTRACT_RUNTIME.log`.
