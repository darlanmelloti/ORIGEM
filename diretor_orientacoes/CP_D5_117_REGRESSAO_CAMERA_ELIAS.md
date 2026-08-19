# CP-D5-117 — Regressão do contrato de câmara de Elias

## Resultado

A cena `EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O contrato confirmou que Elias não é a câmara activa e que `CameraQAExterna` é a única câmara corrente.

| Verificação | Resultado |
|---|---|
| Câmara de Elias | `elias_camera_current=false` |
| Câmara externa | `external_camera_current=true` |
| Proprietário | `CameraQAExterna` |
| Câmaras activas | 1 |
| `Player.gd` | Não alterado |
| Módulos regionais | Não alterados |
| Estado | `status=approved` |

A regressão confirma a apresentação third-person externa sem interferir na câmara de produção. O log completo está em `CP-D5-117_CAMERA_CONTRACT_RUNTIME.log`.
