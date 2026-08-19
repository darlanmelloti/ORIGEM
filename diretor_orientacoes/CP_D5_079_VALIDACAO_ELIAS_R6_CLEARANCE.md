# CP-D5-079 — Folga Elias na margem R6

## Resultado

O preview `EliasR6ClearancePreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. Elias percorreu o corredor da margem R6 com grounding confirmado, câmara QA externa e dois ciclos livres.

| Critério | Resultado |
|---|---|
| Monólito grounded | `true` |
| Monólito X/Z | `(52,260)` |
| Colisor | `CorredorMargemR6EliasQA` |
| Rota X | `60` |
| Folga | `6,05 m` |
| Folga exigida | `4,00 m` |
| Apresentação | `EliasThirdPersonPresentation` |
| Câmara actual de Elias | `false` |
| Ciclos | 2, ambos `clear=true` |
| Actor | Elias |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A prova confirma a passagem R6 em terceira pessoa sem alterar produção ou `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-079_ELIAS_R6_CLEARANCE_RUNTIME.log`.
