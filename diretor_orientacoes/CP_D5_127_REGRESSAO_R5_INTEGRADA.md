# CP-D5-127 — Regressão integrada da Clareira Majestic R5

## Resultado

A cena `R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição confirmou 2 cervos, 8 elementos vegetais, 3 partes de abrigo, 14 instâncias aterradas e o pavilhão visível.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Ciclos de rota | 1, `clear=true` |
| Distância fauna | 27,41 m |
| Pavilhão | Visível |
| Grounding | 14 |
| Cairn | Ausente |
| Parede vegetal | Ausente |
| Produção | Inalterada |

A regressão confirma que a clareira Majestic permanece integrada, legível e compatível com o corredor R5→R6. O log está em `CP-D5-127_R5_INTEGRATED_RUNTIME.log`.
