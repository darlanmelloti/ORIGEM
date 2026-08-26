# ORIGEM — Isolamento do Afluente Cartográfico R4 044

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-MATERIAL-ISOLATION-044`
**Estado:** Diagnóstico aprovado; produção mantida intacta.

## Resultado determinístico

A prova isolada confirmou que a lâmina `LaminaDoAfluenteCartografico` possui envelope local de **29,502 m × 63,477 m** e usa o material lacustre partilhado `_create_lake_material()` com `depth_draw_opaque` e `ALPHA = 1.0`.

> A superfície clara observada em `arch_to_forest` não é marcador QA nem nova geometria. O efeito resulta da combinação de uma faixa de água visualmente ampla e material opaco, cujo comportamento também pode afetar a leitura R6.

## Limites preservados

Nenhum ficheiro de produção foi alterado nesta tarefa. Mantêm-se imutáveis a clareira Orion, corredor R4 ≥8 m, rotas, câmara, física, âncoras e orçamento de luz.

## Próxima tarefa recomendada

A eventual correção deve ser tratada como alteração partilhada R4/R6, limitada ao material existente e à prova de leitura do afluente. Deve preservar a geometria cartográfica, criar zero luzes/colisores/nós e passar cumulativamente R4 e R6 antes de publicação.
