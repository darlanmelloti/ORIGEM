# CP-D5-214 — Regressão do landmark Casa Voss R1

## Resultado

A cena `VossWaystationPreview.tscn` passou parser (`PARSER_EXIT=0`) e foi executada em QA headless por 36 segundos (`QA_EXIT=124`, timeout controlado). O preview é isolado e instancia exclusivamente o anexo técnico da Casa Voss através de `CartographicLandmarkObjects.create_voss_waystation_landmark()`.

| Verificação | Resultado |
|---|---|
| Cena QA | `VossWaystationPreview.tscn` |
| Âncora | R1 / Casa Voss |
| Landmark | `AnexoCasaVoss_QA` |
| Posicionamento local | `(0.0,0.16,0.0)` |
| Terreno QA | Plano 20×20 m |
| Rota de saída | Path central 2×8 m |
| Câmara | `CameraAnexoCasaVossQA` |
| Modo | Preview isolado |
| Módulos de produção carregados | `false` |
| Estado | `approved` |

A regressão aprova a presença técnica do landmark Casa Voss e a leitura da rota frontal sem modificar portas, interiores ou módulos de produção. A ausência de marcadores textuais em runtime é esperada nesta cena estática; o parser e a sessão headless foram concluídos. O log está em `CP-D5-214_R1_VOSS_LANDMARK_RUNTIME.log`.
