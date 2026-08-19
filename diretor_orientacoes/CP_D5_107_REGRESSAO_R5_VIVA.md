# CP-D5-107 — Regressão da Clareira Majestic Viva R5

## Resultado

A cena `R5LivingMajesticPreview.tscn` foi revalidada após a sequência integrada R1–R6. O parser terminou com `PARSER_EXIT=0`; a sessão QA atingiu 36 segundos pelo timeout controlado e confirmou o corredor lateral e o pavilhão.

| Verificação | Resultado |
|---|---|
| Parser | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Grounding | 14 instâncias |
| Fauna | 2 cervos |
| Vegetação | 8 elementos |
| Abrigo | 3 partes |
| Pavilhão | Visível (`pavilion_visible=true`) |
| Rota | 1 ciclo `clear=true` |
| Distância fauna | 27,41 m |
| Cairn | Ausente (`cairn=false`) |
| Parede vegetal | Ausente (`wall_of_trees=false`) |
| Produção | 0 módulos alterados |

A regressão confirma que a clareira R5 mantém a leitura do pavilhão, o corredor lateral e a segurança da fauna. O log completo está em `CP-D5-107_R5_REGRESSION_RUNTIME.log`.
