# CP-D5-675 — Matriz de Integração Condicionada Gamma

## Objectivo

Esta matriz prepara a revisão dos candidatos Gamma antes de qualquer integração no mundo principal. A matriz não autoriza merge automático: Dev3 mantém a autoridade visual, Dev4 a autoridade técnica, Dev6 a responsabilidade de ambiente e os proprietários regionais a decisão final de integração.

| Candidato | Âncora | Papel | Grounding | Critério visual | Orçamento |
|---|---:|---|---|---|---:|
| `GammaR4R5R6MirrorPreview` | R4/R5/R6 | Espelhamento real Gamma | `≤0,05 m`, X/Z preservado | R4 denso, R5 legível, R6 revelação submersa | 2/16 |
| `GammaR5PropGroundingPreview` | R5 | Apoio Dev6: tenda, fogueira, equipamento | 3/3 por raycast | Camp abandonado vivo, sem parede de props | 0/16 |
| `GammaR5R6TransitionPreview` | R5→R6 | Continuidade cartográfica | 2/2 por raycast, X/Z preservado | Entrada física, água transparente e leitura de ruínas | 0/16 |

## Critérios de revisão

Dev3 deve confirmar silhueta, escala, atmosfera, clareira e legibilidade da revelação de Orion, mantendo correspondência mínima de 85% com o storyboard. Dev4 deve confirmar parser Godot 4.7.1, sessões de 36 segundos, ausência de erros, contagem de luzes e integridade do pacote. Dev6 deve confirmar materiais, vegetação, água, adereços e efeitos ambientais sem deslocar âncoras cartográficas.

A integração só pode ocorrer quando todos os candidatos preservarem a ordem R4→R5→R6, o corredor R5→R6, grounding por raycast e a fronteira de produção `PRODUCTION_MODULES_CHANGED=false` durante a revisão. Qualquer promoção deve ser feita pelo proprietário regional correspondente em alteração separada.

**STATUS_CODE: READY_FOR_REVIEW / CONDITIONAL_INTEGRATION / CP-D5-675.**
