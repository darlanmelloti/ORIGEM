# CP-D5-144 — Regressão integrada da Floresta Densa R4

## Resultado

A cena `R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição confirmou 2 elementos de fauna, 8 elementos de vegetação, 2 abrigos e 12 instâncias aterradas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Ciclos de rota | 3, todos `clear=true` |
| Distância fauna mínima | 20,42 m |
| Grounding | 12 |
| Portal estrutural | Ausente (`structural_portal=false`) |
| Parede vegetal | Ausente (`wall_of_trees=false`) |
| Produção | Inalterada |

A regressão confirma a transição R3→R4 com LOD/densidade vegetal controlados e corredor de Elias livre. O log está em `CP-D5-144_R4_FOREST_RUNTIME.log`.
