# CP-D5-681 — Registo de Revisão Pendente Gamma

## Estado

O pacote Gamma encontra-se **pendente de revisão formal**, não bloqueado tecnicamente. Os candidatos foram validados em previews isolados e permanecem prontos para decisão dos proprietários regionais, sem qualquer promoção automática para o mundo principal.

| Revisão | Responsável | Estado |
|---|---|---|
| Fidelidade visual e storyboard | Dev3 | Pendente |
| Parser, runtime e orçamento | Dev4 | Pendente |
| Materiais, vegetação, água e vida | Dev6 | Pendente |
| Integração regional | Proprietários R4/R5/R6 | Pendente |
| Grounding e fronteiras | Dev5 | Validado |
| Rollback | Dev5 | Preparado |

## Evidência já disponível

Os previews Gamma cobrem R4→R5→R6, adereços grounded em R5 e continuidade R5→R6. O parser Godot 4.7.1 terminou com `0`; as sessões controladas de 36 segundos foram concluídas conforme o protocolo. O limite de grounding é `0,05 m`, X/Z permanece preservado e a iluminação declarada não ultrapassa 2 das 16 luzes permitidas.

## Regra de promoção

A decisão só deve ser tomada quando Dev3, Dev4, Dev6 e o proprietário regional relevante registarem aprovação. Qualquer promoção deve usar commit separado, manter rollback explícito, repetir a regressão R1–R6 e confirmar que a alteração não introduz referências indevidas ou ultrapassa o orçamento da GTX 1050 Ti.

**STATUS_CODE: REVIEW_PENDING / TECHNICALLY_READY / CP-D5-681.**
