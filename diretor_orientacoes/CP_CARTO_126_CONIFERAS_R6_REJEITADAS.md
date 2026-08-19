# CP-CARTO-126 — Calibração de coníferas R6 rejeitada

## Hipótese

A tomada de chegada às Ruínas Submersas apresentava coníferas com dominante azul-ciano. Foi testada uma calibração selectiva das superfícies de agulhas, mantendo troncos, posições, colisores e limites LOD.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay de chegada R6 | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Geometria e colisores | Sem alteração |
| Resultado visual | REJECTED_VISUAL |

A primeira calibração foi insuficiente e a variante reforçada tornou uma conífera distante artificialmente verde, sem melhorar de forma consistente a árvore focal. Ambas as variantes foram revertidas para o material PBR publicado.

> Evidência rejeitada: `/home/ubuntu/qa_evidence_dev1_cp245/ruins_arrival_cp126_pine_tint_strong/ruins_arrival_36s.png`

## Decisão

**REJEITADO.** Não repetir a mesma multiplicação de albedo nas coníferas PBR. O próximo passe deve tratar escala, composição ou activos, não uma nova correcção cromática do mesmo candidato.
