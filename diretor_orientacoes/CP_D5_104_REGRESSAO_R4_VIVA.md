# CP-D5-104 — Regressão da Floresta Densa Viva R4

## Resultado

A cena `R4LivingForestPreview.tscn` foi revalidada em Godot headless Compatibility. O parser terminou com `PARSER_EXIT=0`; a sessão QA atingiu 36 segundos pelo timeout controlado e confirmou três ciclos livres no corredor da Floresta Densa.

| Verificação | Resultado |
|---|---|
| Parser | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Grounding | 12 instâncias |
| Fauna | 2 cervos |
| Vegetação | 8 elementos dentro do limite LOD |
| Abrigo lateral | 2 partes |
| Ciclos de rota | 3, todos `clear=true` |
| Distância mínima registada | 20,42 m |
| Portal estrutural | Ausente (`structural_portal=false`) |
| Parede vegetal | Ausente (`wall_of_trees=false`) |
| Produção | 0 módulos alterados |

A regressão confirma o corredor R4 aberto e preserva a condição anterior de que a validação técnica não equivale a aprovação visual final: a captura gráfica oficial continua pendente no ambiente headless. O log completo está em `CP-D5-104_R4_REGRESSION_RUNTIME.log`.
