# CP-D5-099 — Validação da ficha de integração R6

## Resultado

A ficha da Margem Viva R6 foi validada contra `R6LivingShorePreview.tscn` em Godot headless Compatibility. O parser terminou com `PARSER_EXIT=0`; a QA atingiu 36 segundos pelo timeout controlado e confirmou a composição sem regressões de rota.

| Verificação | Resultado |
|---|---|
| Parser do projecto | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Fauna | 2 cervos |
| Vegetação | 4 elementos |
| Ruína | 3 partes aterradas |
| Grounding | 9 eventos confirmados |
| Corredor | Livre; `route_cycle=1`, `clear=true` |
| Distância fauna | 20,08 m no ciclo registado |
| Cais | Ausente (`pier_slabs=0`) |
| Parede vegetal | Ausente (`wall_of_trees=false`) |
| Ruína colapsada | Confirmada (`collapsed_ruin=true`) |
| Módulos de produção | 0 alterados |

A advertência FSR1, quando presente, pertence à configuração Compatibility e não invalida a execução. O log completo está em `CP-D5-099_R6_INTEGRATION_RUNTIME.log`.
