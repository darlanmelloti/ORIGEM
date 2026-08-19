# CP-D5-055 — Fallback seguro para capturas headless

**Escopo:** handlers de captura em cenas QA Dev5. Não foram alterados módulos regionais, `Player.gd`, recursos de produção ou qualquer cena R7–R12.

## Correcção aplicada

Os handlers abaixo deixaram de encadear `get_texture().get_image().save_png()` sem validar a textura e a imagem. Cada um agora regista `snapshot_unavailable=headless_renderer` ou `snapshot_unavailable=headless_image` e termina de forma segura quando o renderizador não expõe uma imagem de viewport.

| Handler | Protecção adicionada |
|---|---|
| `CartographicPlacementPreview` | textura e imagem nulas |
| `EliasMajesticClearancePreview` | imagem nula |
| `EliasR6ClearancePreview` | imagem nula |
| `R6MonolithClearancePreview` | textura e imagem nulas |
| `StoneBridgeLandmarkPreview` | textura e imagem nulas |
| `VossWaystationPreview` | textura e imagem nulas |
| `SubmergedShoreMonolithPreview` | textura e imagem nulas |
| `MajesticEliasVegetationReadPreview` | textura e imagem nulas |
| `R6EliasVegetationReadPreview` | textura e imagem nulas |

A auditoria detectava sete handlers preexistentes; os dois novos previews de leitura R5/R6 foram incluídos preventivamente para que a mesma regressão não voltasse a entrar na fila.

## Validação

O parser Godot 4.7.1 passou. Em execução headless, o preview R6 registou `snapshot_unavailable=headless_image` e continuou sem erro de script. Em execução gráfica de 36 segundos, a mesma cena gravou a captura interna, completou dois ciclos de rota e não apresentou erros de parser, script ou asserção.

> O fallback garante robustez de QA; não substitui a captura gráfica quando ela está disponível.

## Próxima tarefa automática

**CP-D5-056 — Auditoria de cobertura de fallback.** Comparar todos os handlers de snapshot Dev5 com o padrão seguro e publicar uma lista de zero pendências ou dos ficheiros restantes, sem alterar produção.
