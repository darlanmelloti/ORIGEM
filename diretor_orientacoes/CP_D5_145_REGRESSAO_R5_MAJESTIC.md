# CP-D5-145 — Regressão integrada do Acampamento Majestic R5

## Resultado

A cena `R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O pavilhão Majestic permaneceu visível, aterrado e separado do corredor lateral de Elias.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 |
| Vegetação | 8 |
| Partes de abrigo | 3 |
| Pavilhão | Visível e confirmado |
| Grounding | 14 |
| Ciclos livres | 1, `clear=true` |
| Distância fauna | 27,41 m |
| Cairn | Ausente (`cairn=false`) |
| Parede vegetal | Ausente (`wall_of_trees=false`) |
| Produção | Inalterada |

A regressão mantém a composição técnica R5, sem promover a aprovação visual rejeitada anteriormente. O log está em `CP-D5-145_R5_MAJESTIC_RUNTIME.log`.
