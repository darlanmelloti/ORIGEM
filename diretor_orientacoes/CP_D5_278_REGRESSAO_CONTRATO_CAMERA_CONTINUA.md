# CP-D5-278 — Regressão contrato de câmara contínua

## Resultado

A cena `EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O contrato confirmou uma única câmara externa activa, sem duplicação, com Elias em terceira pessoa e módulos de produção preservados.

| Verificação | Resultado |
|---|---|
| Elias camera current | `false` |
| Câmara externa current | `true` |
| Owner do viewport | `CameraQAExterna` |
| Câmaras activas | 1 |
| Duplicação | ausente |
| `Player.gd` alterado | `false` |
| Módulos regionais alterados | `false` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-278_CAMERA_CONTRACT_RUNTIME.log`.
