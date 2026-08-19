# CP-D5-070 — Validação de passagem Elias na Floresta R4

## Resultado

O preview `EliasForestClearancePreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. Os seis elementos vegetais permaneceram aterrados e a rota de Elias manteve o corredor aberto em dois ciclos.

| Critério | Resultado |
|---|---:|
| Âncora R4 | `(-9,116)` |
| Largura do corredor | `5,20 m` |
| Folga mínima | `2,75 m` |
| Elementos vegetais | 6 |
| Grounding | Todos `true` |
| Câmara de Elias | `elias_camera_current=false` |
| Portal de floresta | `false` |
| Parede de árvores | `false` |
| Ciclos de rota | 2 |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A prova confirma passagem segura sem geometria excessiva, sem alterar módulos regionais ou `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-070_ELIAS_FOREST_RUNTIME.log`.
