# CP-D5-173 — Regressão da floresta viva R4

## Resultado

A cena `R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição natural manteve a passagem de Elias sem portal estrutural ou parede de árvores.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 8 elementos |
| Partes de abrigo | 2 |
| Elementos aterrados | 12 |
| Portal estrutural | `false` |
| Parede de árvores | `false` |
| Distância fauna nos ciclos | 20,42–20,77 m |
| Ciclos limpos | 3 |
| Módulos de produção alterados | `false` |

A regressão aprova a floresta viva R4, sem repetir o portal rejeitado e com margem ampla para fauna. O log está em `CP-D5-173_R4_LIVING_FOREST_RUNTIME.log`.
