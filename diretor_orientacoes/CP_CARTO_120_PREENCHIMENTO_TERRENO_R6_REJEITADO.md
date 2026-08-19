# CP-CARTO-120 — Preenchimento material do terreno R6

## Hipótese

A falésia escura observada na chegada às Ruínas Submersas poderia resultar do colapso de iluminação nas faces distantes do `TerrainPatch` sob OpenGL Compatibility. Foi testado preenchimento material por emissão discreta, sem adicionar luzes, mexer no relevo ou alterar a rota.

## Execução e evidência

Foram testadas intensidades `0,045` e `0,20` multiplicadas pelo albedo do solo. Ambas passaram no parser Godot 4.7.1 e numa execução de 36 segundos, com captura Xvfb recolhida no 30.º segundo real.

A intensidade menor não alterou a leitura de forma demonstrável. A intensidade reforçada clareou marginalmente o solo geral, mas a falésia permaneceu escura e o aumento adicional arriscaria achatar a separação natural do vale.

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay R6 | 36 s, PASS |
| Captura tardia | PASS, 1600×900 |
| Luzes dinâmicas adicionais | 0 |
| Ganho visual da falésia | Insuficiente |
| Decisão | REJECTED_VISUAL; revertido |

**Evidência:** `/home/ubuntu/qa_evidence_dev1_cp245/ruins_arrival_cp120_terrain_fill20/ruins_arrival_36s.png`

## Continuidade

Não repetir emissões globais do terreno. A próxima investigação deve auditar a topologia e a orientação de faces da encosta R6, mantendo a regra de não alterar árvores, sombras, UI, água ou Rocha de Margem 24 sem causa nova demonstrada.
