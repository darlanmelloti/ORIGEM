# CP-D5-055 — Correcção global dos fallbacks de captura

## Resultado

Os sete handlers identificados no CP-D5-054 foram corrigidos para testar textura de viewport e imagem nulas antes de chamar `save_png()`. A varredura final não encontrou qualquer chamada directa vulnerável nem inicialização de imagem sem fallback no escopo Dev5.

| Critério | Resultado |
|---|---|
| Handlers corrigidos | 7 |
| Direct calls vulneráveis restantes | 0 |
| Parser Compatibility | Limpo |
| Sessão QA R6 | 36 segundos |
| Grounding/folga | `grounded=true`, `clearance=6.05 m` |
| Percurso | 2 ciclos `clear=true` |
| `SCRIPT ERROR` | 0 |
| Módulos de produção | 0 alterados |

O renderer dummy ainda emite a mensagem interna `Parameter "t" is null` ao tentar obter uma imagem inexistente, mas o código intercepta o resultado nulo, regista `snapshot_unavailable=headless_image` e não produz `SCRIPT ERROR` nem crash. Isto é uma limitação do backend headless, não uma falha do harness.

O log final está em `CP-D5-055_R6_CAPTURE_RUNTIME_FINAL.log`. Os scripts auxiliares usados para aplicar a alteração permanecem fora do commit de produção; somente os ficheiros Dev5 corrigidos são publicados.
