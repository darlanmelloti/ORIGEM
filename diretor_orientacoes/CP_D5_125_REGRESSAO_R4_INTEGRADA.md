# CP-D5-125 — Regressão integrada da Floresta Viva R4

## Resultado

A cena `R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição confirmou 2 cervos, 8 elementos vegetais, 2 partes de abrigo e 12 instâncias aterradas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Ciclos de rota | 3, todos `clear=true` |
| Distância fauna mínima | 20,42 m |
| Grounding | 12 |
| Portal estrutural | Ausente |
| Parede vegetal | Ausente |
| Produção | Inalterada |

A regressão confirma que os handoffs R5/R6 não degradaram o corredor R4 nem a composição vegetal dentro dos limites Dev5. O log está em `CP-D5-125_R4_INTEGRATED_RUNTIME.log`.
