# CP-D5-259 — Regressão contrato de câmara de Elias

## Resultado

A cena `EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A câmara de produção de Elias permaneceu inactiva, enquanto uma única câmara externa QA assumiu o viewport, sem duplicação e sem alterações a `Player.gd` ou aos módulos regionais.

| Verificação | Resultado |
|---|---|
| Cena | `EliasCameraContractPreview.tscn` |
| Câmara de Elias de produção | `false` |
| Câmara QA externa | `true` |
| Dono do viewport | `CameraQAExterna` |
| Câmaras activas | 1 |
| `Player.gd` alterado | `false` |
| Módulos regionais alterados | `false` |
| Estado | `approved` |

A regressão aprova o contrato de câmara terceira pessoa de Elias e mantém a separação entre QA Dev5 e produção. O log está em `CP-D5-259_CAMERA_CONTRACT_RUNTIME.log`.
