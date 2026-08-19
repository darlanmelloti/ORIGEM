# CP-D5-126 — Regressão integrada da Margem Viva R6

## Resultado

A cena `R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição confirmou 2 cervos, 4 elementos vegetais, 3 partes de ruína colapsada e 9 instâncias aterradas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Ciclos de rota | 1, `clear=true` |
| Distância fauna | 20,08 m |
| Ruína | `collapsed_ruin=true` |
| Lajes de cais | 0 |
| Parede vegetal | Ausente |
| Grounding | 9 |
| Produção | Inalterada |

A regressão confirma que a margem R6 permanece integrada após os handoffs do mapa, sem recuperar cais rejeitado nem bloquear a chegada às Ruínas. O log está em `CP-D5-126_R6_INTEGRATED_RUNTIME.log`.
