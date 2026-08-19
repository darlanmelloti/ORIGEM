# CP-D5-188 — Regressão do contrato de câmara third-person de Elias

## Resultado

A cena `EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O contrato manteve exclusivamente a câmara externa de QA como viewport proprietário, sem activar a câmara de produção.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Câmara de Elias de produção | `false` |
| Câmara externa QA | `true` |
| Câmaras activas | 1 |
| Viewport proprietário | `CameraQAExterna` |
| `Player.gd` alterado | `false` |
| Módulos regionais alterados | `false` |

Os avisos repetidos sobre `viewport_set_scaling_3d_mode` pertencem ao renderer Compatibility e não produziram erro de parser ou script. A regressão confirma o isolamento da apresentação third-person. O log está em `CP-D5-188_CAMERA_CONTRACT_RUNTIME.log`.
