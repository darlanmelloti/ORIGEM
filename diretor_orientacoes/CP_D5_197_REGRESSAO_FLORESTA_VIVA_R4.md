# CP-D5-197 — Regressão da floresta viva R4

## Resultado

A cena `R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A floresta viva manteve a passagem natural aberta, sem portal estrutural nem parede de árvores.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 8 elementos |
| Partes de abrigo | 2 |
| Elementos aterrados | 12 |
| Portal estrutural | `false` |
| Parede de árvores | `false` |
| Ciclos limpos | 3 |
| Distância fauna | 20,42–20,76 m |
| Módulos de produção alterados | `false` |

A regressão aprova a floresta viva R4, preservando a leitura orgânica e o corredor navegável. O log está em `CP-D5-197_R4_LIVING_FOREST_RUNTIME.log`.
