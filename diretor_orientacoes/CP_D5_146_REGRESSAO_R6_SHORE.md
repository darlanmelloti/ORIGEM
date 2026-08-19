# CP-D5-146 — Regressão integrada da margem viva R6

## Resultado

A cena `R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A margem confirmou dois elementos de fauna, quatro vegetações, três partes de ruína e nove instâncias aterradas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Ciclos de rota | 1, `clear=true` |
| Distância fauna | 20,08 m |
| Grounding | 9 |
| Ruína colapsada | Confirmada |
| Lajes de cais | 0 |
| Parede vegetal | Ausente |
| Produção | Inalterada |

A regressão confirma a chegada R5→R6 com corredor de Elias livre e sem reintroduzir o cais rejeitado. O log está em `CP-D5-146_R6_SHORE_RUNTIME.log`.
