# CP-D5-058 — Validação StoneBridgeGLB R2

## Resultado

O preview `StoneBridgeGLBPreview.tscn` passou uma sessão QA de 36 segundos em Godot Compatibility headless. A telemetria confirmou a âncora cartográfica R2, o offset canónico, a contagem de triângulos e a colisão contínua da ponte.

| Critério | Resultado |
|---|---|
| Região | R2 |
| Âncora | `2` |
| World X/Z | `(-21,4; 28,0)` |
| Offset | `(0,0; 16,0)` |
| Triângulos | `252` |
| Colisão | `tabuleiro_continuo` |
| Runtime | 36 segundos |
| Parser/Script Error | Nenhum |

A advertência FSR1 é específica do renderer Compatibility local. O preview permanece dentro da fronteira `levels/dev5/` e não altera módulos regionais nem `Player.gd`. A captura visual final depende de viewport gráfico válido.

O log está em `CP-D5-058_STONE_BRIDGE_RUNTIME.log`.
