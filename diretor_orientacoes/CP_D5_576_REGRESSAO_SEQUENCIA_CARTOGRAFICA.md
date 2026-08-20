# CP-D5-576 — Regressão da sequência cartográfica R2→R3→R6

## Resultado

A regressão isolada confirmou que a autoridade espacial do mapa permanece ordenada no eixo Z como `R2 → R3 → R6`, sem inversão de marcos ou deslocamento da transformação de Elias.

| Verificação | Resultado |
|---|---|
| Raycasts válidos | `3/3` |
| Consistência de clearance | `3/3`, `0.020 m` |
| Preservação X/Z | `3/3` |
| Sequência cartográfica | `R2>R3>R6 valid=true` |
| Erro vertical | `0.000 m` em R2, R3 e R6 |
| Parser Godot | `PARSER_EXIT=0` |
| QA | `36 s`, `QA_EXIT=124` por término controlado |
| Luzes dinâmicas | `0` |
| Produção alterada | `false` |

**STATUS_CODE: PASSED / CARTOGRAPHIC_SEQUENCE_R2_R3_R6 / VERTICAL_SLICE_R1_R6.**
