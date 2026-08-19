# CP-D5-082 — Revalidação da orientação exterior Elias R1→R2

## Resultado

O preview `EliasVossRoadHeadingPreview.tscn` foi revalidado durante 36 segundos em Compatibility headless. A apresentação exterior de Elias manteve o rumo cartográfico da Casa Voss para a Estrada do Rio em oito ciclos consecutivos.

| Critério | Resultado |
|---|---|
| Casa Voss X/Z | `(-22,8)` |
| Estrada R2 X/Z | `(-21,4;12)` |
| Ponte R2 X/Z | `(-21,4;28)` |
| Destino | `RUMO À ESTRADA DO RIO` |
| Âncora destino | `2` |
| Câmara actual de Elias | `false` |
| Ciclos | 8 |
| Consistência do destino | 8/8 ciclos na âncora 2 |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A revalidação confirma a orientação exterior de Elias sem alterar Casa Voss, porta, módulos de produção ou `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-082_ELIAS_VOSS_EXTERNAL_RUNTIME.log`.
