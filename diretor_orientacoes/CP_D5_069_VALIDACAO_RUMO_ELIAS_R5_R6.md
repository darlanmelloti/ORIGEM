# CP-D5-069 — Validação de rumo Elias R5 → R6

## Resultado

O preview `EliasR5R6HeadingPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. A telemetria confirmou o rumo desde a aproximação R5 até às Ruínas R6 e a indicação subsequente para a âncora 7.

| Critério | Resultado |
|---|---|
| Partida X/Z | `(-80,190)` |
| Destino | `RUMO ÀS RUÍNAS`, id `6` |
| Mapa — partida | `(195,6;261,4)` |
| Mapa — R6 | `(408,351)` |
| Chegada R6 | `true` |
| Próxima âncora | `7` |
| Próximo destino | `PASSAGEM: VILA ELEVADA` |
| Câmara de Elias | `elias_camera_current=false` |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A prova confirma a continuidade cartográfica R5→R6→R7 sem alterar módulos regionais ou `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-069_R5_R6_HEADING_RUNTIME.log`.
