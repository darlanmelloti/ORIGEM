# CP-D5-028 — Auditoria do backend de captura QA

## Objectivo

Esta ficha audita exclusivamente a capacidade de captura gráfica dos previews R4/R6, sem repetir a auditoria de escopo do CP-D5-027 e sem criar nova geometria. O objectivo é separar falhas de backend de viewport de falhas dos candidatos.

| Componente | Resultado observado |
|---|---|
| Godot | 4.7.1 headless, Compatibility renderer |
| Sessão de gameplay/QA | 36 segundos por cena, processo termina com código 0 |
| Parser | Sem `SCRIPT ERROR` ou `Parse Error` |
| `DenseForestPortalPreview` | Contrato runtime preservado; captura solicitada mas `Image` nula |
| `SubmergedRuinsPierPreview` | Contrato runtime preservado; captura solicitada mas `Image` nula |
| Fallback | Regista `snapshot_unavailable=headless_image` e evita `save_png` inválido |
| Decisão | Captura visual ainda não avaliável neste backend |

## Procedimento gráfico obrigatório

A aceitação ou rejeição visual deve ser feita num viewport gráfico Godot 4.7.1 com renderer Compatibility, usando as mesmas cenas e a mesma variável `ORIGEM_QA_VIEWPORT_SNAPSHOT`. Depois de `_ready`, aguardar pelo menos 30 frames, guardar a imagem e verificar passagem, profundidade, escala e linguagem arqueológica contra os critérios do CP-D5-026.

## Segurança de integração

Esta auditoria não altera `ForestLakeRegion.gd`, `TempleLevel.gd`, `Player.gd` ou módulos regionais. Os candidatos R4/R6 continuam QA, sem promoção automática. A ausência de imagem não é tratada como aceitação nem como rejeição visual.

## Próxima acção

Manter a ficha como evidência de prontidão e avançar apenas com a próxima auditoria/ficha não concorrente permitida pelo protocolo enquanto o viewport gráfico válido não estiver disponível.
