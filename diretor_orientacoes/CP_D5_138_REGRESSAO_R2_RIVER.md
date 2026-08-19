# CP-D5-138 — Regressão integrada da Estrada do Rio R2

## Resultado

A cena `R2LivingRiverRoadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A travessia confirmou dois elementos de fauna, quatro vegetações, dois elementos de abrigo, nove instâncias aterradas e ponte modular.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Travessias | 5, todas `bridge_crossed=true` |
| Ciclos livres | 5, todos `clear=true` |
| Distância fauna mínima | 12,08 m |
| Grounding | 9 |
| Ponte | Modular |
| Ponte GLB | Ausente |
| Parede vegetal | Ausente |
| Produção | Inalterada |

A regressão confirma o percurso R1→R2 com água/ponte e corredor de Elias preservados. O log está em `CP-D5-138_R2_RIVER_RUNTIME.log`.
