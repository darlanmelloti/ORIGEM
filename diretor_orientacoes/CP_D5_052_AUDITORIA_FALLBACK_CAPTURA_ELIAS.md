# CP-D5-052 — Auditoria de fallback de captura Elias

## Resultado

A auditoria identificou que os três harnesses Elias ainda assumiam que a textura da viewport e a imagem resultante existiam em headless. Foram adicionados fallbacks seguros em `EliasCameraContractPreview.gd`, `EliasMajesticClearancePreview.gd` e `EliasR6ClearancePreview.gd`.

| Critério | Resultado |
|---|---|
| Harnesses Elias corrigidos | 3 |
| Textura de viewport nula | Tratada com `snapshot_unavailable=headless_renderer` |
| Imagem nula após `get_image()` | Tratada com `snapshot_unavailable=headless_image` |
| Sessão final | 36 segundos |
| Câmara | `elias_camera_current=false`, `external_camera_current=true` |
| Player.gd/módulos regionais | Não alterados |
| `SCRIPT ERROR` final | 0 |

A execução final confirmou que o renderer Compatibility headless pode emitir uma imagem nula, mas o harness agora regista a indisponibilidade e termina sem crash. A advertência FSR1 é do renderer local. O log inicial preserva a falha encontrada; o log `CP-D5-052_EliasCameraContract_RUNTIME_FIXED.log` contém a prova final corrigida.

> A captura visual continua dependente de viewport gráfico válido; em headless, a indisponibilidade é agora um resultado controlado e não uma falha de QA.
