# CP-D5-063 — Rumo Elias: Casa de Voss → Estrada do Rio

## Resultado

O preview `EliasVossRoadHeadingPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. A telemetria confirmou a ligação cartográfica R1→R2 e oito ciclos do destino em terceira pessoa.

| Critério | Resultado |
|---|---|
| Casa de Voss | X/Z `(-22,8)` |
| Âncora da estrada | `(-21,4;12,0)` |
| Ponte R2 | `(-21,4;28,0)` |
| Destino | `RUMO À ESTRADA DO RIO`, id `2` |
| Câmara de Elias | `elias_camera_current=false` |
| Ciclos de rumo | 8 |
| Runtime | 36 segundos |
| Parser/Script Error | Nenhum |

O contrato confirma continuidade espacial entre a Casa de Voss e o eixo da estrada que conduz à ponte R2, sem alterar módulos regionais ou `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-063_VOSS_HEADING_RUNTIME.log`.
