# CP-D5-143 — Regressão da margem orgânica R6

## Resultado

A cena `R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A margem orgânica confirmou terreno irregular, monólito aterrado, folhagem e afloramentos sem recuperar a geometria rejeitada do cais.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Terreno orgânico | `true` |
| Grounding | 10 |
| Folhagem | 4 |
| Afloramentos | 5 |
| Monólito | Aterrado em `(52,260)`, Y 0,09 m |
| Ciclos de rota | 2, ambos `clear=true` |
| Cubos de margem | 0 |
| Lajes de cais | 0 |
| Parede vegetal | Ausente |
| Produção | Inalterada |

A regressão confirma o tratamento orgânico da margem R6 e preserva o corredor das Ruínas sem cais artificial. O log está em `CP-D5-143_R6_ORGANIC_RUNTIME.log`.
