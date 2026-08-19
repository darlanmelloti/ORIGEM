# CP-D5-087 — Rumo Elias R5→R6

## Resultado

O preview `EliasR5R6HeadingPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. Elias partiu do corredor Majestic R5, recebeu o destino cartográfico das Ruínas R6 e confirmou a chegada com o próximo destino na âncora 7.

| Critério | Resultado |
|---|---|
| Início X/Z | `(-80,190)` |
| Destino | `RUMO ÀS RUÍNAS` |
| Âncora destino | `6` |
| Câmara actual de Elias | `false` |
| Chegada R6 | `true` |
| Próxima âncora | `7` |
| Próxima leitura | `PASSAGEM: VILA ELEVADA` |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A prova confirma o rumo cartográfico R5→R6 e a continuidade para R7 sem alterar produção ou `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-087_ELIAS_R5_R6_HEADING_RUNTIME.log`.
