# CP-D5-682 — Matriz de Respostas e Decisões de Revisão Gamma

## Objectivo

Esta matriz organiza as respostas técnicas ao handoff Gamma sem presumir aprovação visual, técnica ou ambiental. Os factos abaixo estão suportados por evidência publicada; as decisões de promoção continuam pendentes dos responsáveis.

| Frente | Facto validado | Decisão pendente | Evidência |
|---|---|---|---|
| Dev3 — visual | R4→R5→R6 e R5→R6 preservados; fog R4 e revelação R6 disponíveis | Confirmar correspondência ≥85% ao storyboard | CP-D5-677 |
| Dev4 — técnico | Parser `0`; sessões QA de 36 s; máximo Gamma declarado 2/16 | Confirmar auditoria final de performance no master | CP-D5-675/678 |
| Dev6 — ambiente | Adereços R5 grounded; água transparente R6 e atmosfera disponíveis | Confirmar materiais, vegetação e efeitos ambientais | APOIO-GAMMA-01/02 |
| Owners regionais | Candidatos isolados, rollback preparado | Autorizar promoção regional | CP-D5-680/681 |
| Dev5 — integração | Fronteiras limpas; X/Z preservado; grounding ≤0,05 m | Executar eventual integração apenas em commit separado | CP-D5-678/679 |

## Respostas técnicas

O grounding é resolvido por raycast e altera apenas Y, preservando X/Z cartográfico. A rota principal continua R4→R5→R6, com corredor auxiliar R5→R6. A iluminação Gamma permanece dentro do limite de 16 luzes dinâmicas; o máximo declarado nos candidatos é 2. Os previews não referenciam `ForestLakeRegion.gd`, `TempleLevel.gd` ou `Player.gd`.

A ausência de aprovação não representa bloqueio técnico: representa o gate correcto de revisão. Até que Dev3, Dev4, Dev6 e o proprietário regional emitam decisão, `PRODUCTION_MODULES_CHANGED=false` e `PROMOTION_AUTOMATIC=false` devem permanecer verdadeiros.

**STATUS_CODE: RESPONSE_MATRIX_READY / REVIEW_DECISIONS_PENDING / CP-D5-682.**
