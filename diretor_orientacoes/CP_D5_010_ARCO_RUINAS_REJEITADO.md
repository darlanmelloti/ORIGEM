# CP-D5-010 — Arco das Ruínas: candidato QA rejeitado

**Marco cartográfico:** 3 — Arco das Ruínas, âncora `(-16,741; 48)`.  
**Estado:** rejeitado antes de integração; código QA revertido.

A cena QA confirmou que a estrutura tinha profundidade, abertura central e colisores locais, mas a captura de 36 segundos mostrou uma leitura ainda dominada por blocos primitivos, materiais planos e escombros sem ganho suficiente sobre o arco de produção já existente. O candidato não atingiu o limiar visual exigido para justificar duplicação, comparação A/B ou alteração do corredor Estrada→Arco.

> A decisão preserva a produção e evita introduzir uma segunda estrutura arqueada de qualidade inferior. O objecto não foi integrado em `RiverRoadJourney.gd`, e os scripts/cenas QA do candidato foram removidos do checkout Dev5.

## Evidência

A captura local `qa_evidence_dev5_arch/ruin_arch_refined.png` e a sessão de 36 segundos demonstraram a insuficiência visual. O parser Godot passou, mas validação técnica sem ganho artístico não é critério de promoção.

## Continuidade activa

Dev5 passa directamente a **CP-D5-011 — portal da Floresta Densa**. Este novo candidato não poderá repetir pilares/lintéis do arco; deverá usar troncos reais, rochas laterais irregulares e uma abertura central física, alinhada ao marco 4 do mapa.
