# CP-D5-102 — Validação da ficha de integração R1

## Resultado

O candidato `R1LivingVossExteriorPreview.tscn` foi validado em Godot headless Compatibility. O parser terminou com `PARSER_EXIT=0`; a sessão QA atingiu 36 segundos pelo timeout controlado e confirmou quatro ciclos de saída R1→R2 sem bloqueio.

| Verificação | Resultado |
|---|---|
| Parser | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Grounding | 8 instâncias |
| Fauna | 2 cervos |
| Elementos de horta | 5 |
| Casa Voss exterior | Confirmada (`waystation=true`) |
| Ciclos de rota | 4, todos `clear=true` |
| Distância mínima registada | 9,07 m |
| Casa de produção | Intacta (`house_production_touched=false`) |
| Porta | Intacta (`door_touched=false`) |
| Produção | 0 módulos alterados |

A validação confirma a saída aberta para R2, a fauna a mais de 5 m do corredor e a preservação explícita da porta e da casa de produção. O log completo está em `CP-D5-102_R1_INTEGRATION_RUNTIME.log`.
