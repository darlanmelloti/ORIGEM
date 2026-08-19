# DEV6-004 — Compatibilidade GL Compatibility R2

Foi auditado e ajustado o shader do `TerrainPatch` para limitar a redução de frequência visual às margens da Estrada do Rio, entre z=10 e z=96. A alteração usa as UVs em espaço-mundo e uma máscara lateral: não modifica relevo, colisão, rota, âncoras, jogador ou Regiões 7–12.

| Critério | Resultado |
|---|---:|
| Parser Godot 4.7.1 | PASS |
| Renderizador de validação | `gl_compatibility` / OpenGL |
| `road_to_arch` | PASS — 36 s |
| Grounding R2 | PASS — 9/9, X/Z preservado |
| Luzes adicionadas | PASS — 0 |
| Granulação lateral | Melhoria moderada |
| Aceitação visual global | REJECTED_VISUAL |

A suavização de material reduz a agressividade de padrão na margem, mas a captura ainda expõe limitações sistémicas de escala, composição e primeiro plano que não devem ser mascaradas por alterações locais. O ciclo seguinte deve auditar a geometria de leitura do corredor apenas com sinais de ambiente reversíveis, sem tocar no jogador ou em módulos fora de R1–R6.
