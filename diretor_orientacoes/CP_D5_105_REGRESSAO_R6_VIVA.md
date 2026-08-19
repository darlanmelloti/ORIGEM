# CP-D5-105 — Regressão da Margem Viva R6

## Resultado

A cena `R6LivingShorePreview.tscn` foi revalidada após as alterações remotas de suavização orgânica da margem. O parser terminou com `PARSER_EXIT=0`; a sessão QA atingiu 36 segundos pelo timeout controlado e confirmou a composição sem regressões de rota.

| Verificação | Resultado |
|---|---|
| Parser | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Grounding | 9 instâncias |
| Fauna | 2 cervos |
| Vegetação | 4 elementos |
| Ruína | 3 partes colapsadas |
| Travessia | 1 ciclo `clear=true` |
| Distância fauna | 20,08 m |
| Ruína colapsada | Confirmada (`collapsed_ruin=true`) |
| Cais | Ausente (`pier_slabs=0`) |
| Parede vegetal | Ausente (`wall_of_trees=false`) |
| Produção | 0 módulos alterados |

A regressão confirma que a margem suavizada preserva a travessia, a leitura de ruína de abrigo e a exclusão da linguagem de cais. A captura gráfica oficial de R6 continua dependente de viewport não-headless. O log completo está em `CP-D5-105_R6_REGRESSION_RUNTIME.log`.
