# CP-D5-307 — Regressão da composição vegetal R4/R5

`MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). As composições Floresta Densa e Acampamento Majestic mantiveram uma árvore PBR focal, três árvores médias e quatro elementos distantes por composição.

| Composição | Âncora | PBR | Médio | Distante | Parede de árvores |
|---|---:|---:|---:|---:|---|
| Floresta Densa | 4 | 1 | 3 | 4 | `false` |
| Acampamento Majestic | 5 | 1 | 3 | 4 | `false` |

Os offsets locais permanecem `(0,0)`, `production_script=false` e a composição continua compatível com os limites GTX 1050 Ti. Evidência completa: `CP-D5-307_VEGETATION_COMPOSITION_RUNTIME.log`.
